import 'dart:io';

import 'package:cadastro_pessoa/models/people.dart';
import 'package:cadastro_pessoa/people_api_controller.dart';
import 'package:cadastro_pessoa/widgets/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

class PeopleEditCard extends StatelessWidget {
  const PeopleEditCard({
    super.key,
  });

  List<Widget> form(PeopleApiController controller) {
    return [
      CustomTextField(
        initialValue: controller.people.name,
        label: "Nome:",
        onChanged: controller.people.setName,
        //formatter: FilteringTextInputFormatter.digitsOnly,
      ),
      CustomTextField(
        initialValue: controller.people.email,
        label: "E-mail:",
        onChanged: controller.people.setEmail,
        //formatter: FilteringTextInputFormatter.digitsOnly,
      ),
      CustomTextField(
        initialValue: controller.people.details,
        label: "Detalhes:",
        onChanged: controller.people.setDetails,
        //formatter: FilteringTextInputFormatter.digitsOnly,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final controller = GetIt.I.get<PeopleApiController>();

    if (Platform.isIOS) {
      return CupertinoFormSection(
        header: const Text("Dados da pessoa:"),
        margin: const EdgeInsets.all(8.0),
        children: form(controller),
      );
    } else {
      return Form(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: form(controller),
          ),
        ),
      );
    }
  }
}
