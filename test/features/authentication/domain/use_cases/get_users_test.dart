// Unit Test to-do:
// 1. What does this unit (CreateUser class) depend (take in it's constructors) on?
// Answer: AuthRepo
// 2. How can we create a fake version of the dependency?
// Answer: Use Mocktail
// 3. How do we control what our dependencies?
// Answer: Use Mocktail's API

import 'package:dartz/dartz.dart';
import 'package:dummy_tdd_clean/features/authentication/domain/entities/user.dart';
import 'package:dummy_tdd_clean/features/authentication/domain/repositories/auth_repo.dart';
import 'package:dummy_tdd_clean/features/authentication/domain/use_cases/get_users.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepo extends Mock implements AuthRepo {}

void main() {
  late GetUsers usecase;
  late AuthRepo repo;

  setUp(() {
    repo = MockAuthRepo();
    usecase = GetUsers(repo);
  });

  final testResponse = [User.empty()];

  test("should call AuthRepo.getUsers and return List<Users>", () async {
    // 1. Arrange
    when(
          () => repo.getUsers(),
    ).thenAnswer((_) async => Right(testResponse));
    // 2. Act
    final result = await usecase();
    // 3. Assert
    // *best practices: state the data types for readable code
    expect(result, equals(Right<dynamic, List<User>>(testResponse)));
    verify(
          () => repo.getUsers(),
    ).called(1);
    verifyNoMoreInteractions(repo);
  });
}
