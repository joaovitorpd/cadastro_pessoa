import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomConfirmationDialog {
  Future<void>? customConfirmationDialog(
      BuildContext context,
      String titleText,
      String contentText,
      void Function()? noOnPressed,
      void Function()? yesOnPressed) {
    if (Platform.isIOS) {
      return showCupertinoModalPopup<void>(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: Text(titleText),
          content: Text(contentText),
          actions: [
            CupertinoDialogAction(
              onPressed: noOnPressed,
              child: const Text("Não"),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              onPressed: yesOnPressed,
              child: const Text("Sim"),
            ),
          ],
        ),
      );
    } else {
      return showDialog<void>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(titleText),
          content: Text(contentText),
          actions: [
            TextButton(
              onPressed: noOnPressed,
              child: const Text("Não"),
            ),
            TextButton(
              onPressed: yesOnPressed,
              child: const Text(
                "Sim",
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      );
    }
  }
}
