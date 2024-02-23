import 'package:cadastro_pessoa/cards/people_detailed_card.dart';
import 'package:flutter/material.dart';

class PeopleDetailPage extends StatelessWidget {
  final String? id;
  final String? name;
  final String? email;
  final String? details;

  const PeopleDetailPage(
      {super.key,
      required this.id,
      required this.name,
      required this.email,
      required this.details});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalhes de $name"),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: PeopleDetailedCard(
          id: id, name: name, email: email, details: details),
    );
  }
}
