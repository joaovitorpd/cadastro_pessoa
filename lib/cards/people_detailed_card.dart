import 'package:cadastro_pessoa/pages/people_detail_page.dart';
import 'package:flutter/material.dart';

class PeopleDetailedCard extends StatelessWidget {
  String? id;
  String? name;
  String? email;
  String? details;

  PeopleDetailedCard(
      {super.key,
      required this.id,
      required this.name,
      required this.email,
      required this.details});

  @override
  Widget build(BuildContext context) {
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
                    width: MediaQuery.of(context).size.width * 0.8,
                    margin: const EdgeInsets.all(1),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        name != null
                            ? Text(
                                "Id: $id",
                                style: const TextStyle(fontSize: 18),
                                textAlign: TextAlign.start,
                              )
                            : const Text("Sem id registrado"),
                        name != null
                            ? Text(
                                "Nome: $name",
                                style: const TextStyle(fontSize: 18),
                                textAlign: TextAlign.start,
                              )
                            : const Text("Sem nome registrado"),
                        email != null
                            ? Text(
                                "Email: $email",
                                style: const TextStyle(fontSize: 18),
                                textAlign: TextAlign.start,
                              )
                            : const Text("Sem email registrado"),
                        details != null
                            ? Text(
                                "Descrição: $details",
                                style: const TextStyle(fontSize: 18),
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
