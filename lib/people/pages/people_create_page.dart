import 'dart:io';
import 'package:cadastro_pessoa/people/bloc/people_cubit.dart';
import 'package:cadastro_pessoa/people/cards/people_edit_card.dart';
import 'package:cadastro_pessoa/people/models/people.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PeopleCreatePage extends StatelessWidget {
  const PeopleCreatePage({super.key, required this.people, this.errors});

  final People people;
  final Map<String, String>? errors;

  @override
  Widget build(BuildContext context) {
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
              _backButtonPressed(context);
            },
          ),
          middle: const Text("Cadastro:"),
          trailing: CupertinoButton(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(0),
            child: const Text("Salvar"),
            onPressed: () {
              _saveButtonOnPressed(context);
            },
          ),
        ),
        child: SafeArea(
          child: _peopleEditCard(),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Cadastro:"),
          leading: IconButton(
            onPressed: () {
              _backButtonPressed(context);
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: _peopleEditCard(),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.save),
          onPressed: () {
            _saveButtonOnPressed(context);
          },
        ),
      );
    }
  }

  Widget _peopleEditCard() {
    return PeopleEditCard(
      nameOnChanged: (value) => people.name = value,
      emailOnChanged: (value) => people.email = value,
      detailsOnChanged: (value) => people.details = value,
      people: people,
      errors: errors,
    );
  }

  void _backButtonPressed(
    BuildContext context,
  ) {
    context.read<PeopleCubit>().loadPeopleList();
  }

  void _saveButtonOnPressed(BuildContext context) {
    var newPerson = People(
        id: null,
        name: people.name,
        email: people.email,
        details: people.details);
    context.read<PeopleCubit>().createPeople(newPerson);
  }
}
