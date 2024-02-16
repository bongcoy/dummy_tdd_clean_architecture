import 'package:dummy_tdd_clean/core/utilities/typedef.dart';
import 'package:dummy_tdd_clean/features/home/domain/entities/user.dart';

abstract class AuthRepo {
  const AuthRepo();

  ResultFuture<void> createUser({
    required String id,
    required String name,
    required String avatar,
    required String createdAt,
  });

  ResultFuture<List<User>> getUsers();
}
