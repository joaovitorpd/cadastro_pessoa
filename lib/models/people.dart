import 'package:mobx/mobx.dart';

class People {
  @observable
  String? id;

  @observable
  String? name;

  @action
  setName(String? value) => name = value;

  @observable
  String? email;

  @action
  setEmail(String? value) => email = value;

  @observable
  String? details;

  @action
  setDetails(String? value) => details = value;

  People(
      {required this.id,
      required this.name,
      required this.email,
      required this.details});

  People.empty();

  factory People.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': String id,
        'name': String name,
        'email': String email,
        'details': String details,
      } =>
        People(
          id: id,
          name: name,
          email: email,
          details: details,
        ),
      _ => throw const FormatException('Falha ao carregar pessoa')
    };
  }
}
