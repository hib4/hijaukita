
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/error/failures.dart';
import '../../../data/repositories/quiz_detail_activity_respository.dart';
import '../../../domain/entities/quiz_detail_activity.dart';
import 'main_quiz_event.dart';
import 'main_quiz_state.dart';

class QuizMainBloc extends Bloc<QuizMainEvent, QuizMainState>{
  QuizMainBloc({required QuizDetailActivityRepository repository}) : _repository = repository, super(QuizMainInitial()){
    on<GetQuizMainEvent>(_getQuizEventHandler);
  }

  final QuizDetailActivityRepository _repository;

  Future<void> _getQuizEventHandler(GetQuizMainEvent event, Emitter<QuizMainState> emit) async {
    emit(QuizMainLoading());

    final either = await _repository.getQuizDetailActivity(event.id);

    _emitQuizResult(either, emit);
  }

  Future<void> _emitQuizResult(Either<Failure, QuizDetailActivity> either, Emitter<QuizMainState> emit) async {
    await either.fold(
      (failure) async {
        emit(
          QuizMainFailure(
            message: mapFailureToMessage(failure),
          ),
        );
      },
      (quiz) async {
        emit(QuizMainSuccess(quiz: quiz));
      },
    );
  }
}