import 'dart:convert';

import 'package:dummy_tdd_clean/core/errors/exceptions.dart';
import 'package:dummy_tdd_clean/core/utilities/constants.dart';
import 'package:dummy_tdd_clean/core/utilities/typedef.dart';
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
  }) async {
    try {
      final http.Response response = await _client.post(
        Uri.https(baseurl,kPostUsers),
        body: jsonEncode(
          {
            'id': 'id',
            'name': 'name',
            'avatar': 'avatar',
            'createdAt': 'createdAt',
          },
        ),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
            message: response.body, statusCode: response.statusCode);
      }
    } on APIException {
      rethrow;
    } catch (e) {
      // this error is probably coming from developer
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<List<UserModel>> getUsers() async {
    try {
      final http.Response response =
          await _client.get(Uri.https(baseurl, kGetUsers));

      if (response.statusCode != 200) {
        throw APIException(
            message: response.body, statusCode: response.statusCode);
      }

      return List<DataMap>.from(jsonDecode(response.body) as List)
          .map((e) => UserModel.fromMap(e))
          .toList();
    } on APIException {
      rethrow;
    } catch (e) {
      // this error is probably coming from developer
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }
}
