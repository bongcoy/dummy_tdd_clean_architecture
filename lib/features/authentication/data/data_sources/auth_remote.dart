import 'package:dummy_tdd_clean/features/authentication/data/models/user_model.dart';
import 'package:http/http.dart' as http;

abstract class AuthRemoteDataSource {
  Future<void> createUser({
    required String id,
    required String name,
    required String avatar,
    required String createdAt,
  });

  Future<List<UserModel>> getUsers();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {

  AuthRemoteDataSourceImpl({required http.Client client}) : _client = client;

  final http.Client _client;

  @override
  Future<void> createUser({
    required String id,
    required String name,
    required String avatar,
    required String createdAt,
  }) {
    // TODO: implement createUser
    throw UnimplementedError();
  }

  @override
  Future<List<UserModel>> getUsers() {
    // TODO: implement getUsers
    throw UnimplementedError();
  }
}
