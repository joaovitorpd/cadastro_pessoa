import 'package:cadastro_pessoa/people/models/people.dart';
import 'package:equatable/equatable.dart';

abstract class PeopleState extends Equatable {}

class InitialState extends PeopleState {
  @override
  List<Object?> get props => [];
}

class LoadingState extends PeopleState {
  @override
  List<Object?> get props => [];
}

class PeopleListState extends PeopleState {
  PeopleListState(this.peopleList);

  final List<People> peopleList;

  @override
  List<Object?> get props => [peopleList];
}

class PeopleDetailState extends PeopleState {
  PeopleDetailState(this.people);

  final People people;

  @override
  List<Object?> get props => [people];
}

class PeopleEditState extends PeopleState {
  PeopleEditState(this.people);

  final People people;

  @override
  List<Object?> get props => [people];
}

class PeopleCreateState extends PeopleState {
  PeopleCreateState(this.people);

  final People people;

  @override
  List<Object?> get props => [people];
}

class ErrorState extends PeopleState {
  ErrorState({required this.error});

  final String error;

  @override
  List<Object?> get props => [error];
}
