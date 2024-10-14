import 'dart:convert';
import 'package:cadastro_pessoa/core/utils/typedef.dart';
import 'package:cadastro_pessoa/src/people/data/models/people_model.dart';
import 'package:http/http.dart';

class PeopleApiRepository {
  String apiUrl =
      'https://659d7e20633f9aee790986a9.mockapi.io/api/crud_teste/pessoa';

  final Client client;

  PeopleApiRepository({required this.client});

  Future<List<PeopleModel>> fetchPeople() async {
    final response = await client.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      return List<DataMap>.from(
              jsonDecode(utf8.decode(response.bodyBytes)) as List)
          .map((people) => PeopleModel.fromMap(people))
          .toList();
    } else {
      throw Exception('Falha ao carregar Pessoa');
    }
  }

  Future<PeopleModel> createPeople({required PeopleModel pessoa}) async {
    final response = await client.post(
      Uri.parse('$apiUrl/'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: pessoa.toJson(),
    );
    if (response.statusCode == 201) {
      return PeopleModel.fromJson(utf8.decode(response.bodyBytes));
    } else {
      throw Exception('Falha ao criar Pessoa');
    }
  }

  Future<PeopleModel> updatePeople({required PeopleModel pessoa}) async {
    final response = await client.put(
      Uri.parse("$apiUrl/${pessoa.id}"),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: pessoa.toJson(),
    );
    if (response.statusCode == 200) {
      return PeopleModel.fromJson(utf8.decode(response.bodyBytes));
    } else {
      throw Exception('Falha ao atualizar Pessoa');
    }
  }

  Future<void> deletePeople({required PeopleModel pessoa}) async {
    final response = await client.delete(
      Uri.parse("$apiUrl/${pessoa.id}"),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode != 200) {
      throw Exception('Falha ao deletar Pessoa!');
    }
  }
}
