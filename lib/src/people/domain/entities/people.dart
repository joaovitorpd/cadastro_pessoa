import 'package:equatable/equatable.dart';

class People extends Equatable {
  const People(
      {required this.id,
      required this.name,
      required this.email,
      required this.details});

  const People.empty()
      : id = null,
        name = null,
        email = null,
        details = null;

  final String? id;
  final String? name;
  final String? email;
  final String? details;

  @override
  List<Object?> get props => [id, name, email, details];
}
