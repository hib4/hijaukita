import 'package:http/http.dart' as http;

import '../../../../../core/api/api.dart';
import '../../../../../core/error/exceptions.dart';
import '../../../domain/entities/event.dart';

abstract class EventRemoteDataSource {
  Future<Event> getEvent(String token, int id);
}

class EventRemoteDataSourceImpl implements EventRemoteDataSource {
  const EventRemoteDataSourceImpl({required this.client});

  final http.Client client;

  @override
  Future<Event> getEvent(String token, int id) async {
    final url = Uri.parse('${Api.url}/browse/detail-event/$id');

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
      return eventFromJson(response.body);
    } else {
      throw const ServerException();
    }
  }
}
