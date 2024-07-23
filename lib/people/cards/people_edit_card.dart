import 'dart:io';
import 'package:cadastro_pessoa/people/models/people.dart';
import 'package:cadastro_pessoa/people/widgets/custom_text_field.dart';
import 'package:flutter/cupertino.dart';

class PeopleEditCard extends StatelessWidget {
  const PeopleEditCard({
    super.key,
    required this.people,
    required this.nameOnChanged,
    required this.emailOnChanged,
    required this.detailsOnChanged,
    required this.errors,
  });

  final People people;
  final void Function(String)? nameOnChanged;
  final void Function(String)? emailOnChanged;
  final void Function(String)? detailsOnChanged;
  final Map<String, String>? errors;

  List<Widget> form(People person) {
    return [
      CustomTextField(
        label: "Nome:",
        initialValue: person.name,
        onChanged: nameOnChanged,
        errorText: errors?['name'],
        //formatter: FilteringTextInputFormatter.digitsOnly,
      ),
      CustomTextField(
        label: "E-mail:",
        initialValue: person.email,
        onChanged: emailOnChanged,
        errorText: errors?['email'],
        //formatter: FilteringTextInputFormatter.digitsOnly,
      ),
      CustomTextField(
        label: "Detalhes:",
        initialValue: person.details,
        onChanged: detailsOnChanged,
        errorText: errors?['details'],
        //formatter: FilteringTextInputFormatter.digitsOnly,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoFormSection(
        header: const Text("Dados da pessoa:"),
        margin: const EdgeInsets.all(8.0),
        children: form(people),
      );
    } else {
      return Form(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: form(people),
          ),
        ),
      );
    }
  }
}
