import 'dart:convert';

class User {
  final String id;
  final String name;
  final String avatar;
  final DateTime createdAt;

  User({
    required this.id,
    required this.name,
    required this.avatar,
    required this.createdAt,
  });

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        avatar: json["avatar"],
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "avatar": avatar,
        "createdAt": createdAt.toIso8601String(),
      };
}
