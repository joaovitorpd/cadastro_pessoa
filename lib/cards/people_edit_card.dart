import 'package:cadastro_pessoa/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class PeopleEditCard extends StatelessWidget {
  const PeopleEditCard(
      {super.key,
      required this.id,
      required this.name,
      required this.email,
      required this.details,
      required this.nameController,
      required this.emailController,
      required this.detailsController});

  final String? id;
  final String? name;
  final String? email;
  final String? details;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController detailsController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(
              label: "Nome:",
              controller: nameController,
              value: name,
              //formatter: FilteringTextInputFormatter.digitsOnly,
            ),
            CustomTextField(
              label: "E-mail:",
              controller: emailController,
              value: email,
              //formatter: FilteringTextInputFormatter.digitsOnly,
            ),
            CustomTextField(
              label: "Detalhes:",
              controller: detailsController,
              value: details,
              //formatter: FilteringTextInputFormatter.digitsOnly,
            ),
          ],
        ),
      ),
    );
  }
}
