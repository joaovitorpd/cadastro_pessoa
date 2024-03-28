import 'dart:io';

import 'package:cadastro_pessoa/models/people.dart';
import 'package:cadastro_pessoa/people_api_client.dart';
import 'package:flutter/material.dart';

class PeopleDetailedCard extends StatelessWidget {
  const PeopleDetailedCard(
      {super.key, required this.pessoa, required this.pessoaApiClient});

  final People pessoa;
  final PeopleApiClient pessoaApiClient;

  @override
  Widget build(BuildContext context) {
    double lineHight = 10;
    double fontSize = 16;
    double cardWidth;

    if (Platform.isAndroid) {
      cardWidth = 0.75;
    } else if (Platform.isIOS) {
      cardWidth = 0.8;
    } else {
      cardWidth = 0.75;
    }

    return GestureDetector(
      /* onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PeopleDetailPage(
                    id: id, name: name, email: email, details: details)));
      }, */
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
                        pessoa.name != null
                            ? Text(
                                "Id: ${pessoa.id}",
                                style: TextStyle(fontSize: fontSize),
                                textAlign: TextAlign.start,
                              )
                            : const Text("Sem id registrado"),
                        SizedBox(
                          height: lineHight,
                        ),
                        pessoa.name != null
                            ? Text(
                                "Nome: ${pessoa.name}",
                                style: TextStyle(fontSize: fontSize),
                                textAlign: TextAlign.start,
                              )
                            : const Text("Sem nome registrado"),
                        SizedBox(
                          height: lineHight,
                        ),
                        pessoa.email != null
                            ? Text(
                                "Email: ${pessoa.email}",
                                style: TextStyle(fontSize: fontSize),
                                textAlign: TextAlign.start,
                              )
                            : const Text("Sem email registrado"),
                        SizedBox(
                          height: lineHight,
                        ),
                        pessoa.details != null
                            ? Text(
                                "Descrição: ${pessoa.details}",
                                style: TextStyle(fontSize: fontSize),
                                textAlign: TextAlign.start,
                              )
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
