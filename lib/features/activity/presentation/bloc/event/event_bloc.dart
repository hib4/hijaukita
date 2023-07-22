import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../../core/error/failures.dart';
import '../../../data/repositories/event_repository.dart';
import '../../../domain/entities/event.dart';

part 'event_event.dart';

part 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  EventBloc({required EventRepository repository})
      : _repository = repository,
        super(EventInitial()) {
    on<GetEventEvent>(_getEventHandler);
  }

  final EventRepository _repository;

  Future<void> _getEventHandler(
    GetEventEvent event,
    Emitter<EventState> emit,
  ) async {
    emit(EventLoading());

    final either = await _repository.getEvent(event.id);

    _emitEventResult(either, emit);
  }

  Future<void> _emitEventResult(
    Either<Failure, Event> either,
    Emitter<EventState> emit,
  ) async {
    await either.fold(
      (failure) async {
        emit(
          EventFailure(
            message: mapFailureToMessage(failure),
          ),
        );
      },
      (event) async {
        emit(EventSuccess(event: event));
      },
    );
  }
}
