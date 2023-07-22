import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:hijaukita/features/auth/data/repositories/register_repository.dart';
import 'package:meta/meta.dart';

import '../../../../../core/error/failures.dart';

part 'register_event.dart';

part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc({required RegisterRepository repository})
      : _repository = repository,
        super(RegisterInitial()) {
    on<PostRegisterEvent>(_postRegisterEventHandler);
  }

  final RegisterRepository _repository;

  Future<void> _postRegisterEventHandler(
    PostRegisterEvent event,
    Emitter<RegisterState> emit,
  ) async {
    emit(RegisterLoading());

    final either = await _repository.register(
      event.fullName,
      event.email,
      event.password,
    );

    _emitResult(either, emit);
  }

  Future<void> _emitResult(
    Either<Failure, void> either,
    Emitter<RegisterState> emit,
  ) async {
    await either.fold(
      (failure) async {
        emit(
          RegisterFailure(
            message: mapFailureToMessage(failure),
          ),
        );
      },
      (_) {
        emit(
          RegisterSuccess(),
        );
      },
    );
  }
}
