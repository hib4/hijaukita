part of 'chat_bloc.dart';

@immutable
abstract class ChatEvent {}

class PostChatEvent extends ChatEvent {
  PostChatEvent({required this.message});

  final String message;
}
