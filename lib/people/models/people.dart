import 'package:equatable/equatable.dart';

class People extends Equatable {
  final String? id;
  final String? name;
  final String? email;
  final String? details;

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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'details': details,
    };
  }

  factory People.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': String? id,
        'name': String? name,
        'email': String? email,
        'details': String? details,
      } =>
        People(
          id: id,
          name: name,
          email: email,
          details: details,
        ),
      _ => throw const FormatException('Falha ao desserializar Pessoa')
    };
  }

  People copyWith({
    String? id,
    String? name,
    String? email,
    String? details,
  }) {
    return People(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      details: details ?? this.details,
    );
  }

  @override
  List<Object?> get props => [id, name, email, details];
}
