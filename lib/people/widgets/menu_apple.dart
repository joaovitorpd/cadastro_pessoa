import 'package:cadastro_pessoa/people/bloc/people_cubit.dart';
import 'package:cadastro_pessoa/people/bloc/people_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_down_button/pull_down_button.dart';
import 'package:cadastro_pessoa/people/models/people.dart';
import 'package:cadastro_pessoa/people/pages/people_edit_page.dart';

class MenuApple extends StatelessWidget {
  const MenuApple({
    super.key,
    required this.builder,
  });

  final PullDownMenuButtonBuilder builder;

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
            return PullDownButton(
              itemBuilder: (context) => [
                PullDownMenuItem(
                  onTap: () {
                    final People person = state.people;
                    context.read<PeopleCubit>().selectPersonToEdit(person);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => PeopleEditPage(
                                  isCreate: false,
                                )));
                  },
                  title: "Editar",
                  icon: CupertinoIcons.pencil,
                ),
                PullDownMenuItem(
                  onTap: () {
                    if (context.mounted) {
                      showCupertinoModalPopup<void>(
                          barrierDismissible: false,
                          context: context,
                          builder: (BuildContext context) =>
                              CupertinoAlertDialog(
                                title: const Text("Atenção!!!",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                    )),
                                content: const Text(
                                    "Tem certeza que deseja apagar?"),
                                actions: <CupertinoDialogAction>[
                                  CupertinoDialogAction(
                                    child: const Text("Não"),
                                    onPressed: () {
                                      context
                                          .read<PeopleCubit>()
                                          .loadPeopleList();
                                      Navigator.pop(context);
                                    },
                                  ),
                                  CupertinoDialogAction(
                                    isDestructiveAction: true,
                                    child: const Text(
                                      "Sim",
                                    ),
                                    onPressed: () async {
                                      try {
                                        final People person = state.people;
                                        context
                                            .read<PeopleCubit>()
                                            .deletePeople(person);
                                        if (context.mounted) {
                                          context
                                              .read<PeopleCubit>()
                                              .loadPeopleList();
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        }
                                      } on Exception catch (e) {
                                        if (context.mounted) {
                                          showCupertinoModalPopup<void>(
                                            barrierDismissible: false,
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
                                  ),
                                ],
                              ));
                    }
                  },
                  title: "Delete",
                  isDestructive: true,
                  icon: CupertinoIcons.delete,
                ),
              ],
              buttonBuilder: builder,
            );
          default:
            return const Center(child: Text('Erro ao carregar pessoas!'));
        }
      },
    );
  }
}
