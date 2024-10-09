import 'package:cadastro_pessoa/src/people/data/models/people_model.dart';
import 'package:cadastro_pessoa/src/people/presentation/cubit/people_cubit.dart';
import 'package:cadastro_pessoa/src/people/presentation/widgets/custom_confirmation_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_down_button/pull_down_button.dart';

class MenuApple extends StatelessWidget {
  const MenuApple({
    super.key,
    required this.builder,
    required this.people,
  });

  final PullDownMenuButtonBuilder builder;
  final PeopleModel people;

  @override
  Widget build(BuildContext context) {
    return PullDownButton(
      itemBuilder: (context) => [
        PullDownMenuItem(
          onTap: () {
            context.read<PeopleCubit>().selectEditPeople(people);
          },
          title: "Editar",
          icon: CupertinoIcons.pencil,
        ),
        PullDownMenuItem(
          onTap: () {
            CustomConfirmationDialog().customConfirmationDialog(
                context, "Atenção!!!", "Tem certeza que deseja apagar?", () {
              Navigator.pop(context);
            }, () {
              context.read<PeopleCubit>().deletePeople(people);
              Navigator.pop(context);
            });
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
