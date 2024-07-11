import 'dart:io';

import 'package:cadastro_pessoa/people/bloc/people_cubit.dart';
import 'package:cadastro_pessoa/people/bloc/people_state.dart';
import 'package:cadastro_pessoa/people/cards/people_card.dart';
import 'package:cadastro_pessoa/people/models/people.dart';
import 'package:cadastro_pessoa/people/pages/people_detail_page.dart';
import 'package:cadastro_pessoa/people/pages/people_edit_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double cardHorizontalPadding = 8.0;
    double cardVerticalPadding = 1.0;

    return BlocBuilder<PeopleCubit, PeopleState>(
      builder: (context, state) {
        switch (state) {
          case LoadingState():
            return const Center(child: CircularProgressIndicator());
          case LoadedState():
            {
              if (Platform.isIOS) {
                return CupertinoPageScaffold(
                  navigationBar: CupertinoNavigationBar(
                    middle: const Text("Cadastro de Pessoas"),
                    trailing: CupertinoButton(
                      padding: const EdgeInsets.all(1),
                      child: const Icon(CupertinoIcons.add),
                      onPressed: () {
                        final People person = People.empty();
                        context.read<PeopleCubit>().selectPersonToEdit(person);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PeopleEditPage(
                                      isCreate: true,
                                    )));
                      },
                    ),
                  ),
                  child: ListView.builder(
                    itemCount: state.peopleList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () async {
                          final People person = state.peopleList[index];
                          context
                              .read<PeopleCubit>()
                              .selectPersonToDetail(person);
                          await Navigator.push<People>(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const PeopleDetailPage()));
                        },
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(
                              cardHorizontalPadding,
                              cardVerticalPadding,
                              cardHorizontalPadding,
                              cardVerticalPadding),
                          child: PeopleCard(
                            person: state.peopleList[index],
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else {
                return Scaffold(
                  appBar: AppBar(
                    title: const Center(
                        child: Text(
                      "Cadastro de Pessoas",
                    )),
                  ),
                  body: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ListView.builder(
                      itemCount: state.peopleList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () async {
                            final People person = state.peopleList[index];
                            context
                                .read<PeopleCubit>()
                                .selectPersonToDetail(person);
                            await Navigator.push<People>(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const PeopleDetailPage()));
                          },
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(
                                cardHorizontalPadding,
                                cardVerticalPadding,
                                cardHorizontalPadding,
                                cardVerticalPadding),
                            child: PeopleCard(
                              person: state.peopleList[index],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  floatingActionButton: FloatingActionButton(
                    child: const Icon(Icons.add),
                    onPressed: () {
                      final People person = People.empty();
                      context.read<PeopleCubit>().selectPersonToEdit(person);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PeopleEditPage(
                                    isCreate: true,
                                  )));
                    },
                  ),
                );
              }
            }
          default:
            return const Center(child: Text('Erro ao carregar pessoas!'));
        }
      },
    );
  }
}
