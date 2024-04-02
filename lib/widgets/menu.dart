import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_down_button/pull_down_button.dart';
import 'package:cadastro_pessoa/models/people.dart';
import 'package:cadastro_pessoa/pages/people_edit_page.dart';
import 'package:cadastro_pessoa/people_api_client.dart';

class Menu extends StatelessWidget {
  const Menu(
      {super.key,
      required this.builder,
      required this.pessoa,
      required this.pessoaApiClient,
      required this.callback});

  final PullDownMenuButtonBuilder builder;
  final People pessoa;
  final PeopleApiClient pessoaApiClient;
  final void Function(People people) callback;

  @override
  Widget build(BuildContext context) {
    return PullDownButton(
      itemBuilder: (context) => [
        PullDownMenuItem(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PeopleEditPage(
                          isCreate: false,
                          pessoa: pessoa,
                          pessoaApiClient: pessoaApiClient,
                        ))).then((result) {
              if (result != null) {
                callback(result);
              }
            });
          },
          title: "Editar",
          icon: CupertinoIcons.pencil,
        ),
        PullDownMenuItem(
          onTap: () {},
          title: "Delete",
          isDestructive: true,
          icon: CupertinoIcons.delete,
        ),
      ],
      buttonBuilder: builder,
    );
  }
}
