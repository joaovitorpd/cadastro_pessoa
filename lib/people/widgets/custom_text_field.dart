import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.label,
      required this.initialValue,
      required this.onChanged,
      required this.errorText});

  final String? initialValue;
  final String? label;
  final String? errorText;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return Column(
        children: [
          CupertinoTextFormFieldRow(
            padding: const EdgeInsets.all(5.0),
            prefix: Text(label.toString()),
            initialValue: initialValue,
            onChanged: onChanged,
            placeholder: label!,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 4.0),
            child: Text(
              errorText != null ? errorText! : '',
              style: const TextStyle(
                  color: CupertinoColors.systemRed, fontSize: 15),
            ),
          )
        ],
      );
    } else {
      return TextFormField(
        initialValue: initialValue,
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: label,
          errorText: errorText,
        ),
      );
    }
  }
}
