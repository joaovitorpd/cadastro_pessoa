import 'package:cadastro_pessoa/people/bloc/people_cubit.dart';
import 'package:cadastro_pessoa/people/bloc/people_state.dart';
import 'package:cadastro_pessoa/people/models/people.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PeopleCard extends StatelessWidget {
  const PeopleCard({
    super.key,
    required this.person,
  });

  final People person;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PeopleCubit, PeopleState>(
      builder: (context, state) {
        switch (state) {
          case LoadingState():
            return const Center(
              child: CircularProgressIndicator(),
            );
          case LoadedState():
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
                      person.name != null
                          ? Text(
                              person.name!,
                              style: const TextStyle(fontSize: 18),
                            )
                          : const Text("Sem nome registrado"),
                      /* email != null
                  ? Text(
                      email!,
                      style: const TextStyle(fontSize: 12),
                    )
                  : const Text("Sem email registrado"), */
                      person.details != null
                          ? Text(
                              person.details!,
                              style: const TextStyle(fontSize: 12),
                            )
                          : const Text("Sem detalhe registrado"),
                    ],
                  ),
                ],
              ),
            );
          default:
            return const Center(
              child: Text('Pessoa não encontrada'),
            );
        }
      },
    );
  }
}
