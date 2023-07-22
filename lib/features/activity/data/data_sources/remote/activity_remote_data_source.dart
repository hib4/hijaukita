import 'package:http/http.dart' as http;

import '../../../../../core/api/api.dart';
import '../../../../../core/error/exceptions.dart';
import '../../../domain/entities/activity.dart';

abstract class ActivityRemoteDataSource {
  Future<Activity> getActivity(String token, int id);
}

class ActivityRemoteDataSourceImpl implements ActivityRemoteDataSource {
  const ActivityRemoteDataSourceImpl({required this.client});

  final http.Client client;

  @override
  Future<Activity> getActivity(String token, int id) async {
    final url = Uri.parse('${Api.url}/browse/detail-activity/$id');

    final response = await client
        .get(
          url,
          headers: Api.headersToken(token),
        )
        .timeout(
          const Duration(seconds: 20),
          onTimeout: () => throw const TimeOutException(),
        );

    if (response.statusCode == 200) {
      return activityFromJson(response.body);
    } else {
      throw const ServerException();
    }
  }
}
