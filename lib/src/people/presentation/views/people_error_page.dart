import 'dart:io';
import 'package:cadastro_pessoa/src/people/presentation/cubit/people_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PeopleErrorPage extends StatelessWidget {
  const PeopleErrorPage({super.key, required this.errorText});

  final String errorText;

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          leading: CupertinoButton(
            padding: const EdgeInsets.all(1),
            child: const Icon(CupertinoIcons.refresh),
            onPressed: () async {
              await _reloadOnPressed(context);
            },
          ),
          middle: _titleText(),
        ),
        child: _body(errorText),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              _reloadOnPressed(context);
            },
            icon: const Icon(Icons.refresh),
          ),
          title: _titleText(),
        ),
        body: Padding(
          padding: const EdgeInsets.all(5.0),
          child: _body(errorText),
        ),
      );
    }
  }

  Widget _titleText() {
    return const Text("Cadastro de Pessoas");
  }

  Future<void> _reloadOnPressed(BuildContext context) async {
    return context.read<PeopleCubit>().getPeople();
  }

  Widget _body(String errorText) {
    return Center(
        child: Text(
      errorText,
      style: const TextStyle(color: Colors.redAccent),
    ));
  }
}
