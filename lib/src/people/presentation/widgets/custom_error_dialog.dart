import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomErrorDialog {
  Future<void>? customErrorDialog(
    BuildContext context,
    String titleText,
    String contentText,
    void Function()? onPressed,
  ) {
    if (Platform.isIOS) {
      return showCupertinoModalPopup<void>(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: Text(titleText),
          content: Text(contentText),
          actions: <CupertinoDialogAction>[
            CupertinoDialogAction(
              onPressed: onPressed,
              child: const Text("Ok"),
            ),
          ],
        ),
      );
    } else {
      return showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(titleText),
          content: Text(contentText),
          actions: [
            TextButton(
              onPressed: onPressed,
              child: const Text("Ok"),
            ),
          ],
        ),
      );
    }
  }
}
