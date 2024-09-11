import 'dart:convert';
import 'package:http/http.dart';

import 'package:cadastro_pessoa/people/models/people.dart';

class PeopleRepository {
  String apiUrl =
      'https://659d7e20633f9aee790986a9.mockapi.io/api/crud_teste/pessoa';

  final Client client;

  PeopleRepository({required this.client});

  Future<List<People>> fetchPeople() async {
    final response = await client.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      var jsonBody = jsonDecode(utf8.decode(response.bodyBytes));

      var listaPessoa =
          List<People>.from(jsonBody.map((pessoa) => People.fromJson(pessoa)));

      return listaPessoa;
    } else {
      throw Exception('Falha ao carregar Pessoa');
    }
  }

  Future<People> createPeople({required People pessoa}) async {
    final response = await client.post(
      Uri.parse('$apiUrl/'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(pessoa.toJson()),
    );
    if (response.statusCode == 201) {
      return People.fromJson(
          jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>);
    } else {
      throw Exception('Falha ao criar Pessoa');
    }
  }

  Future<People> updatePeople({required People pessoa}) async {
    final response = await client.put(
      Uri.parse("$apiUrl/${pessoa.id}"),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(pessoa.toJson()),
    );
    if (response.statusCode == 200) {
      return People.fromJson(
          jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>);
    } else {
      throw Exception('Falha ao atualizar Pessoa');
    }
  }

  Future<void> deletePeople({required People pessoa}) async {
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
