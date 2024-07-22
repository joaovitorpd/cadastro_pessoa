import 'dart:io';
import 'package:cadastro_pessoa/people/bloc/people_cubit.dart';
import 'package:cadastro_pessoa/people/cards/people_edit_card.dart';
import 'package:cadastro_pessoa/people/models/people.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PeopleEditPage extends StatelessWidget {
  PeopleEditPage({
    super.key,
    required this.people,
  });

  final People people;
  final People editedPeople = People.empty();

  @override
  Widget build(BuildContext context) {
    editedPeople.name = people.name;
    editedPeople.email = people.email;
    editedPeople.details = people.details;

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
          middle: Text("Editar dados de: \n${people.name}"),
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
          title: Text("Editar dados de: \n${people.name}"),
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
      nameOnChanged: (value) => editedPeople.name = value,
      emailOnChanged: (value) => editedPeople.email = value,
      detailsOnChanged: (value) => editedPeople.details = value,
      people: people,
    );
  }

  void _backButtonPressed(BuildContext context) {
    context.read<PeopleCubit>().selectDetailsPeople(people);
  }

  void _saveButtonOnPressed(BuildContext context) {
    editedPeople.id = people.id;
    context.read<PeopleCubit>().updatePeople(editedPeople);
  }
}
