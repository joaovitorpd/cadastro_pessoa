import 'package:cadastro_pessoa/core/errors/failure.dart';
import 'package:cadastro_pessoa/src/people/data/models/people_model.dart';
import 'package:cadastro_pessoa/src/people/domain/repositories/people_repository.dart';
import 'package:cadastro_pessoa/src/people/domain/usecases/delete_people_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'people_repository.mock.dart';

void main() {
  late DeletePeopleUsecase usecase;
  late PeopleRepository repository;

  setUp(() {
    repository = MockPeopleRepo();
    usecase = DeletePeopleUsecase(repository);
    registerFallbackValue(const PeopleModel.empty());
  });

  const params = DeletePeopleParams.empty();

  test('should call the [PeopleRepository.deletePeople]', () async {
    //Arrange
    when(() => repository.deletePeople(people: any(named: 'people')))
        .thenAnswer((_) async => const Right(null));

    //Act
    final result = await usecase(params);

    //Assert
    expect(result, const Right(null));
    verify(() => repository.deletePeople(people: params.people)).called(1);
    verifyNoMoreInteractions(repository);
  });

  test('should answer [APIFailure] when [PeopleRepository.deletePeople] fails',
      () async {
    //Arrange
    const failure = APIFailure(message: 'message', statusCode: 400);
    when(() => repository.deletePeople(people: any(named: 'people')))
        .thenAnswer((_) async => const Left(failure));

    //Act
    final result = await usecase(params);

    //Assert
    expect(result, const Left(failure));
    verify(() => repository.deletePeople(people: params.people)).called(1);
    verifyNoMoreInteractions(repository);
  });
}
