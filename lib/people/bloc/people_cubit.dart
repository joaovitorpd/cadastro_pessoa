import 'package:cadastro_pessoa/people/bloc/people_state.dart';
import 'package:cadastro_pessoa/people/data/people_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/people.dart';

class PeopleCubit extends Cubit<PeopleState> {
  PeopleCubit() : super(InitialState()) {
    getPeopleList();
  }

  final peopleRepository = PeopleRepository();
  late List<People> peopleList;

  void selectDetailsPeople(People people) {
    emit(PeopleDetailState(people));
  }

  void selectEditPeople(People people) {
    emit(PeopleEditState(people));
  }

  void selectCreatePeople() {
    People people = People.empty();
    emit(PeopleCreateState(people));
  }

  void loadPeopleList() {
    emit(PeopleListState(peopleList));
  }

  void getPeopleList() {
    emit(LoadingState());
    peopleRepository.fetchPeople().then((x) {
      peopleList = x;
      emit(PeopleListState(peopleList));
    }).catchError((e) {
      emit(ErrorState(error: e.toString()));
    });
  }

  void createPeople(People people) {
    final errors = fieldValidate(people.name, people.email, people.details);

    if (errors.isEmpty) {
      var newPeople = peopleRepository.createPeople(pessoa: people);
      newPeople.then((x) {
        peopleList.add(x);
        emit(PeopleDetailState(x));
      }).catchError((e) {
        emit(ErrorState(error: e.toString()));
      });
    } else {
      emit(PeopleCreateState(people, errors: errors));
    }
  }

  void updatePeople(People people) {
    final errors = fieldValidate(people.name, people.email, people.details);

    if (errors.isEmpty) {
      var updatedPeople = peopleRepository.updatePeople(pessoa: people);
      updatedPeople.then((x) {
        peopleList[peopleList.indexWhere((x) => x.id == people.id)] = x;
        emit(PeopleDetailState(x));
      }).catchError((e) {
        emit(ErrorState(error: e.toString()));
      });
    } else {
      emit(PeopleEditState(people, errors: errors));
    }
  }

  Map<String, String> fieldValidate(
      String? name, String? email, String? details) {
    final errors = <String, String>{};

    if (name == null || name.isEmpty || name.length < 3) {
      errors['name'] = 'Nome é obrigatório (minimo 3 caracteres)!';
    }

    if (email == null || !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      errors['email'] = "Email inválido!";
    }

    if (details == null || details.isEmpty || details.length < 3) {
      errors['details'] = "Descrição é obrigatória (minimo 3 caracteres)!";
    }
    return errors;
  }

  void deletePeople(People people) {
    var deletPeople = peopleRepository.deletePeople(pessoa: people);
    deletPeople.then((x) {
      peopleList.removeWhere((x) => x.id == people.id);
      emit(PeopleListState(peopleList));
    }).catchError((e) {
      emit(ErrorState(error: e.toString()));
    });
  }
}
