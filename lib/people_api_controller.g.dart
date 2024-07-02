// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'people_api_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PeopleApiController on _PeopleApiControllerBase, Store {
  late final _$peopleAtom =
      Atom(name: '_PeopleApiControllerBase.people', context: context);

  @override
  People get people {
    _$peopleAtom.reportRead();
    return super.people;
  }

  @override
  set people(People value) {
    _$peopleAtom.reportWrite(value, super.people, () {
      super.people = value;
    });
  }

  late final _$peopleListAtom =
      Atom(name: '_PeopleApiControllerBase.peopleList', context: context);

  @override
  ObservableList<People> get peopleList {
    _$peopleListAtom.reportRead();
    return super.peopleList;
  }

  bool _peopleListIsInitialized = false;

  @override
  set peopleList(ObservableList<People> value) {
    _$peopleListAtom.reportWrite(
        value, _peopleListIsInitialized ? super.peopleList : null, () {
      super.peopleList = value;
      _peopleListIsInitialized = true;
    });
  }

  late final _$peopleFutureListAtom =
      Atom(name: '_PeopleApiControllerBase.peopleFutureList', context: context);

  @override
  ObservableFuture<List<People>> get peopleFutureList {
    _$peopleFutureListAtom.reportRead();
    return super.peopleFutureList;
  }

  bool _peopleFutureListIsInitialized = false;

  @override
  set peopleFutureList(ObservableFuture<List<People>> value) {
    _$peopleFutureListAtom.reportWrite(
        value, _peopleFutureListIsInitialized ? super.peopleFutureList : null,
        () {
      super.peopleFutureList = value;
      _peopleFutureListIsInitialized = true;
    });
  }

  late final _$_PeopleApiControllerBaseActionController =
      ActionController(name: '_PeopleApiControllerBase', context: context);

  @override
  dynamic selectedPeople(People selectecPeople) {
    final _$actionInfo = _$_PeopleApiControllerBaseActionController.startAction(
        name: '_PeopleApiControllerBase.selectedPeople');
    try {
      return super.selectedPeople(selectecPeople);
    } finally {
      _$_PeopleApiControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<People> createPeople(People selectedPeople) {
    final _$actionInfo = _$_PeopleApiControllerBaseActionController.startAction(
        name: '_PeopleApiControllerBase.createPeople');
    try {
      return super.createPeople(selectedPeople);
    } finally {
      _$_PeopleApiControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<People> updatePeople(People selectedPeople) {
    final _$actionInfo = _$_PeopleApiControllerBaseActionController.startAction(
        name: '_PeopleApiControllerBase.updatePeople');
    try {
      return super.updatePeople(selectedPeople);
    } finally {
      _$_PeopleApiControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<dynamic> deletePeople(People selectedPeople) {
    final _$actionInfo = _$_PeopleApiControllerBaseActionController.startAction(
        name: '_PeopleApiControllerBase.deletePeople');
    try {
      return super.deletePeople(selectedPeople);
    } finally {
      _$_PeopleApiControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void getPeople() {
    final _$actionInfo = _$_PeopleApiControllerBaseActionController.startAction(
        name: '_PeopleApiControllerBase.getPeople');
    try {
      return super.getPeople();
    } finally {
      _$_PeopleApiControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
people: ${people},
peopleList: ${peopleList},
peopleFutureList: ${peopleFutureList}
    ''';
  }
}
