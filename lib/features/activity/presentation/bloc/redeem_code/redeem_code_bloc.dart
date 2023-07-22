import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../../core/error/failures.dart';
import '../../../data/repositories/redeem_code_repository.dart';

part 'redeem_code_event.dart';

part 'redeem_code_state.dart';

class RedeemCodeBloc extends Bloc<RedeemCodeEvent, RedeemCodeState> {
  RedeemCodeBloc({required RedeemCodeRepository repository})
      : _repository = repository,
        super(RedeemCodeInitial()) {
    on<RedeemCodeEvent>((event, emit) {});
  }

  final RedeemCodeRepository _repository;

  Future<void> _postRedeemCodeHandler(
    PostRedeemCodeEvent event,
    Emitter<RedeemCodeState> emit,
  ) async {
    emit(RedeemCodeLoading());

    final either = await _repository.redeemCode(event.id, event.code);

    _emitResult(either, emit);
  }

  Future<void> _emitResult(
    Either<Failure, void> either,
    Emitter<RedeemCodeState> emit,
  ) async {
    await either.fold(
      (failure) async {
        emit(
          RedeemCodeFailure(
            message: mapFailureToMessage(failure),
          ),
        );
      },
      (_) async {
        emit(RedeemCodeSuccess());
      },
    );
  }
}
