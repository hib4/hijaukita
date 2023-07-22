part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent {}

class PostRegisterEvent extends RegisterEvent {
  PostRegisterEvent({
    required this.fullName,
    required this.email,
    required this.password,
  });

  final String fullName;
  final String email;
  final String password;
}
