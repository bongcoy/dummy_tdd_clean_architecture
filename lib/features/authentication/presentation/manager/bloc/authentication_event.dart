part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object?> get props => [];
}

class CreateUserEvent extends AuthenticationEvent {
  const CreateUserEvent({
    required this.id,
    required this.name,
    required this.avatar,
    required this.createdAt,
  });

  final String id;
  final String name;
  final String avatar;
  final DateTime createdAt;

  @override
  List<Object?> get props => [id, name, avatar, createdAt];
}

class GetUserEvent extends AuthenticationEvent {

  const GetUserEvent();
}