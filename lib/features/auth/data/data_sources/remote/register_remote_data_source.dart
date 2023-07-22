import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../../core/api/api.dart';
import '../../../../../core/error/exceptions.dart';

abstract class RegisterRemoteDataSource {
  Future<String> register(String fullName, String email, String password);
}

class RegisterRemoteDataSourceImpl implements RegisterRemoteDataSource {
  RegisterRemoteDataSourceImpl({required this.client});

  final http.Client client;

  @override
  Future<String> register(
      String fullName, String email, String password) async {
    final url = Uri.parse('${Api.url}/register');
    final body = {
      'name': fullName,
      'email': email,
      'password': password,
    };

    print('hellooooooooooooooooooooooooooooooooooo');

    final response = await client
        .post(
          url,
          body: body,
        )
        .timeout(
          const Duration(seconds: 15),
          onTimeout: () => throw const TimeOutException(),
        );

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['data']['token'];
    } else {
      throw const ServerException();
    }
  }
}
