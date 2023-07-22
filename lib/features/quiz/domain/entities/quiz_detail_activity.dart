// To parse this JSON data, do
//
//     final quizDetailActivity = quizDetailActivityFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

QuizDetailActivity quizDetailActivityFromJson(String str) => QuizDetailActivity.fromJson(json.decode(str));

String quizDetailActivityToJson(QuizDetailActivity data) => json.encode(data.toJson());

class QuizDetailActivity {
  final String message;
  final Data data;

  QuizDetailActivity({
    required this.message,
    required this.data,
  });

  factory QuizDetailActivity.fromJson(Map<String, dynamic> json) => QuizDetailActivity(
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  final int id;
  final String activityId;
  final String name;
  final String description;
  final String video;
  final List<QuizQuestion> quizQuestion;

  Data({
    required this.id,
    required this.activityId,
    required this.name,
    required this.description,
    required this.video,
    required this.quizQuestion,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    activityId: json["activity_id"],
    name: json["name"],
    description: json["description"],
    video: json["video"],
    quizQuestion: List<QuizQuestion>.from(json["quiz_question"].map((x) => QuizQuestion.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "activity_id": activityId,
    "name": name,
    "description": description,
    "video": video,
    "quiz_question": List<dynamic>.from(quizQuestion.map((x) => x.toJson())),
  };
}

class QuizQuestion {
  final int id;
  final String quizId;
  final String question;
  final String correctAnswer;
  final String explaination;
  final List<QuizAnswer> quizAnswer;

  QuizQuestion({
    required this.id,
    required this.quizId,
    required this.question,
    required this.correctAnswer,
    required this.explaination,
    required this.quizAnswer,
  });

  factory QuizQuestion.fromJson(Map<String, dynamic> json) => QuizQuestion(
    id: json["id"],
    quizId: json["quiz_id"],
    question: json["question"],
    correctAnswer: json["correct_answer"],
    explaination: json["explaination"],
    quizAnswer: List<QuizAnswer>.from(json["quiz_answer"].map((x) => QuizAnswer.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "quiz_id": quizId,
    "question": question,
    "correct_answer": correctAnswer,
    "explaination": explaination,
    "quiz_answer": List<dynamic>.from(quizAnswer.map((x) => x.toJson())),
  };
}

class QuizAnswer {
  final int id;
  final String quizQuestionId;
  final String answer;
  final String isCorrect;

  QuizAnswer({
    required this.id,
    required this.quizQuestionId,
    required this.answer,
    required this.isCorrect,
  });

  factory QuizAnswer.fromJson(Map<String, dynamic> json) => QuizAnswer(
    id: json["id"],
    quizQuestionId: json["quiz_question_id"],
    answer: json["answer"],
    isCorrect: json["is_correct"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "quiz_question_id": quizQuestionId,
    "answer": answer,
    "is_correct": isCorrect,
  };
}
