import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.label,
      required this.controller,
      //required this.formatter,
      required this.value});

  final String? value;
  final String? label;
  final TextEditingController controller;
  //final TextInputFormatter formatter;

  @override
  Widget build(BuildContext context) {
    var controller = TextEditingController(text: value);

    if (Platform.isIOS) {
      return CupertinoTextFormFieldRow(
        prefix: Text(label.toString()),
        controller: controller,
        placeholder: label!,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
      );
    } else {
      return TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
        ),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
      );
    }
  }
}
