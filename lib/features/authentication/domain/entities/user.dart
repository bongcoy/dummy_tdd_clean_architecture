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

  @override
  List<Object?> get props => [id, name, avatar, createdAt];
}
