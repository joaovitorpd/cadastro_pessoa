import 'dart:convert';
import 'package:cadastro_pessoa/core/utils/typedef.dart';
import 'package:cadastro_pessoa/src/people/domain/entities/people.dart';

class PeopleModel extends People {
  const PeopleModel({
    required super.id,
    required super.name,
    required super.email,
    required super.details,
  });

  const PeopleModel.empty()
      : this(id: null, name: null, email: null, details: null);

  factory PeopleModel.fromJson(String source) =>
      PeopleModel.fromMap(jsonDecode(source) as DataMap);

  PeopleModel.fromMap(DataMap map)
      : this(
          id: map['id'] as String?,
          name: map['name'] as String?,
          email: map['email'] as String?,
          details: map['details'] as String?,
        );

  PeopleModel copyWith({
    String? id,
    String? name,
    String? email,
    String? details,
  }) {
    return PeopleModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      details: details ?? this.details,
    );
  }

  DataMap toMap() => {
        'id': id,
        'name': name,
        'email': email,
        'details': details,
      };

  String toJson() => jsonEncode(toMap());
}
