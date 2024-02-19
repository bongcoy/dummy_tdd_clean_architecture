import 'package:dartz/dartz.dart';
import 'package:dummy_tdd_clean/core/errors/exceptions.dart';
import 'package:dummy_tdd_clean/core/errors/failure.dart';
import 'package:dummy_tdd_clean/features/authentication/data/data_sources/auth_remote.dart';
import 'package:dummy_tdd_clean/features/authentication/data/repositories/auth_repo_impl.dart';
import 'package:dummy_tdd_clean/features/authentication/domain/entities/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRemote extends Mock implements AuthRemote {}

void main() {
  late AuthRemote authRemoteDS;
  late AuthRepoImpl authRepoImpl;

  setUp(() {
    authRemoteDS = MockAuthRemote();
    authRepoImpl = AuthRepoImpl(authRemoteDS);
  });

  const testException = APIException(
    message: 'Unknown error',
    statusCode: 500,
  );

  group('createUser', () {
    test('should call the [AuthRemote.createUser] and complete succesfully',
        () async {
      // 1. Arrange
      when(
        () => authRemoteDS.createUser(
          id: any(named: 'id'),
          name: any(named: 'name'),
          avatar: any(named: 'avatar'),
          createdAt: any(named: 'createdAt'),
        ),
      ).thenAnswer((_) => Future.value());
      const id = 'id';
      const name = 'id';
      const avatar = 'id';
      const createdAt = 'id';
      // 2. Act
      final result = await authRepoImpl.createUser(
        id: id,
        name: name,
        avatar: avatar,
        createdAt: createdAt,
      );
      // 3. Assert
      // *best practices: state the data types for readable code
      expect(result, equals(const Right<dynamic, void>(null)));
      verify(
        () => authRemoteDS.createUser(
          id: id,
          name: name,
          avatar: avatar,
          createdAt: createdAt,
        ),
      ).called(1);
      verifyNoMoreInteractions(authRemoteDS);
    });

    test('should return a [ServerFailure] when there is exception', () async {
      // 1. Arrange
      when(
        () => authRemoteDS.createUser(
          id: any(named: 'id'),
          name: any(named: 'name'),
          avatar: any(named: 'avatar'),
          createdAt: any(named: 'createdAt'),
        ),
      ).thenThrow(testException);
      const id = 'id';
      const name = 'id';
      const avatar = 'id';
      const createdAt = 'id';
      // 2. Act
      final result = await authRepoImpl.createUser(
        id: id,
        name: name,
        avatar: avatar,
        createdAt: createdAt,
      );
      // 3. Assert
      // *best practices: state the data types for readable code
      expect(
        result,
        equals(
          Left(ApiFailure(
              message: testException.message,
              statusCode: testException.statusCode)),
        ),
      );
      verify(
        () => authRemoteDS.createUser(
          id: id,
          name: name,
          avatar: avatar,
          createdAt: createdAt,
        ),
      ).called(1);
      verifyNoMoreInteractions(authRemoteDS);
    });
  });

  group('getUsers', () {
    test(
        'should call the [AuthRemote.getUsers] and return [List<User>]'
        ' when call to remote source is successful', () async {
      // 1. Arrange
      when(() => authRemoteDS.getUsers()).thenAnswer((_) async => []);
      // 2. Act
      final result = await authRepoImpl.getUsers();
      // 3. Assert
      // *best practices: state the data types for readable code
      expect(result, isA<Right<dynamic, List<User>>>());
      verify(() => authRemoteDS.getUsers()).called(1);
      verifyNoMoreInteractions(authRemoteDS);
    });

    test('should return a [APIFailure] when there is exception', () async {
      // 1. Arrange
      when(
        () => authRemoteDS.getUsers(),
      ).thenThrow(testException);
      // 2. Act
      final result = await authRepoImpl.getUsers();
      // 3. Assert
      // *best practices: state the data types for readable code
      expect(
        result,
        equals(
          Left(ApiFailure.fromException(testException)),
        ),
      );
      verify(() => authRemoteDS.getUsers()).called(1);
      verifyNoMoreInteractions(authRemoteDS);
    });
  });
}
