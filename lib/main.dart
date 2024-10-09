import 'dart:io';
import 'package:cadastro_pessoa/core/services/injection_container.dart';
import 'package:cadastro_pessoa/src/people/presentation/cubit/people_cubit.dart';
import 'package:cadastro_pessoa/src/people/presentation/views/people_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const PeopleRegistrationApp());
}

class PeopleRegistrationApp extends StatelessWidget {
  const PeopleRegistrationApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return BlocProvider(
        create: (context) => sl<PeopleCubit>()..getPeople(),
        child: const CupertinoApp(
          debugShowCheckedModeBanner: false,
          theme: CupertinoThemeData(
            brightness: Brightness.light,
            applyThemeToAll: true,
          ),
          home: PeoplePage(),
        ),
      );
    } else {
      return BlocProvider(
        create: (context) => sl<PeopleCubit>(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Cadastro de Pessoas',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: const PeoplePage(),
        ),
      );
    }
  }
}
