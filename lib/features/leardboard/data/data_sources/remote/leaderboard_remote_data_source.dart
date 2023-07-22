import 'package:http/http.dart' as http;

import '../../../../../core/api/api.dart';
import '../../../../../core/error/exceptions.dart';
import '../../../domain/entities/leaderboard.dart';

abstract class LeaderboardRemoteDataSource {
  Future<Leaderboard> getLeaderboard(String token, String type);
}

class LeaderboardRemoteDataSourceImpl implements LeaderboardRemoteDataSource {
  const LeaderboardRemoteDataSourceImpl({required this.client});

  final http.Client client;

  @override
  Future<Leaderboard> getLeaderboard(String token, String type) async {
    final url = Uri.parse('${Api.url}/leaderboard?time=$type');

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
      return leaderboardFromJson(response.body);
    } else {
      throw const ServerException();
    }
  }
}