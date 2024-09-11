import 'dart:io';
import 'package:cadastro_pessoa/people/cubit/people_cubit.dart';
import 'package:cadastro_pessoa/people/models/people.dart';
import 'package:cadastro_pessoa/people/widgets/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PeopleEditCard extends StatelessWidget {
  const PeopleEditCard({
    super.key,
    required this.people,
    required this.nameOnChanged,
    required this.emailOnChanged,
    required this.detailsOnChanged,
    // required this.errors,
    required this.formKey,
    // required this.nameController,
    // required this.emailController,
    // required this.detailsController,
  });

  final People people;
  final void Function(String)? nameOnChanged;
  final void Function(String)? emailOnChanged;
  final void Function(String)? detailsOnChanged;

  final Key formKey;

  List<Widget> form(BuildContext context, People person) {
    var nameStream = context.read<PeopleCubit>().nameStream;
    var emailStream = context.read<PeopleCubit>().emailStream;
    var detailsStream = context.read<PeopleCubit>().detailsStream;
    return [
      StreamBuilder<String?>(
          stream: nameStream,
          builder: (context, snapshot) {
            return CustomTextField(
              label: "Nome:",
              key: const Key('name-field'),
              initialValue: person.name,
              onChanged: nameOnChanged,
              errorText: snapshot.error as String?,
              onEditingComplete: () {
                context.read<PeopleCubit>().updatePeopleState();
              },
            );
          }),
      StreamBuilder<String?>(
          stream: emailStream,
          builder: (context, snapshot) {
            return CustomTextField(
              label: "E-mail:",
              key: const Key('email-field'),
              initialValue: person.email,
              onChanged: emailOnChanged,
              errorText: snapshot.error as String?,
              onEditingComplete: () {
                context.read<PeopleCubit>().updatePeopleState();
              },
            );
          }),
      StreamBuilder<String?>(
        stream: detailsStream,
        builder: (context, snapshot) {
          return CustomTextField(
            label: "Detalhes:",
            key: const Key('details-field'),
            initialValue: person.details,
            onChanged: detailsOnChanged,
            errorText: snapshot.error as String?,
            onEditingComplete: () {
              context.read<PeopleCubit>().updatePeopleState();
            },
          );
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoFormSection(
        key: formKey,
        header: const Text("Dados da pessoa:"),
        margin: const EdgeInsets.all(8.0),
        children: form(context, people),
      );
    } else {
      return Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: form(context, people),
          ),
        ),
      );
    }
  }
}
