import 'package:cadastro_pessoa/cards/people_detailed_card.dart';
import 'package:cadastro_pessoa/models/people.dart';
import 'package:cadastro_pessoa/pages/people_edit_page.dart';
import 'package:cadastro_pessoa/people_api_client.dart';
import 'package:cadastro_pessoa/widgets/menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_down_button/pull_down_button.dart';
import 'dart:io' show Platform;

class PeopleDetailPage extends StatefulWidget {
  const PeopleDetailPage({
    super.key,
    required this.pessoa,
    required this.pessoaApiClient,
  });

  final People pessoa;
  final PeopleApiClient pessoaApiClient;

  @override
  State<PeopleDetailPage> createState() => _PeopleDetailPageState();
}

class _PeopleDetailPageState extends State<PeopleDetailPage> {
  late People _editedPessoa;

  @override
  void initState() {
    super.initState();
    _editedPessoa = widget.pessoa;
  }

  void _updatedPessoa(People newPessoa) {
    setState(() {
      _editedPessoa = newPessoa;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Detalhes de ${widget.pessoa.name}"),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context, widget.pessoa);
            },
            icon: const Icon(Icons.arrow_back),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.push<People>(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PeopleEditPage(
                              isCreate: false,
                              pessoa: _editedPessoa,
                              pessoaApiClient: widget.pessoaApiClient,
                            ))).then((result) {
                  if (result != null) {
                    _updatedPessoa(result);
                  }
                });
              },
              child: const Text("Editar"),
            ),
          ],
        ),
        body: PeopleDetailedCard(
          pessoa: _editedPessoa,
          pessoaApiClient: widget.pessoaApiClient,
        ),
      );
    } else if (Platform.isIOS) {
      return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
            leading: CupertinoButton(
              padding: const EdgeInsets.all(1),
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context, widget.pessoa);
              },
            ),
            middle: Text("Detalhes de ${widget.pessoa.name}"),
            trailing: Menu(
                builder: (_, showMenu) => CupertinoButton(
                      onPressed: showMenu,
                      padding: EdgeInsets.zero,
                      pressedOpacity: 1,
                      child: const Icon(CupertinoIcons.ellipsis_circle),
                    ),
                pessoa: widget.pessoa,
                pessoaApiClient: widget.pessoaApiClient,
                callback: (pessoa) {
                  _updatedPessoa(pessoa);
                })),
        child: SafeArea(
          child: PeopleDetailedCard(
            pessoa: widget.pessoa,
            pessoaApiClient: widget.pessoaApiClient,
          ),
        ),
      );
    } else {
      return const Text("No valid platform");
    }
  }
}
