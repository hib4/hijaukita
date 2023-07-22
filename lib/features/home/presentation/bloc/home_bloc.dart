import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../data/repositories/home_repository.dart';
import '../../domain/entities/home.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({required HomeRepository repository})
      : _repository = repository,
        super(HomeInitial()) {
    on<GetHomeEvent>(_getHomeEventHandler);
  }

  final HomeRepository _repository;

  Future _getHomeEventHandler(
    GetHomeEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());

    final either = await _repository.getHome();

    _emitResult(either, emit);
  }

  Future<void> _emitResult(
    Either<Failure, Home> either,
    Emitter<HomeState> emit,
  ) async {
    await either.fold(
      (failure) async {
        emit(
          HomeFailure(
            message: mapFailureToMessage(failure),
          ),
        );
      },
      (data) {
        emit(
          HomeSuccess(home: data),
        );
      },
    );
  }
}
