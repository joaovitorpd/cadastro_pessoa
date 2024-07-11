import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:cadastro_pessoa/people/models/people.dart';

class PeopleRepository {
  String apiUrl =
      'https://659d7e20633f9aee790986a9.mockapi.io/api/crud_teste/pessoa';
  Future<List<People>> fetchPeople() async {
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

  Future<People> createPeople({required People pessoa}) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(pessoa.toJson()),
    );
    if (response.statusCode == 201) {
      return People.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Falha ao criar Pessoa');
    }
  }

  Future<People> updatePeople({required People pessoa}) async {
    final response = await http.put(
      Uri.parse("$apiUrl/${pessoa.id}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(pessoa.toJson()),
    );
    if (response.statusCode == 200) {
      return People.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Falha ao atualizar Pessoa');
    }
  }

  Future<void> deletePeople({required People pessoa}) async {
    final response = await http.delete(
      Uri.parse("$apiUrl/${pessoa.id}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode != 200) {
      throw Exception('Falha ao deletar Pessoa!');
    }
  }
}
