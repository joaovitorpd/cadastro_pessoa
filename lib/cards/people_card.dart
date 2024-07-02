import 'package:cadastro_pessoa/models/people.dart';
import 'package:flutter/material.dart';

class PeopleCard extends StatelessWidget {
  const PeopleCard({
    super.key,
    required this.pessoa,
  });

  final People pessoa;

  @override
  Widget build(BuildContext context) {
    return Card(
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
              pessoa.name != null
                  ? Text(
                      pessoa.name!,
                      style: const TextStyle(fontSize: 18),
                    )
                  : const Text("Sem nome registrado"),
              /* email != null
                  ? Text(
                      email!,
                      style: const TextStyle(fontSize: 12),
                    )
                  : const Text("Sem email registrado"), */
              pessoa.details != null
                  ? Text(
                      pessoa.details!,
                      style: const TextStyle(fontSize: 12),
                    )
                  : const Text("Sem detalhe registrado"),
            ],
          ),
        ],
      ),
    );
  }
}
