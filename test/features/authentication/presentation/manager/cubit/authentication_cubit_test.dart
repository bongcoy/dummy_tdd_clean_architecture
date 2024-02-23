import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:dummy_tdd_clean/core/errors/failure.dart';
import 'package:dummy_tdd_clean/features/authentication/domain/entities/user.dart';
import 'package:dummy_tdd_clean/features/authentication/domain/use_cases/create_user.dart';
import 'package:dummy_tdd_clean/features/authentication/domain/use_cases/get_users.dart';
import 'package:dummy_tdd_clean/features/authentication/presentation/manager/cubit/authentication_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCreateUser extends Mock implements CreateUser {}

class MockGetUsers extends Mock implements GetUsers {}

void main() {
  late GetUsers getUsers;
  late CreateUser createUser;
  late AuthenticationCubit cubit;

  final testCreateUserParams = CreateUserParams.empty();
  const testAPIFailure = ApiFailure(message: 'message', statusCode: 400);
  final testUsersList = [User.empty()];

  // run before each test
  setUp(() {
    getUsers = MockGetUsers();
    createUser = MockCreateUser();
    cubit = AuthenticationCubit(createUser: createUser, getUsers: getUsers);
    registerFallbackValue(testCreateUserParams);
  });

  // cubit closed after each test
  tearDown(() => cubit.close());

  test('initial state should be [AuthenticationInitial]', () {
    // 1. Arrange
    // don't need to arrange, cause the cubit is already lives
    // 2. Act
    // don't need to act, cause the cubit is already lives
    // 3. Assert
    expect(cubit.state, equals(const AuthenticationInitial()));
  });

  group('createUser', () {
    blocTest<AuthenticationCubit, AuthenticationState>(
      'should emit [CreatingUser, UserCreated] when successful',
      // 1. Arrange
      build: () {
        when(() => createUser(any())).thenAnswer(
          (_) async => const Right(null),
        );
        return cubit;
      },
      // 2. Act
      act: (cubit) => cubit.createUser(
        id: testCreateUserParams.id,
        name: testCreateUserParams.name,
        avatar: testCreateUserParams.avatar,
        createdAt: testCreateUserParams.createdAt,
      ),
      // 3. Assert
      expect: () => const [
        CreatingUser(),
        UserCreated(),
      ],
      verify: (bloc) {
        verify(() => createUser(testCreateUserParams)).called(1);
        verifyNoMoreInteractions(createUser);
      },
    );

    blocTest<AuthenticationCubit, AuthenticationState>(
      'should emit [CreatingUser, AuthenticationError] when unsuccessful',
      // 1. Arrange
      build: () {
        when(() => createUser(any())).thenAnswer(
              (_) async => const Left(testAPIFailure),
        );
        return cubit;
      },
      // 2. Act
      act: (cubit) => cubit.createUser(
        id: testCreateUserParams.id,
        name: testCreateUserParams.name,
        avatar: testCreateUserParams.avatar,
        createdAt: testCreateUserParams.createdAt,
      ),
      // 3. Assert
      expect: () => [
        const CreatingUser(),
        AuthenticationError(message: testAPIFailure.errorMessage),
      ],
      verify: (bloc) {
        verify(() => createUser(testCreateUserParams)).called(1);
        verifyNoMoreInteractions(createUser);
      },
    );
  });

  group('getUser', () {
    blocTest<AuthenticationCubit, AuthenticationState>(
      'should emit [GettingUsers, UsersLoaded] when successful',
      // 1. Arrange
      build: () {
        when(() => getUsers()).thenAnswer(
              (_) async => Right(testUsersList),
        );
        return cubit;
      },
      // 2. Act
      act: (cubit) => cubit.getUsers(),
      // 3. Assert
      expect: () => [
        const GettingUsers(),
        UsersLoaded(users: testUsersList),
      ],
      verify: (bloc) {
        verify(() => getUsers()).called(1);
        verifyNoMoreInteractions(createUser);
      },
    );

    blocTest<AuthenticationCubit, AuthenticationState>(
      'should emit [GettingUsers, AuthenticationError] when unsuccessful',
      // 1. Arrange
      build: () {
        when(() => getUsers()).thenAnswer(
              (_) async => const Left(testAPIFailure),
        );
        return cubit;
      },
      // 2. Act
      act: (cubit) => cubit.getUsers(),
      // 3. Assert
      expect: () => [
        const GettingUsers(),
        AuthenticationError(message: testAPIFailure.errorMessage),
      ],
      verify: (bloc) {
        verify(() => getUsers()).called(1);
        verifyNoMoreInteractions(createUser);
      },
    );
  });

}
