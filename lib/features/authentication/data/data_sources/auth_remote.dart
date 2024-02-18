import 'package:dummy_tdd_clean/features/authentication/data/models/user_model.dart';

abstract class AuthRemote {
  Future<void> createUser({
    required String id,
    required String name,
    required String avatar,
    required String createdAt,
  });

  Future<List<UserModel>> getUsers();
}