import 'package:cadastro_pessoa/core/errors/failure.dart';
import 'package:cadastro_pessoa/src/people/domain/entities/people.dart';
import 'package:cadastro_pessoa/src/people/domain/repositories/people_repository.dart';
import 'package:cadastro_pessoa/src/people/domain/usecases/get_people_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'people_repository.mock.dart';

void main() {
  late PeopleRepository repository;
  late GetPeopleUsecase usecase;

  setUp(() {
    repository = MockPeopleRepo();
    usecase = GetPeopleUsecase(repository);
  });

  const tResponse = [People.empty()];

  test('shoud call [PeopleRepository.getPeople] and return [List<People>]',
      () async {
    //Arrange or STUB
    when(() => repository.getPeople())
        .thenAnswer((_) async => const Right(tResponse));

    //Act
    final result = await usecase();

    //Assert

    expect(result, const Right<dynamic, List<People>>(tResponse));

    verify(() => repository.getPeople()).called(1);

    verifyNoMoreInteractions(repository);
  });

  test(
      'should answer [APIFailure] when the'
      '[PeopleRepository.getPeople] fails', () async {
    //Arrange
    const failure = APIFailure(message: 'message', statusCode: 400);
    when(() => repository.getPeople())
        .thenAnswer((_) async => const Left(failure));

    //Act
    final result = await usecase();

    //Assert
    expect(result, const Left(failure));
    verify(() => repository.getPeople()).called(1);
    verifyNoMoreInteractions(repository);
  });
}
