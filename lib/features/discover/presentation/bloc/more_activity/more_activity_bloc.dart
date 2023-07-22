import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../../core/error/failures.dart';
import '../../../data/repositories/more_activity_repository.dart';
import '../../../domain/entities/more_activity.dart';

part 'more_activity_event.dart';

part 'more_activity_state.dart';

class MoreActivityBloc extends Bloc<MoreActivityEvent, MoreActivityState> {
  MoreActivityBloc({required MoreActivityRepository repository})
      : _repository = repository,
        super(MoreActivityInitial()) {
    on<GetMoreActivity>(_moreActivityEventHandler);
  }

  final MoreActivityRepository _repository;

  Future<void> _moreActivityEventHandler(
    MoreActivityEvent event,
    Emitter<MoreActivityState> emit,
  ) async {
    emit(MoreActivityLoading());

    final either = await _repository.getMoreActivity();

    _emitResult(either, emit);
  }

  Future<void> _emitResult(
    Either<Failure, MoreActivity> either,
    Emitter<MoreActivityState> emit,
  ) async {
    await either.fold(
      (failure) async {
        emit(
          MoreActivityFailure(
            message: mapFailureToMessage(failure),
          ),
        );
      },
      (data) {
        emit(
          MoreActivitySuccess(moreActivity: data),
        );
      },
    );
  }
}
