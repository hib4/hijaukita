import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

import '../../../../../core/error/failures.dart';
import '../../../data/repositories/login_repository.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required LoginRepository repository})
      : _repository = repository,
        super(LoginInitial()) {
    on<EmailLoginEvent>(_emailLoginEventHandler);
    on<GoogleLoginEvent>(_googleLoginEventHandler);
  }

  final LoginRepository _repository;

  Future _emailLoginEventHandler(
    EmailLoginEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());

    final either = await _repository.emailLogin(event.email, event.password);

    _emitResult(either, emit);
  }

  Future _googleLoginEventHandler(
    GoogleLoginEvent event,
    Emitter<LoginState> emit,
  ) async {
    try {
      final google = GoogleSignIn();
      final account = await google.signIn();
      if (account != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await account.authentication;
        final idToken = googleSignInAuthentication.idToken;
        log('id = $idToken');

        emit(LoginLoading());
        final either = await _repository.googleLogin(idToken!);
        _emitResult(either, emit);
      }
    } on PlatformException {
      emit(
        LoginFailure(
          message: 'Login gagal',
        ),
      );
    }
  }

  Future<void> _emitResult(
    Either<Failure, void> either,
    Emitter<LoginState> emit,
  ) async {
    await either.fold(
      (failure) async {
        emit(
          LoginFailure(
            message: mapFailureToMessage(failure),
          ),
        );
      },
      (_) {
        emit(
          LoginSuccess(),
        );
      },
    );
  }
}
