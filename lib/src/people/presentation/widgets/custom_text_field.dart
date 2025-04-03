import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.label,
    required this.initialValue,
    required this.onChanged,
    required this.errorText,
    required this.onEditingComplete,
    // required this.validator,
    // required this.controller
  });

  final String? initialValue;
  final String? label;
  final String? errorText;
  final void Function(String)? onChanged;
  final VoidCallback? onEditingComplete;
  // final TextEditingController controller;
  // final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return Column(
        children: [
          CupertinoTextFormFieldRow(
            padding: const EdgeInsets.all(5.0),
            prefix: Text(label.toString()),
            initialValue: initialValue,
            // controller: controller,
            onEditingComplete: onEditingComplete,
            onChanged: onChanged,
            placeholder: label!,
            key: key,
            // validator: validator,
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
        onEditingComplete: onEditingComplete,
        key: key,
        // validator: validator,
        decoration: InputDecoration(
          labelText: label,
          errorText: errorText,
        ),
      );
    }
  }
}
