import 'package:flutter/cupertino.dart';

@immutable
abstract class QuizMainEvent{}

class GetQuizMainEvent extends QuizMainEvent{
  GetQuizMainEvent({required this.id});

  final int id;
}