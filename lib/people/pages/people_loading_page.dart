import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PeopleLoadingPage extends StatelessWidget {
  const PeopleLoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return const CupertinoPageScaffold(
        child: Center(
          child: CupertinoActivityIndicator(
            color: Colors.black,
          ),
        ),
      );
    } else {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            color: Colors.black,
          ),
        ),
      );
    }
  }
}
