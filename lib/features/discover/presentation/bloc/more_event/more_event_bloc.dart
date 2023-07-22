import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../../core/error/failures.dart';
import '../../../data/repositories/more_event_repository.dart';
import '../../../domain/entities/more_event.dart';

part 'more_event_event.dart';

part 'more_event_state.dart';

class MoreEventBloc extends Bloc<MoreEventEvent, MoreEventState> {
  MoreEventBloc({required MoreEventRepository repository})
      : _repository = repository,
        super(MoreEventInitial()) {
    on<GetMoreEvent>(_getMoreEventHandler);
  }

  final MoreEventRepository _repository;

  Future _getMoreEventHandler(
    GetMoreEvent event,
    Emitter<MoreEventState> emit,
  ) async {
    emit(MoreEventLoading());

    final either = await _repository.getMoreEvent();

    _emitResult(either, emit);
  }

  Future<void> _emitResult(
    Either<Failure, MoreEvent> either,
    Emitter<MoreEventState> emit,
  ) async {
    await either.fold(
      (failure) async {
        emit(
          MoreEventFailure(
            message: mapFailureToMessage(failure),
          ),
        );
      },
      (data) {
        emit(
          MoreEventSuccess(moreEvent: data),
        );
      },
    );
  }
}
