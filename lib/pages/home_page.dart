import 'package:cadastro_pessoa/models/pessoa.dart';
import 'package:flutter/material.dart';
import 'package:cadastro_pessoa/pessoa_api_client.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Pessoa>> pessoas;
  final PessoaApiClient pessoaApiClient = PessoaApiClient();
  
  
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
            if(snapshot.hasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                return ListTile(title: Text(snapshot.data![index].name!));
              },);
            } else {
              return const Text("Não tem dados");
            }
          },
        ),
      ),
    );
  }
}