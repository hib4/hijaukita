import 'package:http/http.dart' as http;

import '../../../../../core/api/api.dart';
import '../../../../../core/error/exceptions.dart';

abstract class UploadPhotoRemoteDataSource {
  Future<void> uploadPhoto({
    required String token,
    required int activityId,
    required String desc,
    required String photo,
  });
}

class UploadPhotoRemoteDataSourceImpl implements UploadPhotoRemoteDataSource {
  @override
  Future<void> uploadPhoto({
    required String token,
    required int activityId,
    required String desc,
    required String photo,
  }) async {
    final url = Uri.parse('${Api.url}/trx/activity');

    print('desc = $desc');

    final request = http.MultipartRequest('POST', url)
      ..headers.addAll(
        Api.headersToken(token),
      )
      ..fields.addAll({
        'activity_id': activityId.toString(),
        'description': desc.isNotEmpty ? desc : '-',
      })
      ..files.add(await http.MultipartFile.fromPath('image', photo));

    final response = await request.send().timeout(
      const Duration(seconds: 15),
      onTimeout: () {
        throw const TimeOutException();
      },
    );

    final res = await http.Response.fromStream(response);

    if (res.statusCode == 200) {
      return;
    } else {
      throw const ServerException();
    }
  }
}
