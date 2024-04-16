import 'dart:io';

import 'package:cadastro_pessoa/models/people.dart';
import 'package:cadastro_pessoa/people_api_client.dart';
import 'package:cadastro_pessoa/widgets/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PeopleEditCard extends StatelessWidget {
  const PeopleEditCard(
      {super.key,
      required this.pessoa,
      required this.pessoaApiClient,
      required this.nameController,
      required this.emailController,
      required this.detailsController});

  final People pessoa;
  final PeopleApiClient pessoaApiClient;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController detailsController;

  List<Widget> form() {
    return [
      CustomTextField(
        label: "Nome:",
        controller: nameController,
        value: pessoa.name,
        //formatter: FilteringTextInputFormatter.digitsOnly,
      ),
      CustomTextField(
        label: "E-mail:",
        controller: emailController,
        value: pessoa.email,
        //formatter: FilteringTextInputFormatter.digitsOnly,
      ),
      CustomTextField(
        label: "Detalhes:",
        controller: detailsController,
        value: pessoa.details,
        //formatter: FilteringTextInputFormatter.digitsOnly,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoFormSection(
        header: const Text("Dados da pessoa:"),
        margin: const EdgeInsets.all(8.0),
        children: form(),
      );
    } else {
      return Form(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: form(),
          ),
        ),
      );
    }
  }
}
