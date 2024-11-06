import 'package:mobile/models/language.dart';

class User {
  final int id;
  final String username;
  final List<Language> linguas;

  User({required this.id, required this.username, required this.linguas});

  factory User.fromJson(Map<String, dynamic> json) {
    var list = json['línguas'] as List;
    List<Language> linguasList = list.map((i) => Language.fromJson(i)).toList();
    return User(
      id: json['id'],
      username: json['username'],
      linguas: linguasList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'línguas': linguas.map((i) => i.toJson()).toList(),
    };
  }
}
