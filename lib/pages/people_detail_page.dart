import 'package:cadastro_pessoa/cards/people_detailed_card.dart';
import 'package:cadastro_pessoa/models/people.dart';
import 'package:cadastro_pessoa/pages/people_edit_page.dart';
import 'package:cadastro_pessoa/people_api_controller.dart';
import 'package:cadastro_pessoa/widgets/menu_apple.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'dart:io' show Platform;

import 'package:get_it/get_it.dart';

class PeopleDetailPage extends StatelessWidget {
  const PeopleDetailPage({
    super.key,
    required this.controller,
  });

  final PeopleApiController controller;

  @override
  Widget build(BuildContext context) {
    final controller = GetIt.I.get<PeopleApiController>();

    // People pessoa = controller.people;

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
            middle: Observer(builder: (_) {
              return Text("Detalhes de ${controller.people.name}");
            }),
            trailing: MenuApple(
              builder: (_, showMenu) => CupertinoButton(
                onPressed: showMenu,
                padding: EdgeInsets.zero,
                pressedOpacity: 1,
                child: const Icon(CupertinoIcons.ellipsis_circle),
              ),
              controller: controller,
            )),
        child: SafeArea(
          child: Observer(builder: (_) {
            return const PeopleDetailedCard();
          }),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Observer(builder: (_) {
            return Text("Detalhes de ${controller.people.name}");
          }),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.push<People>(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PeopleEditPage(
                              isCreate: false,
                            )));
              },
              child: const Text("Editar"),
            ),
          ],
        ),
        body: Observer(builder: (_) {
          return const PeopleDetailedCard();
        }),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.delete),
          onPressed: () => showDialog<void>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text("Atenção!!!"),
              content: const Text("Tem certeza que deseja apagar?"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Não"),
                ),
                TextButton(
                  onPressed: () async {
                    try {
                      await controller.deletePeople(controller.people);
                      if (context.mounted) {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      }
                    } on Exception catch (e) {
                      if (context.mounted) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text("Erro!"),
                            content: Text(e.toString()),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                                child: const Text("OK"),
                              ),
                            ],
                          ),
                        );
                      }
                    }
                  },
                  child: const Text(
                    "Sim",
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
