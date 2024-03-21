import 'dart:io';

import 'package:cadastro_pessoa/cards/people_edit_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PeopleEditPage extends StatefulWidget {
  const PeopleEditPage(
      {super.key,
      required this.id,
      required this.name,
      required this.email,
      required this.details});

  final String? id;
  final String? name;
  final String? email;
  final String? details;

  @override
  State<PeopleEditPage> createState() => _PeopleEditPageState();
}

class _PeopleEditPageState extends State<PeopleEditPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final detailsController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    detailsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String? name = widget.name;

    if (Platform.isAndroid) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Editar dados de: \n$name"),
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
              child: const Text("Salvar"),
            ),
          ],
        ),
        body: PeopleEditCard(
            id: widget.id,
            name: widget.name,
            email: widget.email,
            details: widget.details,
            nameController: nameController,
            emailController: emailController,
            detailsController: detailsController),
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
          middle: Text("Editar dados de: \n$name"),
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
          child: PeopleEditCard(
              id: widget.id,
              name: widget.name,
              email: widget.email,
              details: widget.details,
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
