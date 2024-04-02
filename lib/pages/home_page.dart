import 'dart:io';

import 'package:cadastro_pessoa/cards/people_card.dart';
import 'package:cadastro_pessoa/models/people.dart';
import 'package:cadastro_pessoa/pages/people_detail_page.dart';
import 'package:cadastro_pessoa/pages/people_edit_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cadastro_pessoa/people_api_client.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late People pessoa;
  late Future<List<People>> pessoas;
  final PeopleApiClient pessoaApiClient = PeopleApiClient();

  @override
  void initState() {
    super.initState();
    pessoas = pessoaApiClient.fetchPessoas();
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: const Text("Cadastro de Pessoas"),
          trailing: CupertinoButton(
            padding: const EdgeInsets.all(1),
            child: const Icon(CupertinoIcons.add),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PeopleEditPage(
                            isCreate: true,
                            pessoa: People(
                                id: "", name: "", email: "", details: ""),
                            pessoaApiClient: pessoaApiClient,
                          ))).then((result) {
                setState(() {
                  if (result != null) {
                    pessoas = pessoaApiClient.fetchPessoas();
                  }
                });
              });
            },
          ),
        ),
        child: FutureBuilder(
          future: pessoas,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () async {
                      pessoa = snapshot.data![index];
                      await Navigator.push<People>(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PeopleDetailPage(
                                    pessoa: pessoa,
                                    pessoaApiClient: pessoaApiClient,
                                  ))).then((result) => {
                            setState(() {
                              if (result != null) {
                                pessoa = result;
                              }
                            })
                          });
                    },
                    child: PeopleCard(
                      pessoa: snapshot.data![index],
                      pessoaApiClient: pessoaApiClient,
                    ),
                  );
                },
              );
            } else {
              return const Center(child: CupertinoActivityIndicator());
            }
          },
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Cadastro de Pessoas"),
        ),
        body: FutureBuilder(
          future: pessoas,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () async {
                      pessoa = snapshot.data![index];
                      await Navigator.push<People>(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PeopleDetailPage(
                                    pessoa: pessoa,
                                    pessoaApiClient: pessoaApiClient,
                                  ))).then((result) => {
                            setState(() {
                              if (result != null) {
                                pessoa = result;
                              }
                            })
                          });
                    },
                    child: PeopleCard(
                      pessoa: snapshot.data![index],
                      pessoaApiClient: pessoaApiClient,
                    ),
                  );
                },
              );
            } else {
              return const Text("Não tem dados");
            }
          },
        ),
      );
    }
  }
}
