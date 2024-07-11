import 'package:cadastro_pessoa/people/bloc/people_cubit.dart';
import 'package:cadastro_pessoa/people/bloc/people_state.dart';
import 'package:cadastro_pessoa/people/cards/people_detailed_card.dart';
import 'package:cadastro_pessoa/people/models/people.dart';
import 'package:cadastro_pessoa/people/pages/people_edit_page.dart';
import 'package:cadastro_pessoa/people/widgets/menu_apple.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

import 'package:flutter_bloc/flutter_bloc.dart';

class PeopleDetailPage extends StatelessWidget {
  const PeopleDetailPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PeopleCubit, PeopleState>(
      builder: (context, state) {
        switch (state) {
          case LoadingState():
            return const Center(
              child: CircularProgressIndicator(),
            );
          case PeopleDetailState():
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
                        context.read<PeopleCubit>().loadPeopleList();
                        Navigator.pop(context);
                      },
                    ),
                    middle: Text("Detalhes de ${state.people.name}"),
                    trailing: MenuApple(
                      builder: (_, showMenu) => CupertinoButton(
                        onPressed: showMenu,
                        padding: EdgeInsets.zero,
                        pressedOpacity: 1,
                        child: const Icon(CupertinoIcons.ellipsis_circle),
                      ),
                    )),
                child: SafeArea(
                  child: PeopleDetailedCard(
                    pessoa: state.people,
                  ),
                ),
              );
            } else {
              return Scaffold(
                appBar: AppBar(
                  title: Text("Detalhes de ${state.people.name}"),
                  leading: IconButton(
                    onPressed: () {
                      context.read<PeopleCubit>().loadPeopleList();
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PeopleEditPage(
                                      isCreate: false,
                                    )));
                      },
                      child: const Text("Editar"),
                    ),
                  ],
                ),
                body: PeopleDetailedCard(
                  pessoa: state.people,
                ),
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
                              final People person = state.people;
                              context.read<PeopleCubit>().deletePeople(person);
                              if (context.mounted) {
                                Navigator.pop(context);
                                Navigator.pop(context);
                              }
                            } on Exception catch (e) {
                              if (context.mounted) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
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

          default:
            return const Center(child: Text('Erro ao carregar pessoas!'));
        }
      },
    );
  }
}
