import 'dart:io';

import 'package:cadastro_pessoa/people/bloc/people_cubit.dart';
import 'package:cadastro_pessoa/people/bloc/people_state.dart';
import 'package:cadastro_pessoa/people/cards/people_edit_card.dart';
import 'package:cadastro_pessoa/people/models/people.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PeopleEditPage extends StatelessWidget {
  PeopleEditPage({
    super.key,
    required this.isCreate,
  });

  final bool isCreate;
  // final _formKey = GlobalKey<FormState>();
  String? _name = '';
  String? _email = '';
  String? _details = '';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PeopleCubit, PeopleState>(builder: (context, state) {
      switch (state) {
        case LoadingState():
          return const Center(
            child: Text('Pessoa não encontrada!'),
          );
        case PeopleEditState():
          _name = state.people.name;
          _email = state.people.email;
          _details = state.people.details;
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
                    if (isCreate) {
                      context.read<PeopleCubit>().loadPeopleList();
                    } else {
                      context
                          .read<PeopleCubit>()
                          .selectPersonToDetail(state.people);
                    }
                    Navigator.pop(context);
                  },
                ),
                middle: isCreate
                    ? const Text("Cadastro:")
                    : Text("Editar dados de: \n${state.people.name}"),
                trailing: CupertinoButton(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(0),
                  child: const Text("Salvar"),
                  onPressed: () async {
                    var person = state.people;
                    var editedPerson = People(
                        id: person.id,
                        name: _name,
                        email: _email,
                        details: _details);
                    if (isCreate) {
                      try {
                        context.read<PeopleCubit>().createPeople(editedPerson);
                        if (context.mounted) {
                          Navigator.pop(context);
                        }
                      } on Exception catch (e) {
                        if (context.mounted) {
                          showCupertinoModalPopup<void>(
                            context: context,
                            builder: (BuildContext context) =>
                                CupertinoAlertDialog(
                              title: const Text("Erro!"),
                              content: Text(e.toString()),
                              actions: <CupertinoDialogAction>[
                                CupertinoDialogAction(
                                  onPressed: () {
                                    context
                                        .read<PeopleCubit>()
                                        .loadPeopleList();
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
                        context.read<PeopleCubit>().updatePeople(editedPerson);
                        if (context.mounted) {
                          context
                              .read<PeopleCubit>()
                              .selectPersonToDetail(editedPerson);
                          Navigator.pop(context);
                        }
                      } on Exception catch (e) {
                        if (context.mounted) {
                          showCupertinoModalPopup<void>(
                            context: context,
                            builder: (BuildContext context) =>
                                CupertinoAlertDialog(
                              title: const Text("Erro!"),
                              content: Text(e.toString()),
                              actions: <CupertinoDialogAction>[
                                CupertinoDialogAction(
                                  onPressed: () {
                                    context
                                        .read<PeopleCubit>()
                                        .loadPeopleList();
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
                  },
                ),
              ),
              child: SafeArea(
                child: PeopleEditCard(
                  nameOnChanged: (value) => _name = value,
                  emailOnChanged: (value) => _email = value,
                  detailsOnChanged: (value) => _details = value,
                ),
              ),
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                title: isCreate
                    ? const Text("Cadastro:")
                    : Text("Editar dados de: \n${state.people.name}"),
                leading: IconButton(
                  onPressed: () {
                    if (isCreate) {
                      context.read<PeopleCubit>().loadPeopleList();
                    } else {
                      context
                          .read<PeopleCubit>()
                          .selectPersonToDetail(state.people);
                    }
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
              ),
              body: PeopleEditCard(
                nameOnChanged: (value) => _name = value,
                emailOnChanged: (value) => _email = value,
                detailsOnChanged: (value) => _details = value,
              ),
              floatingActionButton: FloatingActionButton(
                child: const Icon(Icons.save),
                onPressed: () async {
                  var person = state.people;
                  var editedPerson = People(
                      id: person.id,
                      name: _name,
                      email: _email,
                      details: _details);

                  if (isCreate) {
                    try {
                      context.read<PeopleCubit>().createPeople(editedPerson);
                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                    } on Exception catch (e) {
                      var snackbar = SnackBar(content: Text(e.toString()));
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(snackbar);
                      }
                    }
                  } else {
                    try {
                      context.read<PeopleCubit>().updatePeople(editedPerson);
                      if (context.mounted) {
                        context
                            .read<PeopleCubit>()
                            .selectPersonToDetail(editedPerson);
                        Navigator.pop(context);
                      }
                    } on Exception catch (e) {
                      var snackbar = SnackBar(content: Text(e.toString()));
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(snackbar);
                      }
                    }
                  }
                },
              ),
            );
          }
        default:
          return const Center(
            child: Text('Erro ao carregar.'),
          );
      }
    });
  }
}
