import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dummy_tdd_clean/features/authentication/domain/entities/user.dart';
import 'package:dummy_tdd_clean/features/authentication/domain/use_cases/create_user.dart';
import 'package:dummy_tdd_clean/features/authentication/domain/use_cases/get_users.dart';
import 'package:equatable/equatable.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc(
      {required CreateUser createUser, required GetUsers getUsers})
      : _createUser = createUser,
        _getUsers = getUsers,
        super(const AuthenticationInitial()) {
    on<CreateUserEvent>(_createUserHandler);
    on<GetUserEvent>(_getUserHandler);
  }

  final CreateUser _createUser;
  final GetUsers _getUsers;

  Future<void> _createUserHandler(
    CreateUserEvent event,
    Emitter<AuthenticationState> emitter,
  ) async {
    emit(const CreatingUser());
    final result = await _createUser(CreateUserParams(
      id: event.id,
      name: event.name,
      avatar: event.avatar,
      createdAt: event.createdAt,
    ));

    result.fold(
      (l) => emit(AuthenticationError(message: l.errorMessage)),
      (r) => emit(const UserCreated()),
    );
  }

  Future<void> _getUserHandler(
    GetUserEvent event,
    Emitter<AuthenticationState> emitter,
  ) async {
    emit(const GettingUsers());
    final result = await _getUsers();

    result.fold(
      (failure) => emit(AuthenticationError(message: failure.errorMessage)),
      (users) => emit(UsersLoaded(users: users)),
    );
  }
}
