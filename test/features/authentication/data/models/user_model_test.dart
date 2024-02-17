// Unit Test to-do:
// 1. What does this unit (UserModel class) depend (take in it's constructors) on?
// Answer: User Class
// 2. How can we create a fake version of the dependency?
// Answer: Use empty instance
// 3. How do we control what our dependencies?
// Answer: Use json (?)

import 'dart:convert';

import 'package:dummy_tdd_clean/core/utilities/typedef.dart';
import 'package:dummy_tdd_clean/features/authentication/data/models/user_model.dart';
import 'package:dummy_tdd_clean/features/authentication/domain/entities/user.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main(){
  final testModel = UserModel.empty();

  test('should be a subclass of [User] entity', (){
    // 1. Arrange

    // 2. Act

    // 3. Assert
    expect(testModel, isA<User>());
  });

  final String testJson = fixture('user.json');
  final DataMap testMap = jsonDecode(testJson);

  group('fromMap', () {
    test('should return a [UserModel] with the right data', () {
      // 1. Arrange
      // 2. Act
      final result = UserModel.fromMap(testMap);
      // 3. Assert
      expect(result, equals(testModel));
    });
  });

  group('fromJson', () {
    test('should return a [UserModel] with the right data', () {
      // 1. Arrange
      // 2. Act
      final result = UserModel.fromJson(testJson);
      // 3. Assert
      expect(result, equals(testModel));
    });
  });

  group('toMap', () {
    test('should return a [Map] with the right data', () {
      // 1. Arrange
      // 2. Act
      final result = testModel.toMap();
      // 3. Assert
      expect(result, equals(testMap));
    });
  });

  group('toJson', () {
    test('should return a [Json] with the right data', () {
      // 1. Arrange
      // 2. Act
      final result = testModel.toJson();
      final testJsonRaw = jsonEncode({
        "id": "_empty.id",
        "name": "_empty.name",
        "avatar": "_empty.avatar",
        "createdAt": "2024-02-14T05:45:40.252Z"
      });
      // 3. Assert
      expect(result, equals(testJsonRaw));
    });
  });

}