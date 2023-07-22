import 'package:equatable/equatable.dart';

class Conversation extends Equatable {
  const Conversation(this.text, this.isAnswer);

  final String text;
  final bool isAnswer;

  @override
  List<Object?> get props => [text, isAnswer];
}