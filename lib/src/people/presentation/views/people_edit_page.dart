import 'dart:io';
import 'package:cadastro_pessoa/src/people/data/models/people_model.dart';
import 'package:cadastro_pessoa/src/people/domain/entities/people.dart';
import 'package:cadastro_pessoa/src/people/presentation/cards/people_edit_card.dart';
import 'package:cadastro_pessoa/src/people/presentation/cubit/people_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PeopleEditPage extends StatelessWidget {
  PeopleEditPage({
    super.key,
    required this.people,
  });

  final PeopleModel people;
  final _formKey = GlobalKey<FormState>(debugLabel: 'peopleEditForm');

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
            middle: _titleText(),
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
            )),
        child: SafeArea(
          child: _peopleEditCard(context),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: _titleText(),
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
    People editedPeople = people.copyWith(
      id: people.id,
      name: people.name,
      email: people.email,
      details: people.details,
    );
    return PeopleEditCard(
      nameOnChanged: (value) => context.read<PeopleCubit>().changeName(value),
      emailOnChanged: (value) => context.read<PeopleCubit>().changeEmail(value),
      detailsOnChanged: (value) =>
          context.read<PeopleCubit>().changeDetails(value),
      formKey: _formKey,
      people: editedPeople,
    );
  }

  Widget? _titleText() {
    return Text("Editar dados de: \n${people.name}");
  }

  void _backButtonPressed(BuildContext context) {
    context.read<PeopleCubit>().selectDetailsPeople(people: people);
  }

  void _saveButtonOnPressed(
    BuildContext context,
  ) async {
    // Ensure the latest values are captured by the Cubit
    context.read<PeopleCubit>().updatePeopleState();
    var updatedPeople =
        (context.read<PeopleCubit>().state as PeopleEditState).people;
    context.read<PeopleCubit>().updatePeople(people: updatedPeople);
  }
}
