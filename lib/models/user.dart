class User {
  final int id;
  final String name;
  final String email;
  User(this.id, this.name, this.email);

  factory User.fromJson(Map<String, dynamic> json) {
    return User(json['id'], json['name'], json['email']);
  }
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'email': email};
  }
}
