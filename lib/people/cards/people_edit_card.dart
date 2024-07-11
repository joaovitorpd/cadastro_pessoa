import 'dart:io';
import 'package:cadastro_pessoa/people/bloc/people_cubit.dart';
import 'package:cadastro_pessoa/people/bloc/people_state.dart';
import 'package:cadastro_pessoa/people/models/people.dart';
import 'package:cadastro_pessoa/people/widgets/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PeopleEditCard extends StatelessWidget {
  PeopleEditCard({
    super.key,
    required this.nameOnChanged,
    required this.emailOnChanged,
    required this.detailsOnChanged,
  });

  void Function(String)? nameOnChanged;
  void Function(String)? emailOnChanged;
  void Function(String)? detailsOnChanged;

  List<Widget> form(People person) {
    return [
      CustomTextField(
        label: "Nome:",
        initialValue: person.name,
        onChanged: nameOnChanged,
        //formatter: FilteringTextInputFormatter.digitsOnly,
      ),
      CustomTextField(
        label: "E-mail:",
        initialValue: person.email,
        onChanged: emailOnChanged,
        //formatter: FilteringTextInputFormatter.digitsOnly,
      ),
      CustomTextField(
        label: "Detalhes:",
        initialValue: person.details,
        onChanged: detailsOnChanged,
        //formatter: FilteringTextInputFormatter.digitsOnly,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PeopleCubit, PeopleState>(builder: (context, state) {
      switch (state) {
        case LoadingState():
          return const Center(
            child: Text('Carregando pessoa'),
          );
        case PeopleEditState():
          if (Platform.isIOS) {
            return CupertinoFormSection(
              header: const Text("Dados da pessoa:"),
              margin: const EdgeInsets.all(8.0),
              children: form(state.people),
            );
          } else {
            return Form(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: form(state.people),
                ),
              ),
            );
          }
        default:
          return const Center(
            child: Text('Ocorreu um erro'),
          );
      }
    });
  }
}
