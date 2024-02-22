class People {
  String? id;
  String? name;
  String? email;
  String? details;

  People(
      {required this.id,
      required this.name,
      required this.email,
      required this.details});

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
