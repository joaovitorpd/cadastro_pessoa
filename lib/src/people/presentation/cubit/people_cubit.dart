import 'dart:async';
import 'package:cadastro_pessoa/src/people/data/models/people_model.dart';
import 'package:cadastro_pessoa/src/people/domain/entities/people.dart';
import 'package:cadastro_pessoa/src/people/domain/usecases/create_people_usecase.dart';
import 'package:cadastro_pessoa/src/people/domain/usecases/delete_people_usecase.dart';
import 'package:cadastro_pessoa/src/people/domain/usecases/get_people_usecase.dart';
import 'package:cadastro_pessoa/src/people/domain/usecases/update_people_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'people_state.dart';

class PeopleCubit extends Cubit<PeopleState> {
  PeopleCubit({
    required CreatePeopleUsecase createPeople,
    required UpdatePeopleUsecase updatedPeople,
    required DeletePeopleUsecase deletePeople,
    required GetPeopleUsecase getPeople,
  })  : _createPeople = createPeople,
        _updatePeople = updatedPeople,
        _deletePeople = deletePeople,
        _getPeopleUsecase = getPeople,
        super(InitialState());

  final CreatePeopleUsecase _createPeople;
  final UpdatePeopleUsecase _updatePeople;
  final DeletePeopleUsecase _deletePeople;
  final GetPeopleUsecase _getPeopleUsecase;
  late List<People> cubitPeopleList = [const PeopleModel.empty()];

  final _nameController = BehaviorSubject<String?>.seeded(null);
  final _emailController = BehaviorSubject<String?>.seeded(null);
  final _detailsController = BehaviorSubject<String?>.seeded(null);

  //Stream getters
  Stream<String?> get nameStream =>
      _nameController.stream.transform(_validateName);
  Stream<String?> get emailStream =>
      _emailController.stream.transform(_validateEmail);
  Stream<String?> get detailsStream =>
      _detailsController.stream.transform(_validateDetails);

  //Sink setters
  void changeName(String? name) {
    _nameController.sink.add(name);
  }

  void changeEmail(String? email) {
    _emailController.sink.add(email);
  }

  void changeDetails(String? details) {
    _detailsController.sink.add(details);
  }

  Future<void> updatePeopleState() async {
    if (state is PeopleCreateState) {
      final currentState = state as PeopleCreateState;
      emit(currentState.copyWith(
        people: currentState.people.copyWith(
          name: _nameController.valueOrNull,
          email: _emailController.valueOrNull,
          details: _detailsController.valueOrNull,
        ),
        isNameValid: _validateNameSync(_nameController.valueOrNull),
        isEmailValid: _validateEmailSync(_emailController.valueOrNull),
        isDetailsValid: _validateDetailsSync(_detailsController.valueOrNull),
      ));
    } else if (state is PeopleEditState) {
      final currentState = state as PeopleEditState;
      emit(currentState.copyWith(
        people: currentState.people.copyWith(
          name: _nameController.valueOrNull,
          email: _emailController.valueOrNull,
          details: _detailsController.valueOrNull,
        ),
        isNameValid: _validateNameSync(_nameController.valueOrNull),
        isEmailValid: _validateEmailSync(_emailController.valueOrNull),
        isDetailsValid: _validateDetailsSync(_detailsController.valueOrNull),
      ));
    }
  }

  //Validators

  final _validateName = StreamTransformer<String?, String?>.fromHandlers(
      handleData: (name, sink) {
    if (name == null || name.isEmpty || name.length <= 3) {
      sink.addError('Nome é obrigatório (Minimo 4 caracteres)');
    } else {
      sink.add(name);
    }
  });

  final _validateEmail = StreamTransformer<String?, String?>.fromHandlers(
      handleData: (email, sink) {
    if (email == null || !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      sink.addError("Email inválido");
    } else {
      sink.add(email);
    }
  });

  final _validateDetails = StreamTransformer<String?, String?>.fromHandlers(
      handleData: (details, sink) {
    if (details == null || details.isEmpty || details.length < 8) {
      sink.addError('Detalhes é obrigatório (Minimo 8 caracteres)');
    } else {
      sink.add(details);
    }
  });

  // Synchronous validators for immediate UI feedback

  bool _validateNameSync(String? name) =>
      name != null ? name.isNotEmpty && name.length > 3 : false;
  bool _validateEmailSync(String? email) =>
      email != null ? RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email) : false;
  bool _validateDetailsSync(String? details) =>
      details != null ? details.isNotEmpty && details.length >= 8 : false;

  // Combine Streams for form validation
  Stream<bool> get isFormValid => Rx.combineLatest3(
        nameStream,
        emailStream,
        detailsStream,
        (name, email, details) => true,
      );

  // Method to select People to be Detailed

  Future<void> selectDetailsPeople({required People people}) async {
    var peopleToBeDetailed =
        cubitPeopleList[cubitPeopleList.indexWhere((x) => x.id == people.id)];
    emit(PeopleDetailState(peopleToBeDetailed as PeopleModel));
  }

  // Method to select People to be Edited

  Future<void> selectEditPeople({required PeopleModel people}) async {
    changeName(people.name);
    changeEmail(people.email);
    changeDetails(people.details);
    emit(PeopleEditState(people: people));
  }

  // Method to People Creation

  Future<void> selectCreatePeople() async {
    PeopleModel people = const PeopleModel.empty();
    changeName(people.name);
    changeEmail(people.email);
    changeDetails(people.details);
    emit(PeopleCreateState(people: people));
  }

  // Method to select People List
  Future<void> selectPeopleList() async {
    emit(PeopleListState(cubitPeopleList));
  }

  Future<void> createPeople({required PeopleModel people}) async {
    emit(LoadingState());

    final result = await _createPeople(CreatePeopleParams(
      people: people,
    ));

    result.fold(
      (failure) => emit(PeopleError(message: failure.errorMessage)),
      (people) {
        emit(PeopleDetailState(people));
        cubitPeopleList.add(people);
      },
    );
  }

  Future<void> updatePeople({required PeopleModel people}) async {
    emit(LoadingState());

    final result = await _updatePeople(UpdatePeopleParams(people: people));

    result.fold(
      (failure) => emit(PeopleError(message: failure.errorMessage)),
      (people) {
        cubitPeopleList[cubitPeopleList.indexWhere((x) => x.id == people.id)] =
            people;
        emit(PeopleDetailState(people));
      },
    );
  }

  Future<void> deletePeople({required PeopleModel people}) async {
    emit(LoadingState());

    final result = await _deletePeople(DeletePeopleParams(people: people));

    result.fold(
      (failure) => emit(PeopleError(message: failure.errorMessage)),
      (_) {
        cubitPeopleList.removeWhere((x) => x.id == people.id);
        emit(PeopleListState(cubitPeopleList));
      },
    );
  }

  Future<void> getPeople() async {
    emit(LoadingState());
    final result = await _getPeopleUsecase();

    result.fold(
      (failure) => emit(PeopleError(message: failure.errorMessage)),
      (peopleList) {
        cubitPeopleList = peopleList;
        emit(PeopleListState(peopleList));
      },
    );
  }
}
