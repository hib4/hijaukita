import 'package:http/http.dart' as http;

import '../../../../../core/api/api.dart';
import '../../../../../core/error/exceptions.dart';

abstract class WishlistRemoteDataSource {
  Future<void> addOrRemoveWishlist(String token, int id);
}

class WishlistRemoteDataSourceImpl implements WishlistRemoteDataSource {
  const WishlistRemoteDataSourceImpl({required this.client});

  final http.Client client;

  @override
  Future<void> addOrRemoveWishlist(String token, int id) async {
    final url = Uri.parse('${Api.url}/trx/add-remove-wishlist/$id');

    final response = await client
        .post(
          url,
          headers: Api.headersToken(token),
        )
        .timeout(
          const Duration(seconds: 20),
          onTimeout: () => throw const TimeOutException(),
        );

    if (response.statusCode == 200) {
      return;
    } else {
      throw const ServerException();
    }
  }
}
