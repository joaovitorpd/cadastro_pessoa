import 'dart:convert';

import 'package:cadastro_pessoa/core/errors/exceptions.dart';
import 'package:cadastro_pessoa/core/utils/constants.dart';
import 'package:cadastro_pessoa/core/utils/typedef.dart';
import 'package:cadastro_pessoa/src/people/data/datasources/people_remote_data_source.dart';
import 'package:cadastro_pessoa/src/people/data/models/people_model.dart';
import 'package:cadastro_pessoa/src/people/domain/entities/people.dart';
import 'package:http/http.dart';

class PeopleRemoteDataSourceImplementation implements PeopleRemoteDataSource {
  const PeopleRemoteDataSourceImplementation(this._client);

  final Client _client;

  @override
  Future<PeopleModel> createPeople({
    required PeopleModel people,
  }) async {
    // 1. check to make sure that it returns the right data when the status
    // code is 200 or the proper status code.
    // 2. check to make sure that it "THOWS A CUSTOM EXCEPTION" with the
    // right message when satus code is of unsuccess.

    try {
      final response = await _client.post(
        Uri.parse(kBaseUrl),
        body: people.toJson(),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ApiException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }

      return PeopleModel.fromJson(utf8.decode(response.bodyBytes));
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<PeopleModel> updatePeople({
    required PeopleModel people,
  }) async {
    try {
      final response = await _client.put(
        Uri.parse('$kBaseUrl/${people.id}'),
        body: people.toJson(),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ApiException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }

      return PeopleModel.fromJson(utf8.decode(response.bodyBytes));
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<void> deletePeople({required People people}) async {
    try {
      final response = await _client.delete(
        Uri.parse('$kBaseUrl/${people.id}'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ApiException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<List<PeopleModel>> getPeople() async {
    try {
      final response = await _client.get(
        Uri.parse(kBaseUrl),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ApiException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }

      return List<DataMap>.from(
              jsonDecode(utf8.decode(response.bodyBytes)) as List)
          .map((people) => PeopleModel.fromMap(people))
          .toList();
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(message: e.toString(), statusCode: 505);
    }
  }
}
