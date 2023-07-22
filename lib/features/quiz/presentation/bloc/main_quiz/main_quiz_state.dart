import 'package:flutter/cupertino.dart';
import '../../../domain/entities/quiz_detail_activity.dart';

@immutable
abstract class QuizMainState {}

class QuizMainInitial extends QuizMainState {}

class QuizMainLoading extends QuizMainState {}

class QuizMainSuccess extends QuizMainState {
  QuizMainSuccess({required this.quiz});

  final QuizDetailActivity quiz;
}

class QuizMainFailure extends QuizMainState {
  QuizMainFailure({required this.message});

  final String message;
}