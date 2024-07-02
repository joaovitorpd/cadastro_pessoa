import 'dart:io';

import 'package:cadastro_pessoa/cards/people_edit_card.dart';
import 'package:cadastro_pessoa/models/people.dart';
import 'package:cadastro_pessoa/people_api_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class PeopleEditPage extends StatefulWidget {
  const PeopleEditPage({super.key, required this.isCreate});

  final bool isCreate;

  @override
  State<PeopleEditPage> createState() => _PeopleEditPageState();
}

class _PeopleEditPageState extends State<PeopleEditPage> {
  iOsOnPressed(PeopleApiController controller, BuildContext context,
      People people, bool isCreate) async {
    if (isCreate) {
      try {
        await controller.createPeople(
          people,
        );
        if (context.mounted) {
          Navigator.pop(context);
        }
      } on Exception catch (e) {
        if (context.mounted) {
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
      }
    } else {
      try {
        await controller.updatePeople(
          people,
        );
        // controller.selectedPeople(people);
        if (context.mounted) {
          Navigator.pop(context);
        }
      } on Exception catch (e) {
        if (context.mounted) {
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
      }
    }
  }

  androidOnPressed(PeopleApiController controller, BuildContext context,
      People people, bool isCreate) async {
    if (isCreate) {
      try {
        await controller.createPeople(
          people,
        );
        if (context.mounted) Navigator.pop(context, people);
      } on Exception catch (e) {
        var snackbar = SnackBar(content: Text(e.toString()));
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
        }
      }
    } else {
      try {
        await controller.updatePeople(
          people,
        );
        if (context.mounted) Navigator.pop(context, people);
      } on Exception catch (e) {
        var snackbar = SnackBar(content: Text(e.toString()));
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = GetIt.I.get<PeopleApiController>();

    People pessoa = People.empty();
    if (!widget.isCreate) {
      pessoa = controller.people;
    }

    if (Platform.isIOS) {
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
          middle: widget.isCreate
              ? const Text("Cadastro:")
              : Text("Editar dados de: \n${controller.people.name}"),
          trailing: CupertinoButton(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(0),
            child: const Text("Salvar"),
            onPressed: () async {
              iOsOnPressed(controller, context, pessoa, widget.isCreate);
            },
          ),
        ),
        child: const SafeArea(
          child: PeopleEditCard(),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: widget.isCreate
              ? const Text("Cadastro:")
              : Text("Editar dados de: \n${controller.people.name}"),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: const PeopleEditCard(),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.save),
          onPressed: () async {
            androidOnPressed(controller, context, pessoa, widget.isCreate);
          },
        ),
      );
    }
  }
}
