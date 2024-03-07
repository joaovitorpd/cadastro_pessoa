import 'package:cadastro_pessoa/cards/people_detailed_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

class PeopleDetailPage extends StatelessWidget {
  final String? id;
  final String? name;
  final String? email;
  final String? details;

  const PeopleDetailPage(
      {super.key,
      required this.id,
      required this.name,
      required this.email,
      required this.details});

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Detalhes de $name"),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Editar"),
            ),
          ],
        ),
        body: PeopleDetailedCard(
            id: id, name: name, email: email, details: details),
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
          middle: Text("Detalhes de $name"),
          trailing: CupertinoButton(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(1),
            child: const Text("Editar"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        child: SafeArea(
          child: PeopleDetailedCard(
              id: id, name: name, email: email, details: details),
        ),
      );
    } else {
      return const Text("No valid platform");
    }
  }
}
