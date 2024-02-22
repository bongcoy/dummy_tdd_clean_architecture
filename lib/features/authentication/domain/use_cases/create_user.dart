import 'package:dummy_tdd_clean/core/usecase/usecase.dart';
import 'package:dummy_tdd_clean/core/utilities/typedef.dart';
import 'package:dummy_tdd_clean/features/authentication/domain/repositories/auth_repo.dart';
import 'package:equatable/equatable.dart';

class CreateUser extends UseCaseWithParams<void, CreateUserParams> {
  CreateUser(this._repo);

  final AuthRepo _repo;

  @override
  ResultFuture<void> call(CreateUserParams params) async => _repo.createUser(
        id: params.id,
        name: params.name,
        avatar: params.avatar,
        createdAt: params.createdAt,
      );
}

class CreateUserParams extends Equatable {
  final String id;
  final String name;
  final String avatar;
  final DateTime createdAt;

  const CreateUserParams({
    required this.id,
    required this.name,
    required this.avatar,
    required this.createdAt,
  });

  CreateUserParams.empty()
      : this(
          id: '_empty.id',
          name: '_empty.name',
          avatar: '_empty.avatar',
          createdAt: DateTime.parse('2024-02-14T05:45:40.252Z'),
        );

  @override
  List<Object?> get props => [id, name, avatar, createdAt];
}
