import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hijaukita/features/quiz/presentation/bloc/detail_quiz_activity/quiz_event.dart';
import 'package:hijaukita/features/quiz/presentation/bloc/detail_quiz_activity/quiz_state.dart';

import '../../../../../core/error/failures.dart';
import '../../../data/repositories/quiz_detail_activity_respository.dart';
import '../../../domain/entities/quiz_detail_activity.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState>{
  QuizBloc({required QuizDetailActivityRepository repository}) : _repository = repository, super(QuizInitial()){
    on<GetQuizEvent>(_getQuizEventHandler);
  }

  final QuizDetailActivityRepository _repository;

  Future<void> _getQuizEventHandler(GetQuizEvent event, Emitter<QuizState> emit) async {
    emit(QuizLoading());

    final either = await _repository.getQuizDetailActivity(event.id);

    _emitQuizResult(either, emit);
  }

  Future<void> _emitQuizResult(Either<Failure, QuizDetailActivity> either, Emitter<QuizState> emit) async {
    await either.fold(
      (failure) async {
        emit(
          QuizFailure(
            message: mapFailureToMessage(failure),
          ),
        );
      },
      (quiz) async {
        emit(QuizSuccess(quiz: quiz));
      },
    );
  }
}