import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:hijaukita/features/auth/data/repositories/otp_repository.dart';
import 'package:meta/meta.dart';

import '../../../../../core/error/failures.dart';

part 'otp_event.dart';

part 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  OtpBloc({required OtpRepository repository})
      : _repository = repository,
        super(OtpInitial()) {
    on<SendOtpEvent>(_sendEventHandler);
  }

  final OtpRepository _repository;

  Future _sendEventHandler(
    SendOtpEvent event,
    Emitter<OtpState> emit,
  ) async {
    emit(OtpLoading());

    final either = await _repository.sendOtp(event.otp);

    _emitResult(either, emit);
  }

  Future<void> _emitResult(
    Either<Failure, void> either,
    Emitter<OtpState> emit,
  ) async {
    await either.fold(
      (failure) async {
        emit(
          OtpFailure(
            message: mapFailureToMessage(failure),
          ),
        );
      },
      (_) {
        emit(
          OtpSuccess(),
        );
      },
    );
  }
}
