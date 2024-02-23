import 'package:bloc/bloc.dart';
import 'package:dummy_tdd_clean/features/authentication/domain/entities/user.dart';
import 'package:dummy_tdd_clean/features/authentication/domain/use_cases/create_user.dart';
import 'package:dummy_tdd_clean/features/authentication/domain/use_cases/get_users.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit({
    required CreateUser createUser,
    required GetUsers getUsers,
  })  : _createUser = createUser,
        _getUsers = getUsers,
        super(const AuthenticationInitial()) {}

  final CreateUser _createUser;
  final GetUsers _getUsers;

  Future<void> createUser({
    required String id,
    required String name,
    required String avatar,
    required DateTime createdAt,
  }) async {
    emit(const CreatingUser());

    final result = await _createUser(CreateUserParams(
      id: id,
      name: name,
      avatar: avatar,
      createdAt: createdAt,
    ));

    result.fold(
      (failure) => emit(AuthenticationError(message: failure.errorMessage)),
      (_) => emit(const UserCreated()),
    );
  }

  Future<void> getUsers() async {
    emit(const GettingUsers());
    final result = await _getUsers();

    result.fold(
      (failure) => emit(AuthenticationError(message: failure.errorMessage)),
      (users) => emit(UsersLoaded(users: users)),
    );
  }
}
