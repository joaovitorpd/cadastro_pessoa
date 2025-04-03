import 'dart:convert';

import 'package:cadastro_pessoa/core/utils/typedef.dart';
import 'package:cadastro_pessoa/src/people/data/models/people_model.dart';
import 'package:cadastro_pessoa/src/people/domain/entities/people.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  //Arrange
  const tModel = PeopleModel.empty();

  test('should be a subclass of [People] entity', () {
    //Act - No need to act becaouse there is no method to evaluate

    //Assert
    expect(tModel, isA<People>());
  });

  final tJson = fixture('people.json');
  final tMap = jsonDecode(tJson) as DataMap;

  group('fromMap', () {
    test('should return a [PeopleModel] with the right data', () {
      //Act
      final result = PeopleModel.fromMap(tMap);

      //Assert
      expect(result, tModel);
    });
  });

  group('fromJson', () {
    test('should return a [PeopleModel] with the right data', () {
      //Act
      final result = PeopleModel.fromJson(tJson);

      //Assert
      expect(result, tModel);
    });
  });

  group('toMap', () {
    test('should return a [Map] with the right data', () {
      //Act
      final result = tModel.toMap();

      //Assert
      expect(result, tMap);
    });
  });

  group('toJson', () {
    test('should return a [JSON] string with the right data', () {
      //Arrange
      final tJson = jsonEncode(
          {"id": null, "name": null, "email": null, "details": null});

      //Act
      final result = tModel.toJson();

      //Assert
      expect(result, tJson);
    });
  });

  group('copyWith', () {
    test('should return a [PeopleModel] with different data', () {
      //Arrange
      var initialPeople = const PeopleModel.empty();
      var newPeople = const PeopleModel(
          id: '01',
          name: 'João Vitor',
          email: 'jvpd@gmail.com',
          details: 'Desenvolvedor');

      //Act
      final result = initialPeople.copyWith(
          id: '01',
          name: 'João Vitor',
          email: 'jvpd@gmail.com',
          details: 'Desenvolvedor');

      //Assert
      expect(result, newPeople);
      expect(result, isA<PeopleModel>());
    });
  });
}
