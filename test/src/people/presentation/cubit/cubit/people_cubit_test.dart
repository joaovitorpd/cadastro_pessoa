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
  const tUpdatePeopleParams = UpdatePeopleParams.empty();
  const tDeletePeopleParams = DeletePeopleParams.empty();
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
    registerFallbackValue(tUpdatePeopleParams);
    registerFallbackValue(tDeletePeopleParams);
    registerFallbackValue(tPeople);
  });

  tearDown(() => cubit.close());

  test('initial state should be [LoadingState()]', () async {
    expect(cubit.state, InitialState());
  });

  group('state changind functions', () {
    test('selectDetailsPeople should emit [PeopleDetaisState]', () {
      //act
      cubit.selectDetailsPeople(people: tPeople);

      expect(cubit.state, PeopleDetailState(tPeople));
    });
    test('selectEditPeople should emit [PeopleEditState] when called ', () {
      //act
      cubit.selectEditPeople(people: tPeople);

      expect(cubit.state, PeopleEditState(people: tPeople));
    });
    test('selectCreatePeople should emit [PeopleCreateState] when called ', () {
      //act
      cubit.selectCreatePeople();

      expect(cubit.state, PeopleCreateState(people: tPeople));
    });
    test('selectPeopleList should emit [PeopleListState when called]', () {
      //act
      cubit.selectPeopleList();

      expect(cubit.state, PeopleListState(const [tPeople]));
    });
  });

  group('createPeople', () {
    blocTest<PeopleCubit, PeopleState>(
      'should emit [LoadingState, PeopleDetailState] when successful.',
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
      'should emit [LoadingState, PeopleError] when unsuccessful',
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

  group('updatePeople', () {
    blocTest<PeopleCubit, PeopleState>(
      'should emit [LoadingState, PeopleDetailState] when successful.',
      build: () {
        when(() => updatePeople(any()))
            .thenAnswer((_) async => const Right(tPeople));
        return cubit;
      },
      act: (cubit) => cubit.updatePeople(
        people: tPeople,
      ),
      expect: () => [
        LoadingState(),
        PeopleDetailState(tPeople),
      ],
      verify: (_) {
        verify(() => updatePeople(tUpdatePeopleParams)).called(1);
        verifyNoMoreInteractions(updatePeople);
      },
    );

    blocTest<PeopleCubit, PeopleState>(
      'should emit [LoadingState, PeopleError] when unsuccessful.',
      build: () {
        when(() => updatePeople(any()))
            .thenAnswer((_) async => const Left(tAPIFailure));
        return cubit;
      },
      act: (cubit) => cubit.updatePeople(
        people: tPeople,
      ),
      expect: () => [
        LoadingState(),
        PeopleError(message: tAPIFailure.errorMessage),
      ],
      verify: (_) {
        verify(() => updatePeople(tUpdatePeopleParams)).called(1);
        verifyNoMoreInteractions(updatePeople);
      },
    );
  });

  group('deletePeople', () {
    blocTest<PeopleCubit, PeopleState>(
      'should emit [LoadingState, PeopleListState] when successful.',
      build: () {
        when(() => deletePeople(any()))
            .thenAnswer((_) async => const Right(null));
        return cubit;
      },
      act: (cubit) => cubit.deletePeople(people: tPeople),
      expect: () => [
        LoadingState(),
        PeopleListState(const []),
      ],
      verify: (_) {
        verify(() => deletePeople(tDeletePeopleParams)).called(1);
        verifyNoMoreInteractions(deletePeople);
      },
    );

    blocTest<PeopleCubit, PeopleState>(
      'should emit [LoadingState, PeopleError] when unsuccessful.',
      build: () {
        when(() => deletePeople(any()))
            .thenAnswer((_) async => const Left(tAPIFailure));
        return cubit;
      },
      act: (cubit) => cubit.deletePeople(people: tPeople),
      expect: () => [
        LoadingState(),
        PeopleError(message: tAPIFailure.errorMessage),
      ],
      verify: (_) {
        verify(() => deletePeople(tDeletePeopleParams)).called(1);
        verifyNoMoreInteractions(deletePeople);
      },
    );
  });

  group('getPeople', () {
    blocTest<PeopleCubit, PeopleState>(
      'shoud emit a [LoadingState, PeopleListState] when successful',
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
      'should emit a [LoadingState, PeopleError] when unsuccessful',
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
