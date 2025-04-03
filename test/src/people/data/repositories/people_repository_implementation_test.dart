import 'package:cadastro_pessoa/core/errors/exceptions.dart';
import 'package:cadastro_pessoa/core/errors/failure.dart';
import 'package:cadastro_pessoa/src/people/data/datasources/people_remote_data_source.dart';
import 'package:cadastro_pessoa/src/people/data/models/people_model.dart';
import 'package:cadastro_pessoa/src/people/data/repositories/people_repository_implementation.dart';
import 'package:cadastro_pessoa/src/people/domain/entities/people.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockPeopleRemoteDataSource extends Mock
    implements PeopleRemoteDataSource {}

void main() {
  late PeopleRemoteDataSource remoteDataSource;
  late PeopleRepositoryImplementation repoImpl;

  setUp(() {
    remoteDataSource = MockPeopleRemoteDataSource();
    repoImpl = PeopleRepositoryImplementation(remoteDataSource);
    registerFallbackValue(const PeopleModel.empty());
  });

  const tException = ApiException(
    message: 'Unknown Error Occurred',
    statusCode: 500,
  );

  const tListPeople = [PeopleModel.empty()];
  const tPeople = PeopleModel.empty();

  group('createPeople', () {
    test(
        'shoud call the [PeopleDataSource.createPeople], return the created [People]'
        'and complete successfuly when the call to the remote source is successful',
        () async {
      //Arrange
      when(() => remoteDataSource.createPeople(people: any(named: 'people')))
          .thenAnswer((_) async => Future.value(tPeople));

      //Act
      final result = await repoImpl.createPeople(people: tPeople);

      //Assert
      expect(result, const Right(tPeople));
      verify(() => remoteDataSource.createPeople(people: tPeople)).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });

    test(
        'should return a [ServerFailure] when the call to the remote'
        'source is unsuccessful', () async {
      //Arrange
      when(() => remoteDataSource.createPeople(
            people: any(named: 'people'),
          )).thenThrow(tException);

      //Act
      final result = await repoImpl.createPeople(people: tPeople);

      //Assert
      expect(
        result,
        Left(
          APIFailure(
            message: tException.message,
            statusCode: tException.statusCode,
          ),
        ),
      );
      verify(() => remoteDataSource.createPeople(people: tPeople)).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });
  });

  group('updatePeople', () {
    const id = '1';
    const name = 'name';
    const email = 'email';
    const details = 'details';

    test(
        'shoud call the [PeopleDataSource.updatePeople], return the updated [People]'
        'and complete successfuly when the call to the remote source is successful',
        () async {
      //Arrange
      var createdPeople =
          const PeopleModel(id: id, name: name, email: email, details: details);
      when(() => remoteDataSource.createPeople(
            people: any(named: 'people'),
          )).thenAnswer((_) async => Future.value(createdPeople));

      //Act
      final createdResult = await repoImpl.createPeople(
        people: tPeople,
      );

      //Assert
      expect(createdResult, Right(createdPeople));
      verify(() => remoteDataSource.createPeople(people: tPeople)).called(1);
      verifyNoMoreInteractions(remoteDataSource);

      //Assert
      var modifiedPeople = PeopleModel(
        id: createdPeople.id,
        name: 'new.name',
        email: 'new.email',
        details: 'new.details',
      );
      when(() => remoteDataSource.updatePeople(
            people: any(named: 'people'),
          )).thenAnswer((_) async => Future.value(modifiedPeople));

      //Act
      final updateResult = await repoImpl.updatePeople(
        people: tPeople,
      );

      //Assert
      expect(updateResult, Right(modifiedPeople));
      verify(() => remoteDataSource.updatePeople(
            people: tPeople,
          )).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });

    test(
        'should return a [ServerFailure] when the call to the remote'
        'source is unsuccessful', () async {
      //Arrange
      when(() => remoteDataSource.updatePeople(people: any(named: 'people')))
          .thenThrow(tException);

      //Act
      final result = await repoImpl.updatePeople(
        people: tPeople,
      );

      //Assert
      expect(
        result,
        Left(
          APIFailure(
            message: tException.message,
            statusCode: tException.statusCode,
          ),
        ),
      );
      verify(() => remoteDataSource.updatePeople(people: tPeople)).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });
  });

  group('deletePeople', () {
    var examplePeople = const People(
      id: '1',
      name: 'name',
      email: 'email',
      details: 'details',
    );
    test(
        'shoud call the [PeopleDataSource.deletePeople] and complete successfuly, '
        'when the call to the remote source is successful', () async {
      //Arrange
      when(
        () => remoteDataSource.deletePeople(people: examplePeople),
      ).thenAnswer((_) async => Future.value());

      //Act
      final result = await repoImpl.deletePeople(people: examplePeople);

      //Assert
      expect(result, const Right(null));
      verify(() => remoteDataSource.deletePeople(people: examplePeople))
          .called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });

    test(
        'should return a [ServerFailure] when the call to the remote'
        'source is unsuccessful', () async {
      //Arrange
      when(() => remoteDataSource.deletePeople(people: examplePeople))
          .thenThrow(tException);

      //Act
      final result = await repoImpl.deletePeople(people: examplePeople);

      //Assert
      expect(result, Left(APIFailure.formatException(tException)));
      verify(() => remoteDataSource.deletePeople(people: examplePeople))
          .called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });
  });

  group('getPeopleList', () {
    test(
        'should call the [RemoteDataSource.getPeopleList] and'
        'return [List<People>] when call to remote source is successful',
        () async {
      //Assert
      when(() => remoteDataSource.getPeople())
          .thenAnswer((_) async => Future.value(tListPeople));

      //Act
      final result = await repoImpl.getPeople();

      expect(result, const Right(tListPeople));
      verify(() => remoteDataSource.getPeople()).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });
    test(
        'should return a [ServerFailure] when the call to the remote'
        'source is unsuccessful', () async {
      //Assert
      when(() => remoteDataSource.getPeople()).thenThrow(tException);

      //Act
      final result = await repoImpl.getPeople();

      expect(result, Left(APIFailure.formatException(tException)));
      verify(() => remoteDataSource.getPeople()).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });
  });
}
