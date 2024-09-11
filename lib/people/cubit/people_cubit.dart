import 'dart:async';
import 'package:cadastro_pessoa/people/cubit/people_state.dart';
import 'package:cadastro_pessoa/people/data/people_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:rxdart/rxdart.dart';
import '../models/people.dart';

class PeopleCubit extends Cubit<PeopleState> {
  PeopleCubit({required this.client, required this.peopleRepository})
      : super(InitialState()) {
    getPeopleList();
  }

  final _nameController = BehaviorSubject<String?>.seeded(null);
  final _emailController = BehaviorSubject<String?>.seeded(null);
  final _detailsController = BehaviorSubject<String?>.seeded(null);

  final Client client;
  final PeopleRepository peopleRepository;

  late List<People> peopleList;

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

  void updatePeopleState() {
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

  void selectDetailsPeople(People people) {
    var peopleToBeDetailed =
        peopleList[peopleList.indexWhere((x) => x.id == people.id)];
    emit(PeopleDetailState(peopleToBeDetailed));
  }

  // Method to select People to be Edited

  void selectEditPeople(People people) {
    changeName(people.name!);
    changeEmail(people.email!);
    changeDetails(people.details!);
    emit(PeopleEditState(people: people));
  }

  // Method to People Creation

  void selectCreatePeople() {
    People people = const People.empty();
    changeName(people.name);
    changeEmail(people.email);
    changeDetails(people.details);
    emit(PeopleCreateState(people: people));
  }

  // Method to select People List
  void selectPeopleList() {
    emit(PeopleListState(peopleList));
  }

  // Method to get People from API

  void getPeopleList() {
    emit(LoadingState());
    Future.delayed(const Duration(microseconds: 1000));
    peopleRepository.fetchPeople().then((x) {
      peopleList = x;
      emit(PeopleListState(peopleList));
    }).catchError((e) {
      emit(ErrorState(error: e.toString()));
    });
  }

  // Method to create People on API

  void createPeople(People people) {
    var newPeople = peopleRepository.createPeople(pessoa: people);
    newPeople.then((x) {
      peopleList.add(x);
      emit(PeopleDetailState(x));
    }).catchError((e) {
      emit(ErrorState(error: e.toString()));
    });
  }

  // Method to update/put People on API
  void updatePeople(People people) {
    var updatedPeople = peopleRepository.updatePeople(pessoa: people);
    updatedPeople.then((x) {
      peopleList[peopleList.indexWhere((x) => x.id == people.id)] = x;
      emit(PeopleDetailState(x));
    }).catchError((e) {
      emit(ErrorState(error: e.toString()));
    });
  }

  // Method to delete People on API
  void deletePeople(People people) {
    var deletePeople = peopleRepository.deletePeople(pessoa: people);
    deletePeople.then((x) {
      peopleList.removeWhere((x) => x.id == people.id);
      emit(PeopleListState(peopleList));
    }).catchError((e) {
      emit(ErrorState(error: e.toString()));
    });
  }
}
