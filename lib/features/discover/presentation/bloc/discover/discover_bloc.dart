import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../../../../core/error/failures.dart';
import '../../../data/repositories/discover_repository.dart';
import '../../../domain/entities/discover.dart';

part 'discover_event.dart';

part 'discover_state.dart';

const _duration = Duration(milliseconds: 300);

EventTransformer<Event> debounce<Event>(Duration duration) {
  return (events, mapper) => events.debounce(duration).switchMap(mapper);
}

class DiscoverBloc extends Bloc<DiscoverEvent, DiscoverState> {
  DiscoverBloc({required DiscoverRepository repository})
      : _repository = repository,
        super(DiscoverInitial()) {
    on<ValueDiscoverChangedEvent>(
      _valueDiscoverChangedEventHandler,
      transformer: debounce(_duration),
    );
    on<ValueDiscoverRefreshEvent>(_valueDiscoverRefreshEventHandler);
  }

  final DiscoverRepository _repository;

  Future _valueDiscoverChangedEventHandler(
    ValueDiscoverChangedEvent event,
    Emitter<DiscoverState> emit,
  ) async {
    emit(DiscoverLoading());

    final either = await _repository.search(event.text, event.category);

    _emitResult(either, emit);
  }

  Future _valueDiscoverRefreshEventHandler(
    ValueDiscoverRefreshEvent event,
    Emitter<DiscoverState> emit,
  ) async {
    emit(DiscoverInitial());
    emit(DiscoverLoading());

    final either = await _repository.search('', {});

    _emitResult(either, emit);
  }

  Future<void> _emitResult(
    Either<Failure, Discover> either,
    Emitter<DiscoverState> emit,
  ) async {
    await either.fold(
      (failure) async {
        emit(
          DiscoverFailure(
            message: mapFailureToMessage(failure),
          ),
        );
      },
      (data) {
        emit(
          DiscoverSuccess(discover: data),
        );
      },
    );
  }
}
