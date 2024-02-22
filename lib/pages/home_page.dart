import 'package:cadastro_pessoa/cards/people_card.dart';
import 'package:cadastro_pessoa/models/people.dart';
import 'package:flutter/material.dart';
import 'package:cadastro_pessoa/people_api_client.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<People>> pessoas;
  final PeopleApiClient pessoaApiClient = PeopleApiClient();

  @override
  void initState() {
    super.initState();
    pessoas = pessoaApiClient.fetchPessoas();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Pessoas",
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Cadastro de Pessoas"),
        ),
        body: FutureBuilder(
          future: pessoas,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return PeopleCard(
                      id: snapshot.data![index].id!,
                      name: snapshot.data![index].name!,
                      email: snapshot.data![index].email!,
                      details: snapshot.data![index].details!);
                },
              );
            } else {
              return const Text("Não tem dados");
            }
          },
        ),
      ),
    );
  }
}
