import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../../core/api/api.dart';
import '../../../../../core/constant/openai.dart';
import '../../../../../core/error/exceptions.dart';
import '../../../domain/entities/chat.dart';

abstract class ChatRemoteDataSource {
  Future<Chat> postChat(String message);
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  const ChatRemoteDataSourceImpl({required this.client});

  final http.Client client;

  @override
  Future<Chat> postChat(String message) async {
    final url = Uri.parse('https://api.openai.com/v1/chat/completions');
    final token = OpenAi.token;
    final requestData = {
      'model': 'gpt-3.5-turbo',
      'messages': [
        {
          'role': 'user',
          'content': message,
        },
      ],
    };

    final response = await client
        .post(
      url,
      headers: Api.headersToken(token),
      body: json.encode(requestData),
    )
        .timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        throw const TimeOutException();
      },
    );

    if (response.statusCode == 200) {
      return chatFromJson(response.body);
    } else {
      throw const ServerException();
    }
  }
}
