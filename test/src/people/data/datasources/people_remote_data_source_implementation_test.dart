import 'dart:convert';

import 'package:cadastro_pessoa/core/errors/exceptions.dart';
import 'package:cadastro_pessoa/core/utils/constants.dart';
import 'package:cadastro_pessoa/src/people/data/datasources/people_remote_data_source_implementation.dart';
import 'package:cadastro_pessoa/src/people/data/models/people_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  late http.Client client;
  late PeopleRemoteDataSourceImplementation remoteDataSource;

  setUp(() {
    client = MockClient();
    remoteDataSource = PeopleRemoteDataSourceImplementation(client);
    registerFallbackValue(Uri());
    registerFallbackValue(const PeopleModel.empty());
  });

  const people =
      PeopleModel(id: 'id', name: 'name', email: 'email', details: 'details');

  group('createPeople', () {
    test('should complete successfuly when the status code is 200 or 201',
        () async {
      //Arrange
      when(() => client.post(
            any(),
            headers: {
              'Content-Type': 'application/json',
            },
            body: any(named: 'body'),
          )).thenAnswer((_) async => http.Response(people.toJson(), 201));
      //Act
      final methodCall = remoteDataSource.createPeople;

      //Assert
      expect(
          methodCall(
            people: people,
          ),
          completes);

      verify(
        () => client.post(
          Uri.parse(kBaseUrl),
          headers: {
            'Content-Type': 'application/json',
          },
          body: people.toJson(),
        ),
      ).called(1);
      verifyNoMoreInteractions(client);
    });

    test('shoud throw [APIException] when the status code is not 200 or 201',
        () async {
      //Arrange
      when(() => client.post(
            any(),
            body: any(named: 'body'),
            headers: {
              'Content-Type': 'application/json',
            },
          )).thenAnswer(
        (_) async => http.Response('Invalid data', 400),
      );

      //Act
      final methodCall = remoteDataSource.createPeople;

      //Assert
      expect(
        () async => methodCall(
          people: people,
        ),
        throwsA(
          const ApiException(
            message: 'Invalid data',
            statusCode: 400,
          ),
        ),
      );

      verify(
        () => client.post(
          Uri.parse(kBaseUrl),
          body: people.toJson(),
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      ).called(1);

      verifyNoMoreInteractions(client);
    });
  });

  group('getPeopleList', () {
    test('should return a [List<People>] when the status code is 200',
        () async {
      //Arrange
      const responseList = [PeopleModel.empty()];

      when(() => client.get(any())).thenAnswer(
        (_) async =>
            http.Response(jsonEncode([responseList.first.toMap()]), 200),
      );

      //Act
      final result = await remoteDataSource.getPeople();

      //Assert

      expect(result, responseList);

      verify(() => client.get(Uri.parse(kBaseUrl))).called(1);

      verifyNoMoreInteractions(client);
    });

    test('should throw [APIException] when the status code is not 200',
        () async {
      //Arrange
      when(() => client.get(any()))
          .thenAnswer((_) async => http.Response('Server Down', 500));

      //Act
      final methodCall = remoteDataSource.getPeople;

      expect(
        () => methodCall(),
        throwsA(
          const ApiException(
            message: 'Server Down',
            statusCode: 500,
          ),
        ),
      );

      verify(() => client.get(Uri.parse(kBaseUrl))).called(1);

      verifyNoMoreInteractions(client);
    });
  });
}
