import '../../../../../core/api/api.dart';
import '../../../../../core/error/exceptions.dart';
import '../../../domain/entities/quiz_detail_activity.dart';
import 'package:http/http.dart' as http;

abstract class QuizMainRemoteDataSource {
  Future<QuizDetailActivity> getQuizMain(String token, int id);
}

class QuizMainRemoteDataSourceImpl implements QuizMainRemoteDataSource {
  const QuizMainRemoteDataSourceImpl({required this.client});

  final http.Client client;

  @override
  Future<QuizDetailActivity> getQuizMain(String token, int id) async {
    final url = Uri.parse('${Api.url}/browse/detail-quiz/$id');

    final response = await client
        .get(
          url,
          headers: Api.headersToken(token),
        )
        .timeout(
          const Duration(seconds: 20),
          onTimeout: () => throw const TimeOutException(),
        );

    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      return quizDetailActivityFromJson(response.body);
    } else {
      throw const ServerException();
    }
  }
}