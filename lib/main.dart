import 'dart:io';
import 'package:cadastro_pessoa/people/cubit/people_cubit.dart';
import 'package:cadastro_pessoa/people/data/people_repository.dart';
import 'package:cadastro_pessoa/people/pages/people_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

void main() {
  final Client client = Client();
  final PeopleRepository peopleRepository = PeopleRepository(client: client);
  runApp(BlocProvider(
    create: (context) =>
        PeopleCubit(client: client, peopleRepository: peopleRepository),
    child: const PeopleRegistrationApp(),
  ));
}

class PeopleRegistrationApp extends StatelessWidget {
  const PeopleRegistrationApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return const CupertinoApp(
        debugShowCheckedModeBanner: false,
        theme: CupertinoThemeData(brightness: Brightness.light),
        home: PeoplePage(),
      );
    } else {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Cadastro de Pessoas',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const PeoplePage(),
      );
    }
  }
}
