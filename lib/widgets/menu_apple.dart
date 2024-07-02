import 'package:cadastro_pessoa/people_api_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_down_button/pull_down_button.dart';
import 'package:cadastro_pessoa/models/people.dart';
import 'package:cadastro_pessoa/pages/people_edit_page.dart';

class MenuApple extends StatelessWidget {
  const MenuApple({
    super.key,
    required this.builder,
    required this.controller,
  });

  final PullDownMenuButtonBuilder builder;

  final PeopleApiController controller;

  @override
  Widget build(BuildContext context) {
    // final controller = GetIt.I.get<PeopleApiController>();
    People pessoa = controller.people;

    return PullDownButton(
      itemBuilder: (context) => [
        PullDownMenuItem(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const PeopleEditPage(
                          isCreate: false,
                        )));
          },
          title: "Editar",
          icon: CupertinoIcons.pencil,
        ),
        PullDownMenuItem(
          onTap: () {
            if (context.mounted) {
              showCupertinoModalPopup<void>(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) => CupertinoAlertDialog(
                        title: const Text("Atenção!!!",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            )),
                        content: const Text("Tem certeza que deseja apagar?"),
                        actions: <CupertinoDialogAction>[
                          CupertinoDialogAction(
                            child: const Text("Não"),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          CupertinoDialogAction(
                            isDestructiveAction: true,
                            child: const Text(
                              "Sim",
                            ),
                            onPressed: () async {
                              try {
                                await controller.deletePeople(pessoa);
                                if (context.mounted) {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                }
                              } on Exception catch (e) {
                                if (context.mounted) {
                                  showCupertinoModalPopup<void>(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (BuildContext context) =>
                                        CupertinoAlertDialog(
                                      title: const Text("Erro!"),
                                      content: Text(e.toString()),
                                      actions: <CupertinoDialogAction>[
                                        CupertinoDialogAction(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                          },
                                          child: const Text("OK"),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              }
                            },
                          ),
                        ],
                      ));
            }
          },
          title: "Delete",
          isDestructive: true,
          icon: CupertinoIcons.delete,
        ),
      ],
      buttonBuilder: builder,
    );
  }
}
