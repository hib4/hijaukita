part of 'chat_bloc.dart';

@immutable
abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatSuccess extends ChatState {
  ChatSuccess({required this.conversation});

  final Conversation conversation;
}

class ChatFailure extends ChatState {
  ChatFailure({required this.message});

  final String message;
}
