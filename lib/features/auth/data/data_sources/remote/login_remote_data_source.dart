import 'dart:convert';

import 'package:hijaukita/core/api/api.dart';
import 'package:http/http.dart' as http;

import '../../../../../core/error/exceptions.dart';

abstract class LoginRemoteDataSource {
  Future<String> emailLogin(String email, String password);

  Future<String> googleLogin(String token);
}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final http.Client client;

  LoginRemoteDataSourceImpl({required this.client});

  @override
  Future<String> emailLogin(String email, String password) async {
    final url = Uri.parse('${Api.url}/login');
    final body = {
      'email': email,
      'password': password,
    };

    final response = await client
        .post(
          url,
          body: body,
        )
        .timeout(
          const Duration(seconds: 15),
          onTimeout: () => throw const TimeOutException(),
        );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['data']['token'];
    } else {
      throw const ServerException();
    }
  }

  @override
  Future<String> googleLogin(String token) async {
    final url = Uri.parse('${Api.url}/google/verify-token');
    final body = {'id_token': token};

    final response = await client
        .post(
          url,
          body: body,
        )
        .timeout(
          const Duration(seconds: 15),
          onTimeout: () => throw const TimeOutException(),
        );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['passport_token'];
    } else {
      throw const ServerException();
    }
  }
}
