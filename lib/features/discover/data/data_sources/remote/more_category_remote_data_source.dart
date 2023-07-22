import 'package:http/http.dart' as http;

import '../../../../../core/api/api.dart';
import '../../../../../core/error/exceptions.dart';
import '../../../domain/entities/more_category.dart';

abstract class MoreCategoryRemoteDataSource {
  Future<MoreCategory> getMoreCategory(String token);
}

class MoreCategoryRemoteDataSourceImpl implements MoreCategoryRemoteDataSource {
  const MoreCategoryRemoteDataSourceImpl({required this.client});

  final http.Client client;

  @override
  Future<MoreCategory> getMoreCategory(String token) async {
    final url = Uri.parse('${Api.url}/browse/list-sub-categories');

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
      return moreCategoryFromJson(response.body);
    } else {
      throw const ServerException();
    }
  }
}
