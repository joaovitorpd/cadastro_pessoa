import 'package:cadastro_pessoa/pages/people_detail_page.dart';
import 'package:flutter/material.dart';

class PeopleCard extends StatelessWidget {
  String? id;
  String? name;
  String? email;
  String? details;

  PeopleCard(
      {super.key,
      required this.id,
      required this.name,
      required this.email,
      required this.details});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PeopleDetailPage(
                    id: id, name: name, email: email, details: details)));
      },
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              width: 5,
            ),
            const Icon(
              Icons.account_circle,
              size: 50.0,
            ),
            const SizedBox(
              width: 5,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                name != null
                    ? Text(
                        name!,
                        style: const TextStyle(fontSize: 18),
                      )
                    : const Text("Sem nome registrado"),
                /* email != null
                    ? Text(
                        email!,
                        style: const TextStyle(fontSize: 12),
                      )
                    : const Text("Sem email registrado"), */
                details != null
                    ? Text(
                        details!,
                        style: const TextStyle(fontSize: 12),
                      )
                    : const Text("Sem detalhe registrado"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
