final usersList = <User>[
  User(id: "U101", name: "Ashish"),
  User(id: "U102", name: "Suraj"),
  User(id: "U103", name: "Saru"),
  User(id: "U104", name: "Debo"),
  User(id: "U105", name: "Mano")
];

class User {
  final String id;
  final String name;
  User({
    required this.id,
    required this.name,
  });

  User copyWith({
    String? id,
    String? name,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  String toString() => 'User(id: $id, name: $name)';
}
