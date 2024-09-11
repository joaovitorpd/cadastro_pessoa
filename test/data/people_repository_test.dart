// ignore_for_file: avoid_print
import 'dart:convert';
import 'package:cadastro_pessoa/people/data/people_repository.dart';
import 'package:cadastro_pessoa/people/models/people.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([Client])
import 'people_repository_test.mocks.dart';

void main() {
  late PeopleRepository repository;
  late MockClient mockClient;

  setUp(() {
    mockClient = MockClient();
    repository = PeopleRepository(client: mockClient);
  });

  group('PeopleRepository', () {
    test(
        'fetchPeople returns list of people if the http call completes successfully',
        () async {
      final responseJson = jsonEncode([
        {
          "id": "1",
          "name": "John Doe",
          "email": "john@email.com",
          "details": "Detalhes de John"
        },
        {
          "id": "2",
          "name": "Mary Joana",
          "email": "mary@email.com",
          "details": "Detalhes de Mary"
        }
      ]);
      
      when(mockClient.get(Uri.parse(repository.apiUrl)))
          .thenAnswer((_) async => Response(responseJson, 200));

      var people = await repository.fetchPeople();
      print("People fetched: ${people.length}");
      expect(people.length, 2); // Verifique se o valor é 2
      expect(people[0].name, "John Doe");
    });

    test(
        'fetchPeople throws an exception if the http call completes with an error',
        () {
      when(mockClient.get(Uri.parse(repository.apiUrl))).thenAnswer((_) async {
        print("Mocked GET request with error is called.");
        return Response('Not Found', 404);
      });

      expect(
        () async => await repository.fetchPeople(),
        throwsA(predicate((e) =>
            e is Exception &&
            e.toString() == 'Exception: Falha ao carregar Pessoa')),
      );
    });

    test(
        'createPeople returns a People if the http call completes successfully',
        () async {
      const people = People(
          id: '1',
          name: 'John Doe',
          email: 'john@email.com',
          details: 'Detalhes de John');
      final responseJson = jsonEncode(people.toJson());

      when(mockClient.post(
        Uri.parse('${repository.apiUrl}/'),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async {
        print("Mocked POST request is called.");
        return Response(responseJson, 201);
      });

      var result = await repository.createPeople(pessoa: people);
      expect(result.name, "John Doe");
    });
    test(
        'createPeople throws an exception if the http call completes with an error',
        () {
      const people = People(
          id: '1',
          name: 'John Doe',
          email: 'john@email.com',
          details: 'Detalhes de John');

      when(mockClient.post(
        Uri.parse('${repository.apiUrl}/'),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => Response('Internal Server Error', 500));

      expect(
        () async => await repository.createPeople(pessoa: people),
        throwsA(predicate((e) =>
            e is Exception &&
            e.toString() == 'Exception: Falha ao criar Pessoa')),
      );
    });

    test(
        'updatePeople returns updated People if the http call completes successfully',
        () async {
      const people = People(
          id: '1',
          name: 'John Doe',
          email: 'john@email.com',
          details: 'Detalhes de John');
      final responseJson = jsonEncode(people.toJson());

      when(mockClient.post(
        Uri.parse('${repository.apiUrl}/'),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async {
        print("2 Mocked POST request is called.");
        return Response(responseJson, 201);
      });
      var createResult = await repository.createPeople(pessoa: people);
      expect(createResult.name, "John Doe");

      const updatedPeople = People(
          id: '1',
          name: 'John Updated',
          email: 'john@email.com',
          details: 'Detalhes de John Updated');
      final updateResponseJson = jsonEncode(updatedPeople.toJson());

      when(mockClient.put(
        Uri.parse('${repository.apiUrl}/${people.id}'),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async {
        print("Mocked PUT request is called.");
        return Response(updateResponseJson, 200);
      });

      var updateResult = await repository.updatePeople(pessoa: updatedPeople);
      expect(updateResult.name, "John Updated");
    });

    test(
        'updatePeople throws an exception with the correct message if the http call completes with an error',
        () async {
      const person = People(
          id: '1',
          name: 'John Doe',
          email: 'john@email.com',
          details: 'Detalhes de John');

      when(mockClient.put(
        Uri.parse('${repository.apiUrl}/${person.id}'),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => Response('Internal Server Error', 500));

      expect(
        () async => await repository.updatePeople(pessoa: person),
        throwsA(predicate((e) =>
            e is Exception &&
            e.toString() == 'Exception: Falha ao atualizar Pessoa')),
      );
    });

    test('deletePeople completes if the http call completes successfully',
        () async {
      const people = People(
          id: '1',
          name: 'John Doe',
          email: 'john@email.com',
          details: 'Detalhes de John');

      when(mockClient.delete(
        Uri.parse('${repository.apiUrl}/${people.id}'),
        headers: anyNamed('headers'),
      )).thenAnswer((_) async {
        print("Mocked DELETE request is called.");
        return Response('', 200);
      });

      await repository.deletePeople(pessoa: people);
      verify(mockClient.delete(
        Uri.parse('${repository.apiUrl}/${people.id}'),
        headers: anyNamed('headers'),
      )).called(1);
    });
    // Teste para deletePeople
    test(
        'deletePeople throws an exception with the correct message if the http call completes with an error',
        () async {
      const person = People(
          id: '1',
          name: 'John Doe',
          email: 'john@email.com',
          details: 'Detalhes de John');

      // Configuração do stub com todos os argumentos usados no método delete
      when(mockClient.delete(
        Uri.parse('${repository.apiUrl}/${person.id}'),
        headers: {'Content-Type': 'application/json'},
      )).thenAnswer((_) async => Response('Internal Server Error', 500));

      expect(
        () async => await repository.deletePeople(pessoa: person),
        throwsA(predicate((e) =>
            e is Exception &&
            e.toString() == 'Exception: Falha ao deletar Pessoa!')),
      );
    });
  });
}
