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

  void selectPersonToDetail(People people) {
    emit(PeopleDetailState(people));
  }

  void selectPersonToEdit(People people) {
    emit(PeopleEditState(people));
  }

  void loadPeopleList() {
    emit(LoadedState(peopleList));
  }

  void getPeopleList() async {
    try {
      emit(LoadingState());
      peopleList = await peopleRepository.fetchPeople();
      emit(LoadedState(peopleList));
    } catch (e) {
      emit(ErrorState());
    }
  }

  void createPeople(People people) {
    try {
      emit(LoadingState());
      var newPeople = peopleRepository.createPeople(pessoa: people);
      newPeople.then((x) {
        peopleList.add(x);
        emit(LoadedState(peopleList));
      });
    } catch (e) {
      emit(ErrorState());
    }
  }

  void updatePeople(People people) {
    try {
      emit(LoadingState());
      var updatedPeople = peopleRepository.updatePeople(pessoa: people);
      updatedPeople.then((x) {
        peopleList[peopleList.indexWhere((x) => x.id == people.id)] = people;
        // emit(LoadedState(peopleList));
        emit(PeopleDetailState(people));
      });
    } catch (e) {
      emit(ErrorState());
    }
  }

  void deletePeople(People people) async {
    try {
      emit(LoadingState());
      peopleRepository.deletePeople(pessoa: people);
      peopleList.removeWhere((x) => x.id == people.id);
      emit(LoadedState(peopleList));
    } catch (e) {
      emit(ErrorState());
    }
  }
}
