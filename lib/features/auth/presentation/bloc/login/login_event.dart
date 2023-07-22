part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class EmailLoginEvent extends LoginEvent {
  EmailLoginEvent({required this.email, required this.password});

  final String email;
  final String password;
}

class GoogleLoginEvent extends LoginEvent {}
