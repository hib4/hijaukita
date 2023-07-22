import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../../core/error/failures.dart';
import '../../../data/repositories/upload_photo_repository.dart';

part 'upload_photo_event.dart';

part 'upload_photo_state.dart';

class UploadPhotoBloc extends Bloc<UploadPhotoEvent, UploadPhotoState> {
  UploadPhotoBloc({required UploadPhotoRepository repository})
      : _repository = repository,
        super(UploadPhotoInitial()) {
    on<PostUploadPhotoEvent>(_postUploadPhotoEventHandler);
  }

  final UploadPhotoRepository _repository;

  Future<void> _postUploadPhotoEventHandler(
    PostUploadPhotoEvent event,
    Emitter<UploadPhotoState> emit,
  ) async {
    emit(UploadPhotoLoading());

    final either = await _repository.uploadPhoto(
      activityId: event.activityId,
      desc: event.desc,
      photo: event.photo,
    );

    _emitUploadPhotoResult(either, emit);
  }

  Future<void> _emitUploadPhotoResult(
    Either<Failure, void> either,
    Emitter<UploadPhotoState> emit,
  ) async {
    await either.fold(
      (failure) async {
        emit(
          UploadPhotoFailure(
            message: mapFailureToMessage(failure),
          ),
        );
      },
      (_) async {
        emit(UploadPhotoSuccess());
      },
    );
  }
}
