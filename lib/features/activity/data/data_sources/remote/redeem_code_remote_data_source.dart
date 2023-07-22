import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../../core/api/api.dart';
import '../../../../../core/error/exceptions.dart';

abstract class RedeemCodeRemoteDataSource {
  Future<void> redeemCode(String token, int id, String code);
}

class RedeemCodeRemoteDataSourceImpl implements RedeemCodeRemoteDataSource {
  @override
  const RedeemCodeRemoteDataSourceImpl({required this.client});

  final http.Client client;

  @override
  Future<void> redeemCode(String token, int id, String code) async {
    final url = Uri.parse('${Api.url}/trx/event');
    final body = {
      'event_id': id,
      'code': code,
    };

    final response = await client
        .post(
          url,
          headers: Api.headersToken(token),
          body: jsonEncode(body),
        )
        .timeout(
          const Duration(seconds: 20),
          onTimeout: () => throw const TimeOutException(),
        );

    if (response.statusCode == 200) {
      return;
    } else {
      throw const ServerException();
    }
  }
}
