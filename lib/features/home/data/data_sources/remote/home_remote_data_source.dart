import 'package:http/http.dart' as http;

import '../../../../../core/api/api.dart';
import '../../../../../core/error/exceptions.dart';
import '../../../domain/entities/home.dart';

abstract class HomeRemoteDataSource {
  Future<Home> getHome(String token);
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  const HomeRemoteDataSourceImpl({required this.client});

  final http.Client client;

  @override
  Future<Home> getHome(String token) async {
    final url = Uri.parse('${Api.url}/home');

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
      return homeFromJson(response.body);
    } else {
      throw const ServerException();
    }
  }
}
