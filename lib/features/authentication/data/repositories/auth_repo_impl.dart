import 'package:dartz/dartz.dart';
import 'package:dummy_tdd_clean/core/errors/exceptions.dart';
import 'package:dummy_tdd_clean/core/errors/failure.dart';
import 'package:dummy_tdd_clean/core/utilities/typedef.dart';
import 'package:dummy_tdd_clean/features/authentication/data/data_sources/auth_remote_data_source.dart';
import 'package:dummy_tdd_clean/features/authentication/domain/entities/user.dart';
import 'package:dummy_tdd_clean/features/authentication/domain/repositories/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  AuthRepoImpl(this._remoteDataSource);

  final AuthRemoteDataSource _remoteDataSource;

  @override
  ResultFuture<void> createUser({
    required String id,
    required String name,
    required String avatar,
    required DateTime createdAt,
  }) async {
    try {
      await _remoteDataSource.createUser(
        id: id,
        name: name,
        avatar: avatar,
        createdAt: createdAt,
      );
      return const Right(null);
    } on APIException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<User>> getUsers() async {
    try {
      final result = await _remoteDataSource.getUsers();
      return Right(result);
    } on APIException catch(e) {
      return Left(ApiFailure.fromException(e));
    }
  }
}
