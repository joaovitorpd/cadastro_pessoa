import 'package:cadastro_pessoa/core/errors/exceptions.dart';
import 'package:cadastro_pessoa/core/errors/failure.dart';
import 'package:cadastro_pessoa/core/utils/typedef.dart';
import 'package:cadastro_pessoa/src/people/data/datasources/people_remote_data_source.dart';
import 'package:cadastro_pessoa/src/people/data/models/people_model.dart';
import 'package:cadastro_pessoa/src/people/domain/entities/people.dart';
import 'package:cadastro_pessoa/src/people/domain/repositories/people_repository.dart';
import 'package:dartz/dartz.dart';

class PeopleRepositoryImplementation implements PeopleRepository {
  const PeopleRepositoryImplementation(this._remoteDataSource);

  final PeopleRemoteDataSource _remoteDataSource;

  @override
  ResultFuture<PeopleModel> createPeople({
    required PeopleModel people,
    /* required String? name,
    required String? email,
    required String? details, */
  }) async {
    // Test-Driven Development
    // call the remote data source
    // check if the method returns the proper data
    // make sure tha it returns the proper data if there is no exception
    // // check if when the remoteDataSource throws an exception, we return a
    // failure.

    try {
      var result = await _remoteDataSource.createPeople(people: people);
      return Right(result);
    } on ApiException catch (e) {
      return Left(APIFailure.formatException(e));
    }
  }

  @override
  ResultFuture<PeopleModel> updatePeople({
    required PeopleModel people,
    /* required String? id,
    required String? name,
    required String? email,
    required String? details, */
  }) async {
    try {
      var result = await _remoteDataSource.updatePeople(
        people: people,
      );
      return Right(result);
    } on ApiException catch (e) {
      return Left(APIFailure.formatException(e));
    }
  }

  @override
  ResultVoid deletePeople({
    required People people,
    /* required String? id, */
  }) async {
    try {
      final result = await _remoteDataSource.deletePeople(people: people);
      return Right(result);
    } on ApiException catch (e) {
      return Left(APIFailure.formatException(e));
    }
  }

  @override
  ResultFuture<List<People>> getPeople() async {
    try {
      final result = await _remoteDataSource.getPeople();
      return Right(result);
    } on ApiException catch (e) {
      return Left(APIFailure.formatException(e));
    }
  }
}
