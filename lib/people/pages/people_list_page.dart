import 'dart:io';

import 'package:cadastro_pessoa/people/cubit/people_cubit.dart';
import 'package:cadastro_pessoa/people/cubit/people_state.dart';
import 'package:cadastro_pessoa/people/cards/people_card.dart';
import 'package:cadastro_pessoa/people/models/people.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PeopleListPage extends StatelessWidget {
  PeopleListPage({
    super.key,
  });
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: _titleText(),
          trailing: CupertinoButton(
            padding: const EdgeInsets.all(1),
            child: const Icon(CupertinoIcons.add),
            onPressed: () {
              _createPeople(context);
            },
          ),
        ),
        child: _peopleListView(controller: _scrollController),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: _titleText(),
        ),
        body: Padding(
          padding: const EdgeInsets.all(5.0),
          child: _peopleListView(controller: _scrollController),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            _createPeople(context);
          },
        ),
      );
    }
  }

  Widget _peopleListView({ScrollController? controller}) {
    double cardHorizontalPadding = 8.0;
    double cardVerticalPadding = 1.0;
    return BlocBuilder<PeopleCubit, PeopleState>(
      builder: (context, state) {
        if (state is PeopleListState) {
          return Scrollbar(
            thumbVisibility: true,
            controller: controller,
            child: ListView.builder(
              controller: controller,
              itemCount: state.peopleList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    final People people = state.peopleList[index];
                    context.read<PeopleCubit>().selectDetailsPeople(people);
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
          return const Center(
            child: Text('Ocorreu um erro'),
          );
        }
      },
    );
  }

  Widget _titleText() {
    return const Text("Cadastro de Pessoas");
  }

  void _createPeople(BuildContext context) {
    context.read<PeopleCubit>().selectCreatePeople();
  }
}
