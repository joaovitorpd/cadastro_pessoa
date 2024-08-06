import 'dart:io';
import 'package:cadastro_pessoa/people/bloc/people_cubit.dart';
import 'package:cadastro_pessoa/people/bloc/people_state.dart';
import 'package:cadastro_pessoa/people/cards/people_edit_card.dart';
import 'package:cadastro_pessoa/people/models/people.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PeopleCreatePage extends StatelessWidget {
  PeopleCreatePage({super.key, required this.people, this.errors});

  final People people;
  final Map<String, String>? errors;
  final _formKey = GlobalKey<FormState>(debugLabel: 'peopleCreateForm');

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
          trailing: StreamBuilder<bool>(
            stream: context.read<PeopleCubit>().isFormValid,
            builder: (context, snapshot) {
              return CupertinoButton(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(0),
                onPressed: snapshot.hasData && snapshot.data == true
                    ? () {
                        _saveButtonOnPressed(context);
                      }
                    : null,
                child: const Text("Salvar"),
              );
            },
          ),
        ),
        child: SafeArea(
          child: _peopleEditCard(context),
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
        body: _peopleEditCard(context),
        floatingActionButton: StreamBuilder<bool>(
          stream: context.read<PeopleCubit>().isFormValid,
          builder: (context, snapshot) {
            return FloatingActionButton(
              onPressed: snapshot.hasData && snapshot.data == true
                  ? () {
                      _saveButtonOnPressed(context);
                    }
                  : null,
              child: const Icon(Icons.save),
            );
          },
        ),
      );
    }
  }

  Widget _peopleEditCard(BuildContext context) {
    return PeopleEditCard(
      nameOnChanged: (value) => context.read<PeopleCubit>().changeName(value),
      emailOnChanged: (value) => context.read<PeopleCubit>().changeEmail(value),
      detailsOnChanged: (value) =>
          context.read<PeopleCubit>().changeDetails(value),
      formKey: _formKey,
      people: people,
    );
  }

  void _backButtonPressed(
    BuildContext context,
  ) {
    context.read<PeopleCubit>().selectPeopleList();
  }

  void _saveButtonOnPressed(
    BuildContext context,
  ) {
    // Ensure the latest values are captured by the Cubit
    context.read<PeopleCubit>().updatePeopleState();
    var newPeople =
        (context.read<PeopleCubit>().state as PeopleCreateState).people;
    context.read<PeopleCubit>().createPeople(newPeople);
  }
}
