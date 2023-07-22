import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:hijaukita/features/profile/data/repositories/profile_repository.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/profile.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({required ProfileRepository repository})
      : _repository = repository,
        super(ProfileInitial()) {
    on<GetProfileEvent>(_getHomeEventHandler);
  }

  final ProfileRepository _repository;

  Future<void> _getHomeEventHandler(
    GetProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());

    final either = await _repository.getProfile();

    _emitResult(either, emit);
  }

  Future<void> _emitResult(
    Either<Failure, Profile> either,
    Emitter<ProfileState> emit,
  ) async {
    await either.fold(
      (failure) async {
        emit(
          ProfileFailure(
            message: mapFailureToMessage(failure),
          ),
        );
      },
      (data) {
        emit(
          ProfileSuccess(profile: data),
        );
      },
    );
  }
}
