// Unit Test to-do:
// 1. What does this unit (AuthRemoteDataSourceImpl class) depend (take in it's constructors) on?
// Answer: http.Client
// 2. How can we create a fake version of the dependency?
// Answer: Use Mocktail
// 3. How do we control what our dependencies?
// Answer: Use Mocktail's API

import 'dart:convert';

import 'package:dummy_tdd_clean/core/errors/exceptions.dart';
import 'package:dummy_tdd_clean/core/utilities/constants.dart';
import 'package:dummy_tdd_clean/features/authentication/data/data_sources/auth_remote_data_source.dart';
import 'package:dummy_tdd_clean/features/authentication/data/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;

class MockClient extends Mock implements http.Client {}

void main() {
  late http.Client client;
  late AuthRemoteDataSource authRemoteDataSource;

  setUp(() {
    client = MockClient();
    authRemoteDataSource = AuthRemoteDataSourceImpl(client: client);
    registerFallbackValue(Uri());
  });

  group('createUser', () {
    test('should return status code 200 or 201', () async {
      // 1. Arrange
      when(() => client.post(
                any(),
                body: any(named: 'body'),
              ))
          .thenAnswer(
              (_) async => http.Response('user created successfully', 201));
      // 2. Act
      final methodCall = authRemoteDataSource.createUser;
      // 3. Assert
      expect(
        methodCall(
          id: 'id',
          name: 'name',
          avatar: 'avatar',
          createdAt: 'createdAt',
        ),
        completes,
      );
      verify(() => client.post(
            Uri.https(baseurl, kPostUsers),
            body: jsonEncode(
              {
                'id': 'id',
                'name': 'name',
                'avatar': 'avatar',
                'createdAt': 'createdAt',
              },
            ),
          )).called(1);
      verifyNoMoreInteractions(client);
    });

    test('should throw [APIException] when status code not 200/201', () async {
      // 1. Arrange
      when(() => client.post(
                any(),
                body: any(named: 'body'),
              ))
          .thenAnswer((_) async => http.Response('invalid email address', 400));
      // 2. Act
      final methodCall = authRemoteDataSource.createUser;
      // 3. Assert
      expect(
        () async => methodCall(
          id: 'id',
          name: 'name',
          avatar: 'avatar',
          createdAt: 'createdAt',
        ),
        throwsA(
          const APIException(message: 'invalid email address', statusCode: 400),
        ),
      );
      verify(() => client.post(
            Uri.https(baseurl, kPostUsers),
            body: jsonEncode(
              {
                'id': 'id',
                'name': 'name',
                'avatar': 'avatar',
                'createdAt': 'createdAt',
              },
            ),
          )).called(1);
      verifyNoMoreInteractions(client);
    });
  });

  group('getUser', () {
    final testUsers = [UserModel.empty()];

    // http.get request always 200 status code
    test('should return a [List<User>] when status code 200', () async {
      // 1. Arrange
      when(() => client.get(any())).thenAnswer(
        (_) async => http.Response(jsonEncode([testUsers.first.toMap()]), 200),
      );
      // 2. Act
      final result = await authRemoteDataSource.getUsers();
      // 3. Assert
      expect(
        result,
        equals(testUsers),
      );
      // you can use Uri.https instead of Uri.parse if you have to
      // send a params to the server
      verify(() => client.get(Uri.https(baseurl, kGetUsers))).called(1);
      verifyNoMoreInteractions(client);
    });

    test('should throw [APIException] when status code not 200', () async {
      // 1. Arrange
      const testMessage = 'invalid email address';
      when(() => client.get(any()))
          .thenAnswer((_) async => http.Response(testMessage, 500));
      // 2. Act
      final methodCall = authRemoteDataSource.getUsers;
      // 3. Assert
      expect(
        () async => methodCall(),
        throwsA(
          const APIException(message: testMessage, statusCode: 500),
        ),
      );
      verify(() => client.get(Uri.https(baseurl, kPostUsers))).called(1);
      verifyNoMoreInteractions(client);
    });
  });
}
