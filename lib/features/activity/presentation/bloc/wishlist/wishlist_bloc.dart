import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../../core/error/failures.dart';
import '../../../data/repositories/wishlist_repository.dart';

part 'wishlist_event.dart';

part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc({required WishlistRepository repository})
      : _repository = repository,
        super(WishlistInitial()) {
    on<AddOrRemoveWishlistEvent>(_addOrRemoveActivityEventHandler);
  }

  final WishlistRepository _repository;

  Future _addOrRemoveActivityEventHandler(
    AddOrRemoveWishlistEvent event,
    Emitter<WishlistState> emit,
  ) async {
    emit(WishlistLoading());

    final either = await _repository.addOrRemoveActivity(event.id);

    _emitWishlistResult(either, emit);
  }

  Future _emitWishlistResult(
    Either<Failure, void> either,
    Emitter<WishlistState> emit,
  ) async {
    await either.fold(
      (failure) async {
        emit(
          WishlistFailure(
            message: mapFailureToMessage(failure),
          ),
        );
      },
      (_) async {
        emit(WishlistSuccess());
      },
    );
  }
}
