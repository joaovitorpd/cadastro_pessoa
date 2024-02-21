class Pessoa {
  String? id;
  String? name;
  String? email;
  String? details;

  Pessoa(
      {required this.id,
      required this.name,
      required this.email,
      required this.details});

  factory Pessoa.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': String id,
        'name': String name,
        'email': String email,
        'details': String details,
      } =>
        Pessoa(
          id: id,
          name: name,
          email: email,
          details: details,
        ),
      _ => throw const FormatException('Falha ao carregar pessoa')
    };
  }
}
