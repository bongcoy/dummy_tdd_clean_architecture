import 'dart:convert';

import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String name;
  final String avatar;
  final DateTime createdAt;

  const User({
    required this.id,
    required this.name,
    required this.avatar,
    required this.createdAt,
  });

  User.empty()
      : this(
    id: '_empty.id',
    name: '_empty.name',
    avatar: '_empty.avatar',
    createdAt: DateTime.now(),
  );

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

  @override
  List<Object?> get props => throw UnimplementedError();
}
