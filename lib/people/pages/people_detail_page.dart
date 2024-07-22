import 'package:cadastro_pessoa/people/bloc/people_cubit.dart';
import 'package:cadastro_pessoa/people/cards/people_detailed_card.dart';
import 'package:cadastro_pessoa/people/models/people.dart';
import 'package:cadastro_pessoa/people/widgets/custom_confirmation_dialog.dart';
import 'package:cadastro_pessoa/people/widgets/menu_apple.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

import 'package:flutter_bloc/flutter_bloc.dart';

class PeopleDetailPage extends StatelessWidget {
  const PeopleDetailPage({
    super.key,
    required this.people,
  });

  final People people;

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
                context.read<PeopleCubit>().loadPeopleList();
              },
            ),
            middle: Text("Detalhes de ${people.name}"),
            trailing: MenuApple(
              builder: (_, showMenu) => CupertinoButton(
                onPressed: showMenu,
                padding: EdgeInsets.zero,
                pressedOpacity: 1,
                child: const Icon(CupertinoIcons.ellipsis_circle),
              ),
              people: people,
            )),
        child: SafeArea(
          child: PeopleDetailedCard(
            pessoa: people,
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text("Detalhes de ${people.name}"),
          leading: IconButton(
            onPressed: () {
              context.read<PeopleCubit>().loadPeopleList();
            },
            icon: const Icon(Icons.arrow_back),
          ),
          actions: [
            TextButton(
              onPressed: () {
                context.read<PeopleCubit>().selectEditPeople(people);
              },
              child: const Text("Editar"),
            ),
          ],
        ),
        body: PeopleDetailedCard(
          pessoa: people,
        ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.delete),
            onPressed: () => {
                  CustomConfirmationDialog().customConfirmationDialog(
                      context, "Atenção!!!", "Tem certeza que deseja apagar?",
                      () {
                    Navigator.pop(context);
                  }, () {
                    context.read<PeopleCubit>().deletePeople(people);
                    Navigator.pop(context);
                  })
                }),
      );
    }
  }
}
