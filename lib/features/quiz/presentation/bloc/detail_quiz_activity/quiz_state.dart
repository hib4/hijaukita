import 'package:flutter/cupertino.dart';

import '../../../domain/entities/quiz_detail_activity.dart';

@immutable
abstract class QuizState {}

class QuizInitial extends QuizState {}

class QuizLoading extends QuizState {}

class QuizSuccess extends QuizState {
  QuizSuccess({required this.quiz});

  final QuizDetailActivity quiz;
}

class QuizFailure extends QuizState {
  QuizFailure({required this.message});

  final String message;
}