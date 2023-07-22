import 'dart:convert';

import 'package:equatable/equatable.dart';

Chat chatFromJson(String str) => Chat.fromJson(json.decode(str));

String chatToJson(Chat data) => json.encode(data.toJson());

class Chat extends Equatable {
  final List<Choice> choices;

  const Chat({
    required this.choices,
  });

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
    choices: List<Choice>.from(json["choices"].map((x) => Choice.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "choices": List<dynamic>.from(choices.map((x) => x.toJson())),
  };

  @override
  List<Object?> get props => [choices];
}

class Choice extends Equatable {
  final Message message;

  const Choice({
    required this.message,
  });

  factory Choice.fromJson(Map<String, dynamic> json) => Choice(
    message: Message.fromJson(json["message"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message.toJson(),
  };

  @override
  List<Object?> get props => [message];
}

class Message extends Equatable {
  final String content;
  final String role;

  const Message({
    required this.content,
    required this.role,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    content: json["content"],
    role: json["role"],
  );

  Map<String, dynamic> toJson() => {
    "content": content,
    "role": role,
  };

  @override
  List<Object?> get props => [content, role];
}
