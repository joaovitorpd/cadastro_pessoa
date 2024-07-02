import 'dart:io';

import 'package:cadastro_pessoa/cards/people_card.dart';
import 'package:cadastro_pessoa/models/people.dart';
import 'package:cadastro_pessoa/pages/people_detail_page.dart';
import 'package:cadastro_pessoa/pages/people_edit_page.dart';
import 'package:cadastro_pessoa/people_api_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = GetIt.I.get<PeopleApiController>();

  @override
  void initState() {
    super.initState();
    controller.getPeople();
  }

  @override
  Widget build(BuildContext context) {
    double cardHorizontalPadding = 8.0;
    double cardVerticalPadding = 1.0;

    if (Platform.isIOS) {
      return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: const Text("Cadastro de Pessoas"),
          trailing: CupertinoButton(
            padding: const EdgeInsets.all(1),
            child: const Icon(CupertinoIcons.add),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PeopleEditPage(
                            isCreate: true,
                          )));
            },
          ),
        ),
        child: FutureBuilder(
          future: controller.peopleFutureList,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Observer(builder: (_) {
                return ListView.builder(
                  itemCount: controller.peopleList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        controller.selectedPeople(controller.peopleList[index]);
                        Navigator.push<People>(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PeopleDetailPage(
                                      controller: controller,
                                    )));
                      },
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                            cardHorizontalPadding,
                            cardVerticalPadding,
                            cardHorizontalPadding,
                            cardVerticalPadding),
                        child: Observer(builder: (_) {
                          return PeopleCard(
                            pessoa: controller.peopleList[index],
                          );
                        }),
                      ),
                    );
                  },
                );
              });
            } else {
              return const Center(child: CupertinoActivityIndicator());
            }
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
          child: FutureBuilder(
            future: controller.peopleFutureList,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Observer(builder: (_) {
                  return ListView.builder(
                    itemCount: controller.peopleList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          controller
                              .selectedPeople(controller.peopleList[index]);
                          Navigator.push<People>(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PeopleDetailPage(
                                        controller: controller,
                                      )));
                        },
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(
                              cardHorizontalPadding,
                              cardVerticalPadding,
                              cardHorizontalPadding,
                              cardVerticalPadding),
                          child: Observer(builder: (_) {
                            return PeopleCard(
                              pessoa: controller.peopleList[index],
                            );
                          }),
                        ),
                      );
                    },
                  );
                });
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const PeopleEditPage(
                          isCreate: true,
                        )));
          },
        ),
      );
    }
  }
}
