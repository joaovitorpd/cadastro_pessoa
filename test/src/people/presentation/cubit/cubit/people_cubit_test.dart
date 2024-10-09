import 'package:bloc_test/bloc_test.dart';
import 'package:cadastro_pessoa/core/errors/failure.dart';
import 'package:cadastro_pessoa/src/people/data/models/people_model.dart';
import 'package:cadastro_pessoa/src/people/domain/usecases/create_people_usecase.dart';
import 'package:cadastro_pessoa/src/people/domain/usecases/delete_people_usecase.dart';
import 'package:cadastro_pessoa/src/people/domain/usecases/get_people_usecase.dart';
import 'package:cadastro_pessoa/src/people/domain/usecases/update_people_usecase.dart';
import 'package:cadastro_pessoa/src/people/presentation/cubit/people_cubit.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCreatePeople extends Mock implements CreatePeopleUsecase {}

class MockUpdatePeople extends Mock implements UpdatePeopleUsecase {}

class MockDeletePeople extends Mock implements DeletePeopleUsecase {}

class MockGetPeople extends Mock implements GetPeopleUsecase {}

void main() {
  late CreatePeopleUsecase createPeople;
  late UpdatePeopleUsecase updatePeople;
  late DeletePeopleUsecase deletePeople;
  late GetPeopleUsecase getPeople;
  late PeopleCubit cubit;

  const tCreatePeopleParams = CreatePeopleParams.empty();
  const tAPIFailure = APIFailure(message: 'message', statusCode: 400);
  const tPeople = PeopleModel.empty();

  setUp(() {
    getPeople = MockGetPeople();
    createPeople = MockCreatePeople();
    updatePeople = MockUpdatePeople();
    deletePeople = MockDeletePeople();
    cubit = PeopleCubit(
      createPeople: createPeople,
      updatedPeople: updatePeople,
      deletePeople: deletePeople,
      getPeople: getPeople,
    );
    registerFallbackValue(tCreatePeopleParams);
    registerFallbackValue(tPeople);
  });

  tearDown(() => cubit.close());

  test('initial state should be [LoadingState()]', () async {
    expect(cubit.state, InitialState());
  });

  group('createPeople', () {
    blocTest<PeopleCubit, PeopleState>(
      'should emit [CreatingPeople, PeopleCreated] when successful.',
      build: () {
        when(() => createPeople(any())).thenAnswer(
          (_) async => const Right(tPeople),
        );
        return cubit;
      },
      act: (cubit) => cubit.createPeople(
        people: tPeople,
      ),
      expect: () => [
        LoadingState(),
        PeopleDetailState(tPeople),
      ],
      verify: (_) {
        verify(() => createPeople(tCreatePeopleParams)).called(1);
        verifyNoMoreInteractions(createPeople);
      },
    );

    blocTest<PeopleCubit, PeopleState>(
      'should emit [CreatingPeople, PeopleError] when unsuccessful',
      build: () {
        when(() => createPeople(any())).thenAnswer(
          (_) async => const Left(tAPIFailure),
        );
        return cubit;
      },
      act: (cubit) => cubit.createPeople(
        people: tPeople,
      ),
      expect: () => [
        LoadingState(),
        PeopleError(message: tAPIFailure.errorMessage),
      ],
      verify: (_) {
        verify(() => createPeople(tCreatePeopleParams)).called(1);
        verifyNoMoreInteractions(createPeople);
      },
    );
  });

  group('getPeople', () {
    blocTest<PeopleCubit, PeopleState>(
      'shoud emit a [GettingPeople, PeopleLoaded] when successful',
      build: () {
        when(() => getPeople()).thenAnswer(
          (_) async => const Right([]),
        );
        return cubit;
      },
      act: (cubit) => cubit.getPeople(),
      expect: () => [
        LoadingState(),
        PeopleListState(const []),
      ],
      verify: (_) => {
        verify(() => getPeople()).called(1),
        verifyNoMoreInteractions(getPeople),
      },
    );
    blocTest<PeopleCubit, PeopleState>(
      'should emit a [GettingPeople, PeopleError] when unsuccessful',
      build: () {
        when(() => getPeople()).thenAnswer(
          (_) async => const Left(tAPIFailure),
        );
        return cubit;
      },
      act: (cubit) => cubit.getPeople(),
      expect: () => [
        LoadingState(),
        PeopleError(message: tAPIFailure.errorMessage),
      ],
      verify: (_) => {
        verify(() => getPeople()).called(1),
        verifyNoMoreInteractions(getPeople),
      },
    );
  });
}
