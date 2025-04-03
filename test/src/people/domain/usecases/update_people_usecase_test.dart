import 'package:cadastro_pessoa/core/errors/failure.dart';
import 'package:cadastro_pessoa/src/people/data/models/people_model.dart';
import 'package:cadastro_pessoa/src/people/domain/entities/people.dart';
import 'package:cadastro_pessoa/src/people/domain/repositories/people_repository.dart';
import 'package:cadastro_pessoa/src/people/domain/usecases/update_people_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'people_repository.mock.dart';

void main() {
  late UpdatePeopleUsecase usecase;
  late PeopleRepository repository;

  setUp(() {
    repository = MockPeopleRepo();
    usecase = UpdatePeopleUsecase(repository);
  });

  const params = UpdatePeopleParams.empty();
  const people = PeopleModel.empty();

  test('should call the [PeopleRepository.updatePeople]', () async {
    //Arrange
    when(() => repository.updatePeople(
          people: people,
        )).thenAnswer((_) async => const Right(people));

    //Act
    final result = await usecase(params);

    //Assert
    expect(result, const Right<dynamic, People>(people));
    verify(() => repository.updatePeople(
          people: params.people,
        )).called(1);
    verifyNoMoreInteractions(repository);
  });

  test(
      'should answer [APIFailure] when the [PeopleRepository.updatePeople] fails',
      () async {
    //Arrange
    const failure = APIFailure(message: 'message', statusCode: 400);
    when(() => repository.updatePeople(
          people: people,
        )).thenAnswer((_) async => const Left(failure));

    //Act
    final result = await usecase(params);

    //Assert
    expect(result, const Left(failure));
    verify(() => repository.updatePeople(
          people: people,
        )).called(1);
    verifyNoMoreInteractions(repository);
  });
}
