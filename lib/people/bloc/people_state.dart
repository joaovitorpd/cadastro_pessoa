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
  PeopleEditState({
    required this.people,
    this.isNameValid = true,
    this.isEmailValid = true,
    this.isDetailsValid = true,
  });

  final People people;
  final bool isNameValid;
  final bool isEmailValid;
  final bool isDetailsValid;

  PeopleEditState copyWith({
    People? people,
    bool? isNameValid,
    bool? isEmailValid,
    bool? isDetailsValid,
  }) {
    return PeopleEditState(
      people: people ?? this.people,
      isNameValid: isNameValid ?? this.isNameValid,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isDetailsValid: isDetailsValid ?? this.isDetailsValid,
    );
  }

  @override
  List<Object?> get props =>
      [people, isNameValid, isEmailValid, isDetailsValid];
}

class PeopleCreateState extends PeopleState {
  PeopleCreateState({
    required this.people,
    this.isNameValid = true,
    this.isEmailValid = true,
    this.isDetailsValid = true,
  });

  final People people;
  final bool isNameValid;
  final bool isEmailValid;
  final bool isDetailsValid;

  PeopleCreateState copyWith({
    People? people,
    bool? isNameValid,
    bool? isEmailValid,
    bool? isDetailsValid,
  }) {
    return PeopleCreateState(
      people: people ?? this.people,
      isNameValid: isNameValid ?? this.isNameValid,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isDetailsValid: isDetailsValid ?? this.isDetailsValid,
    );
  }

  @override
  List<Object?> get props =>
      [people, isNameValid, isEmailValid, isDetailsValid];
}

class ErrorState extends PeopleState {
  ErrorState({required this.error});

  final String error;

  @override
  List<Object?> get props => [error];
}
