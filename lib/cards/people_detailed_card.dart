import 'dart:io';

import 'package:flutter/material.dart';

class PeopleDetailedCard extends StatelessWidget {
  final String? id;
  final String? name;
  final String? email;
  final String? details;

  const PeopleDetailedCard(
      {super.key,
      required this.id,
      required this.name,
      required this.email,
      required this.details});

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
                        name != null
                            ? Text(
                                "Id: $id",
                                style: TextStyle(fontSize: fontSize),
                                textAlign: TextAlign.start,
                              )
                            : const Text("Sem id registrado"),
                        SizedBox(
                          height: lineHight,
                        ),
                        name != null
                            ? Text(
                                "Nome: $name",
                                style: TextStyle(fontSize: fontSize),
                                textAlign: TextAlign.start,
                              )
                            : const Text("Sem nome registrado"),
                        SizedBox(
                          height: lineHight,
                        ),
                        email != null
                            ? Text(
                                "Email: $email",
                                style: TextStyle(fontSize: fontSize),
                                textAlign: TextAlign.start,
                              )
                            : const Text("Sem email registrado"),
                        SizedBox(
                          height: lineHight,
                        ),
                        details != null
                            ? Text(
                                "Descrição: $details",
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
