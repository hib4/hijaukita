import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../../core/error/failures.dart';
import '../../../data/repositories/more_category_repository.dart';
import '../../../domain/entities/more_category.dart';

part 'more_category_event.dart';

part 'more_category_state.dart';

class MoreCategoryBloc extends Bloc<MoreCategoryEvent, MoreCategoryState> {
  MoreCategoryBloc({required MoreCategoryRepository repository})
      : _repository = repository,
        super(MoreCategoryInitial()) {
    on<GetMoreCategory>(_moreCategoryEventHandler);
  }

  final MoreCategoryRepository _repository;

  Future<void> _moreCategoryEventHandler(
    MoreCategoryEvent event,
    Emitter<MoreCategoryState> emit,
  ) async {
    emit(MoreCategoryLoading());

    final either = await _repository.getMoreCategory();

    _emitResult(either, emit);
  }

  Future<void> _emitResult(
    Either<Failure, MoreCategory> either,
    Emitter<MoreCategoryState> emit,
  ) async {
    await either.fold(
      (failure) async {
        emit(
          MoreCategoryFailure(
            message: mapFailureToMessage(failure),
          ),
        );
      },
      (data) {
        emit(
          MoreCategorySuccess(moreCategory: data),
        );
      },
    );
  }
}
