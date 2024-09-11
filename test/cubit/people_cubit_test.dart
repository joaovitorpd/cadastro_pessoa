import 'dart:convert';
import 'package:cadastro_pessoa/people/cubit/people_state.dart';
import 'package:cadastro_pessoa/people/data/people_repository.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:test/test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:cadastro_pessoa/people/cubit/people_cubit.dart';
import 'package:http/testing.dart';

@GenerateMocks([Client])
void main() {
  group('PeopleCubit', () {
    late PeopleCubit peopleCubit;
    late PeopleRepository repository;
    late MockClient mockClient;

    setUp(() {
      mockClient = MockClient((request) async {
        if (request.url.path != 'data.json') {
          return Response("", 404);
        }
        return Response(
            json.encode({
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
            }),
            200,
            headers: {'content-type': 'application/json'});
      });
      repository = PeopleRepository(client: mockClient);
      peopleCubit =
          PeopleCubit(client: mockClient, peopleRepository: repository);
    });

    // Video at => 1:32:05
    test('Initial state is LoadingState', () async {
      expect(peopleCubit.state, LoadingState());
    });
  });

  group('Get People List', () {
    late PeopleCubit peopleCubit;
    late PeopleRepository repository;
    late MockClient mockClient;

    setUp(() {
      mockClient = MockClient((request) async {
        if (request.url.path != '/data.json') {
          return Response("", 404);
        }
        return Response(
            json.encode({
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
            }),
            200,
            headers: {'content-type': 'application/json'});
      });
      repository = PeopleRepository(client: mockClient);
      peopleCubit =
          PeopleCubit(client: mockClient, peopleRepository: repository);
    });

    blocTest(
      'Get People List in start',
      build: () => peopleCubit,
      skip: 1,
      expect: () => <PeopleListState>[],
    );
  });
}
