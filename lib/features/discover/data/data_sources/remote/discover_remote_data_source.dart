import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../../core/api/api.dart';
import '../../../../../core/error/exceptions.dart';
import '../../../domain/entities/discover.dart';

abstract class DiscoverRemoteDataSource {
  Future<Discover> search(String token, String text, Set<int> category);
}

class DiscoverRemoteDataSourceImpl implements DiscoverRemoteDataSource {
  const DiscoverRemoteDataSourceImpl({required this.client});

  final http.Client client;

  @override
  Future<Discover> search(String token, String text, Set<int> category) async {
    final url = Uri.parse('${Api.url}/browse');
    final body = {
      'search': text,
      'category_id': category.toList(),
    };

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

    if (response.statusCode == 200) {
      return discoverFromJson(response.body);
    } else {
      throw const ServerException();
    }
  }
}
