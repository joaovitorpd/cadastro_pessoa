// 3 Questions that we make before writing a test:
// 1) What does the class depend on?
// Answer -- PeopleRepository
// 2) How can we create a fake version of the dependency
// Answer -- Use Mocktail or Mockito (We'll use Mocktail)
// 3) How do we control what our depencencies do?
// Answer -- Using Mocktail's APIs

import 'package:cadastro_pessoa/core/errors/failure.dart';
import 'package:cadastro_pessoa/src/people/data/models/people_model.dart';
import 'package:cadastro_pessoa/src/people/domain/entities/people.dart';
import 'package:cadastro_pessoa/src/people/domain/repositories/people_repository.dart';
import 'package:cadastro_pessoa/src/people/domain/usecases/create_people_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'people_repository.mock.dart';

void main() {
  late CreatePeopleUsecase usecase;
  late PeopleRepository repository;

  setUp(() {
    repository = MockPeopleRepo();
    usecase = CreatePeopleUsecase(repository);
    registerFallbackValue(const PeopleModel.empty());
  });

  const params = CreatePeopleParams.empty();
  const people = PeopleModel.empty();

  test('should call the [PeopleRepository.createPeople]', () async {
    //Arrange
    //STUB
    when(
      () => repository.createPeople(
        people: people,
      ),
    ).thenAnswer((_) async => const Right(people));

    //Act
    final result = await usecase(params);

    //Assert
    expect(
        result,
        const Right<dynamic, People>(
            people)); //Use dynamic instead of Failure type, so that we don't need to import unnecessary dependency
    verify(() => repository.createPeople(people: people)).called(1);

    verifyNoMoreInteractions(repository);
  });

  test(
      'should answer [APIFailure] when the'
      '[PeopleRepository.createPeople] fails', () async {
    //Arrange
    const failure = APIFailure(message: 'message', statusCode: 400);
    when(
      () => repository.createPeople(
        people: any(named: 'people'),
      ),
    ).thenAnswer((_) async => const Left(failure));

    //Act
    final result = await usecase(params);

    //Assert
    expect(result, const Left(failure));
    verify(() => repository.createPeople(
          people: params.people,
        )).called(1);
    verifyNoMoreInteractions(repository);
  });
}
