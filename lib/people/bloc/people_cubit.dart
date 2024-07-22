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
    var newPeople = peopleRepository.createPeople(pessoa: people);
    newPeople.then((x) {
      peopleList.add(x);
      emit(PeopleDetailState(x));
    }).catchError((e) {
      emit(ErrorState(error: e.toString()));
    });
  }

  void updatePeople(People people) {
    var updatedPeople = peopleRepository.updatePeople(pessoa: people);
    updatedPeople.then((x) {
      peopleList[peopleList.indexWhere((x) => x.id == people.id)] = x;
      emit(PeopleDetailState(x));
    }).catchError((e) {
      emit(ErrorState(error: e.toString()));
    });
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
