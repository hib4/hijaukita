import 'package:http/http.dart' as http;

import '../../../../../core/api/api.dart';
import '../../../../../core/error/exceptions.dart';
import '../../../domain/entities/detail_category.dart';

abstract class DetailCategoryRemoteDataSource {
  Future<DetailCategory> getDetailCategory(String token, int id);
}

class DetailCategoryRemoteDataSourceImpl
    implements DetailCategoryRemoteDataSource {
  const DetailCategoryRemoteDataSourceImpl({required this.client});

  final http.Client client;

  @override
  Future<DetailCategory> getDetailCategory(String token, int id) async {
    final url = Uri.parse('${Api.url}/browse/detail-sub-category/$id');

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
      return detailCategoryFromJson(response.body);
    } else {
      throw const ServerException();
    }
  }
}
