import 'package:cadastro_pessoa/people/bloc/people_cubit.dart';
import 'package:cadastro_pessoa/people/bloc/people_state.dart';
import 'package:cadastro_pessoa/people/pages/people_create_page.dart';
import 'package:cadastro_pessoa/people/pages/people_detail_page.dart';
import 'package:cadastro_pessoa/people/pages/people_edit_page.dart';
import 'package:cadastro_pessoa/people/pages/people_error_page.dart';
import 'package:cadastro_pessoa/people/pages/people_list_page.dart';
import 'package:cadastro_pessoa/people/pages/people_loading_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PeoplePage extends StatelessWidget {
  const PeoplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PeopleCubit, PeopleState>(
      builder: (context, state) {
        switch (state) {
          case LoadingState():
            return const PeopleLoadingPage();

          case PeopleListState():
            return PeopleListPage();

          case PeopleDetailState():
            return PeopleDetailPage(people: state.people);

          case PeopleEditState():
            return PeopleEditPage(
              people: state.people,
            );

          case PeopleCreateState():
            return PeopleCreatePage(
              people: state.people,
            );

          case ErrorState():
            return PeopleErrorPage(errorText: state.error);
          default:
            return const Center(
                child: Text(
              'Erro ao carregar pessoas!',
              style: TextStyle(color: Colors.redAccent),
            ));
        }
      },
    );
  }
}
