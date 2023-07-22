import 'package:flutter/cupertino.dart';

@immutable
abstract class QuizEvent {}

class GetQuizEvent extends QuizEvent {
  GetQuizEvent({required this.id});

  final int id;
}