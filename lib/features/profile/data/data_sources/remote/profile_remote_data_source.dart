import 'package:http/http.dart' as http;

import '../../../../../core/api/api.dart';
import '../../../../../core/error/exceptions.dart';
import '../../../domain/entities/profile.dart';

abstract class ProfileRemoteDataSource {
  Future<Profile> getProfile(String token);
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  ProfileRemoteDataSourceImpl({required this.client});

  final http.Client client;

  @override
  Future<Profile> getProfile(String token) async {
    final url = Uri.parse('${Api.url}/profile');

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
      return profileFromJson(response.body);
    } else {
      throw const ServerException();
    }
  }
}
