import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../../core/error/failures.dart';
import '../../../data/repositories/activity_repository.dart';
import '../../../domain/entities/activity.dart';

part 'activity_event.dart';

part 'activity_state.dart';

class ActivityBloc extends Bloc<ActivityEvent, ActivityState> {
  ActivityBloc({required ActivityRepository repository})
      : _repository = repository,
        super(ActivityInitial()) {
    on<GetActivityEvent>(_getActivityEventHandler);
  }

  final ActivityRepository _repository;

  Future<void> _getActivityEventHandler(
    GetActivityEvent event,
    Emitter<ActivityState> emit,
  ) async {
    emit(ActivityLoading());

    final either = await _repository.getActivity(event.id);

    _emitActivityResult(either, emit);
  }

  Future<void> _emitActivityResult(
    Either<Failure, Activity> either,
    Emitter<ActivityState> emit,
  ) async {
    await either.fold(
      (failure) async {
        emit(
          ActivityFailure(
            message: mapFailureToMessage(failure),
          ),
        );
      },
      (activity) async {
        emit(ActivitySuccess(activity: activity));
      },
    );
  }
}
