import 'dart:io';
import 'package:cadastro_pessoa/people_api_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

class PeopleDetailedCard extends StatelessWidget {
  const PeopleDetailedCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = GetIt.I.get<PeopleApiController>();
    // People pessoa = controller.pessoa;

    double lineHight = 10;
    double fontSize = 16;
    double cardWidth;

    if (Platform.isIOS) {
      cardWidth = 0.8;
    } else {
      cardWidth = 0.75;
    }

    return GestureDetector(
      child: Column(
        children: [
          const SizedBox(
            height: 5,
          ),
          Container(
            padding: const EdgeInsets.all(5),
            child: Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.all(3),
                    child: const Icon(
                      Icons.account_circle,
                      size: 50.0,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * cardWidth,
                    margin: const EdgeInsets.all(1),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        controller.people.name != null
                            ? Observer(builder: (_) {
                                return Text(
                                  "Id: ${controller.people.id}",
                                  style: TextStyle(fontSize: fontSize),
                                  textAlign: TextAlign.start,
                                );
                              })
                            : const Text("Sem id registrado"),
                        SizedBox(
                          height: lineHight,
                        ),
                        controller.people.name != null
                            ? Observer(builder: (_) {
                                return Text(
                                  "Nome: ${controller.people.name}",
                                  style: TextStyle(fontSize: fontSize),
                                  textAlign: TextAlign.start,
                                );
                              })
                            : const Text("Sem nome registrado"),
                        SizedBox(
                          height: lineHight,
                        ),
                        controller.people.email != null
                            ? Observer(builder: (_) {
                                return Text(
                                  "Email: ${controller.people.email}",
                                  style: TextStyle(fontSize: fontSize),
                                  textAlign: TextAlign.start,
                                );
                              })
                            : const Text("Sem email registrado"),
                        SizedBox(
                          height: lineHight,
                        ),
                        controller.people.details != null
                            ? Observer(builder: (_) {
                                return Text(
                                  "Descrição: ${controller.people.details}",
                                  style: TextStyle(fontSize: fontSize),
                                  textAlign: TextAlign.start,
                                );
                              })
                            : const Text("Sem detalhe registrado"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
