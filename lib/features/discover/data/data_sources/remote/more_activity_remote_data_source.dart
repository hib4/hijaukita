import 'package:http/http.dart' as http;

import '../../../../../core/api/api.dart';
import '../../../../../core/error/exceptions.dart';
import '../../../domain/entities/more_activity.dart';

abstract class MoreActivityRemoteDataSource {
  Future<MoreActivity> getMoreActivity(String token);
}

class MoreActivityRemoteDataSourceImpl implements MoreActivityRemoteDataSource {
  const MoreActivityRemoteDataSourceImpl({required this.client});

  final http.Client client;

  @override
  Future<MoreActivity> getMoreActivity(String token) async {
    final url = Uri.parse('${Api.url}/browse/latest-activities');

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
      return moreActivityFromJson(response.body);
    } else {
      throw const ServerException();
    }
  }
}
