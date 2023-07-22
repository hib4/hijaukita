import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../../core/error/failures.dart';
import '../../../data/repositories/detail_category_repository.dart';
import '../../../domain/entities/detail_category.dart';

part 'detail_category_event.dart';

part 'detail_category_state.dart';

class DetailCategoryBloc
    extends Bloc<DetailCategoryEvent, DetailCategoryState> {
  DetailCategoryBloc({required DetailCategoryRepository repository})
      : _repository = repository,
        super(DetailCategoryInitial()) {
    on<GetDetailCategoryEvent>(_getDetailCategoryEventHandler);
  }

  final DetailCategoryRepository _repository;

  Future<void> _getDetailCategoryEventHandler(
    GetDetailCategoryEvent event,
    Emitter<DetailCategoryState> emit,
  ) async {
    emit(DetailCategoryLoading());

    final either = await _repository.getDetailCategory(event.id);

    await _emitResult(either, emit);
  }

  Future<void> _emitResult(
    Either<Failure, DetailCategory> either,
    Emitter<DetailCategoryState> emit,
  ) async {
    await either.fold(
      (failure) async {
        emit(
          DetailCategoryFailure(
            message: mapFailureToMessage(failure),
          ),
        );
      },
      (data) {
        emit(
          DetailCategorySuccess(detailCategory: data),
        );
      },
    );
  }
}
