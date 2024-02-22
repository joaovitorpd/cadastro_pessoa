import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:cadastro_pessoa/models/people.dart';

class PeopleApiClient {
  String apiUrl =
      'https://659d7e20633f9aee790986a9.mockapi.io/api/crud_teste/pessoa';
  Future<List<People>> fetchPessoas() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      var jsonBody = jsonDecode(response.body);

      var listaPessoa =
          List<People>.from(jsonBody.map((pessoa) => People.fromJson(pessoa)));

      return listaPessoa;
    } else {
      throw Exception('Falha ao carregar Pessoa');
    }
  }

  Future<People> createPessoa(
      {required String id,
      required String name,
      required String email,
      required String details}) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'id': id,
        'name': name,
        'email': email,
        'details': details,
      }),
    );
    if (response.statusCode == 201) {
      return People.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Falha ao criar Pessoa');
    }
  }

  Future<People> updatePessoa(
      {required int id,
      required String name,
      required String email,
      required String details}) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'id': id,
        'name': name,
        'email': email,
        'details': details,
      }),
    );
    if (response.statusCode == 200) {
      return People.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Falha ao atualizar Pessoa');
    }
  }

  Future<People> deletePessoa(int id) async {
    final http.Response response = await http.delete(
      Uri.parse('apiUrl/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      return People.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Falha ao deletar Pessoa');
    }
  }
}
