import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.label,
    this.onChanged,
    this.initialValue,
  });

  final String? label;
  final dynamic onChanged;
  final String? initialValue;
  //final TextInputFormatter formatter;

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoTextFormFieldRow(
        initialValue: initialValue,
        padding: const EdgeInsets.all(5.0),
        prefix: Text(label.toString()),
        placeholder: label!,
        /* inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ], */
      );
    } else {
      return TextFormField(
        initialValue: initialValue,
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: label,
        ),
        /* inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ], */
      );
    }
  }
}
