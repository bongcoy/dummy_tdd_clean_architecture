// Unit Test to-do:
// 1. What does this unit (CreateUser class) depend (take in it's constructors) on?
// Answer: AuthRepo
// 2. How can we create a fake version of the dependency?
// Answer: Use Mocktail
// 3. How do we control what our dependencies?
// Answer: Use Mocktail's API

import 'package:dartz/dartz.dart';
import 'package:dummy_tdd_clean/features/authentication/domain/repositories/auth_repo.dart';
import 'package:dummy_tdd_clean/features/authentication/domain/use_cases/create_user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepo extends Mock implements AuthRepo {}

void main() {
  late CreateUser usecase;
  late AuthRepo repo;

  setUp(() {
    repo = MockAuthRepo();
    usecase = CreateUser(repo);
  });

  const params = CreateUserParams.empty();

  test("should call AuthRepo.createUser", () async {
    // 1. Arrange
    when(
      () => repo.createUser(
        id: any(named: 'id'),
        name: any(named: 'name'),
        avatar: any(named: 'avatar'),
        createdAt: any(named: 'createdAt'),
      ),
    ).thenAnswer((_) async => const Right(null));
    // 2. Act
    final result = await usecase(params);
    // 3. Assert
    // *best practices: state the data types for readable code
    expect(result, equals(const Right<dynamic, void>(null)));
    verify(
      () => repo.createUser(
        id: params.id,
        name: params.name,
        avatar: params.avatar,
        createdAt: params.createdAt,
      ),
    ).called(1);
    verifyNoMoreInteractions(repo);
  });
}
