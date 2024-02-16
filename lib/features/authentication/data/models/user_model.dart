import 'dart:convert';

import 'package:dummy_tdd_clean/core/utilities/typedef.dart';
import 'package:dummy_tdd_clean/features/authentication/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.name,
    required super.avatar,
    required super.createdAt,
  });

  UserModel.empty()
      : this(
          id: '_empty.id',
          name: '_empty.name',
          avatar: '_empty.avatar',
          createdAt: DateTime.now(),
        );

  factory UserModel.fromRawJson(String str) =>
      UserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserModel.fromJson(DataMap json) => UserModel(
        id: json["id"],
        name: json["name"],
        avatar: json["avatar"],
        createdAt: DateTime.parse(json["createdAt"]),
      );

  DataMap toJson() => {
        "id": id,
        "name": name,
        "avatar": avatar,
        "createdAt": createdAt.toIso8601String(),
      };

  UserModel copyWith({
    String? id,
    String? name,
    String? avatar,
    DateTime? createdAt,
  }) =>
      UserModel(
        id: id ?? this.id,
        name: name ?? this.name,
        avatar: avatar ?? this.avatar,
        createdAt: createdAt ?? this.createdAt,
      );
}
