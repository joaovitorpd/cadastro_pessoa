import 'dart:io';

import 'package:cadastro_pessoa/cards/people_edit_card.dart';
import 'package:cadastro_pessoa/models/people.dart';
import 'package:cadastro_pessoa/people_api_client.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PeopleEditPage extends StatefulWidget {
  const PeopleEditPage({
    super.key,
    required this.pessoa,
    required this.pessoaApiClient,
  });

  final People pessoa;
  final PeopleApiClient pessoaApiClient;

  @override
  State<PeopleEditPage> createState() => _PeopleEditPageState();
}

class _PeopleEditPageState extends State<PeopleEditPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController detailsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.pessoa.name!;
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    detailsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Editar dados de: \n${widget.pessoa.name}"),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: PeopleEditCard(
            pessoa: widget.pessoa,
            pessoaApiClient: widget.pessoaApiClient,
            nameController: nameController,
            emailController: emailController,
            detailsController: detailsController),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.save),
          onPressed: () async {
            widget.pessoa.name = nameController.text;
            widget.pessoa.email = emailController.text;
            widget.pessoa.details = detailsController.text;

            try {
              await widget.pessoaApiClient.updatePessoa(
                pessoa: widget.pessoa,
              );
              Navigator.pop(context, widget.pessoa);
            } on Exception catch (e) {
              if (!mounted) return;
              var snackbar = SnackBar(content: Text(e.toString()));
              ScaffoldMessenger.of(context).showSnackBar(snackbar);
            }
          },
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
              Navigator.pop(context);
            },
          ),
          middle: Text("Editar dados de: \n${widget.pessoa.name}"),
          trailing: CupertinoButton(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(1),
            child: const Text("Salvar"),
            onPressed: () async {
              widget.pessoa.name = nameController.text;
              widget.pessoa.email = emailController.text;
              widget.pessoa.details = detailsController.text;
              try {
                await widget.pessoaApiClient.updatePessoa(
                  pessoa: widget.pessoa,
                );
                Navigator.pop(context, widget.pessoa);
              } on Exception catch (e) {
                showCupertinoModalPopup<void>(
                  context: context,
                  builder: (BuildContext context) => CupertinoAlertDialog(
                    title: const Text("Erro!"),
                    content: Text(e.toString()),
                    actions: <CupertinoDialogAction>[
                      CupertinoDialogAction(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("OK"),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ),
        child: SafeArea(
          child: PeopleEditCard(
              pessoa: widget.pessoa,
              pessoaApiClient: widget.pessoaApiClient,
              nameController: nameController,
              emailController: emailController,
              detailsController: detailsController),
        ),
      );
    } else {
      return const Text("No valid platform");
    }
  }
}
