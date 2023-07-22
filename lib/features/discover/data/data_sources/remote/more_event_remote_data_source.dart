import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../../../core/api/api.dart';
import '../../../../../core/error/exceptions.dart';
import '../../../domain/entities/more_event.dart';

abstract class MoreEventRemoteDataSource {
  Future<MoreEvent> getMoreEvent(String token);
}

class MoreEventRemoteDataSourceImpl implements MoreEventRemoteDataSource {
  const MoreEventRemoteDataSourceImpl({required this.client});

  final http.Client client;

  @override
  Future<MoreEvent> getMoreEvent(String token) async {
    final url = Uri.parse('${Api.url}/browse/latest-events');

    final response = await client
        .get(
          url,
          headers: Api.headersToken(token),
        )
        .timeout(
          const Duration(seconds: 15),
          onTimeout: () => throw const TimeOutException(),
        );

    if (response.statusCode == 200) {
      return moreEventFromJson(response.body);
    } else {
      throw const ServerException();
    }
  }
}
