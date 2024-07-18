import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.label,
      required this.initialValue,
      required this.onChanged});

  final String? initialValue;
  final String? label;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoTextFormFieldRow(
        padding: const EdgeInsets.all(5.0),
        prefix: Text(label.toString()),
        initialValue: initialValue,
        onChanged: onChanged,
        placeholder: label!,
      );
    } else {
      return TextFormField(
        initialValue: initialValue,
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: label,
        ),
      );
    }
  }
}
