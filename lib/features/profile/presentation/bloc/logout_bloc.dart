import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hijaukita/features/profile/data/repositories/logout_repository.dart';
import 'package:hijaukita/features/profile/presentation/bloc/logout_event.dart';
import 'package:hijaukita/features/profile/presentation/bloc/logout_state.dart';

import '../../../../core/error/failures.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState>{
  LogoutBloc({required LogoutRepository repository}) : _repository = repository, super(LogoutInitial()){
    on<allLogoutEvent>(_allLogoutEventHandler);
  }

  final LogoutRepository _repository;

  Future<void> _allLogoutEventHandler(allLogoutEvent event, Emitter<LogoutState> emit) async {
    emit(LogoutLoading());

    final either = await _repository.logout();

    _emitLogoutResult(either, emit);
  }

  Future<void> _emitLogoutResult(Either<Failure, void> either, Emitter<LogoutState> emit) async {
    await either.fold(
      (failure) async {
        emit(
          LogoutFailure(
            message: mapFailureToMessage(failure),
          ),
        );
      },
      (logout) async {
        emit(LogoutSuccess());
      },
    );
  }

}