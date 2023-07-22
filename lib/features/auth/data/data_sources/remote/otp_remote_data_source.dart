import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../../core/api/api.dart';
import '../../../../../core/error/exceptions.dart';

abstract class OtpRemoteDataSource {
  Future<void> sendOtp(String token, String otp);
}

class OtpRemoteDataSourceImpl implements OtpRemoteDataSource {
  const OtpRemoteDataSourceImpl({required this.client});

  final http.Client client;

  @override
  Future<void> sendOtp(String token, String otp) async {
    final url = Uri.parse('${Api.url}/email/verification');
    final body = {'otp': otp};

    final response = await client
        .post(
          url,
          headers: Api.headersToken(token),
          body: jsonEncode(body),
        )
        .timeout(
          const Duration(seconds: 15),
          onTimeout: () => throw const TimeOutException(),
        );

    if (response.statusCode != 200) {
      throw const ServerException();
    }
  }
}
