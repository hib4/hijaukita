part of 'otp_bloc.dart';

@immutable
abstract class OtpEvent {}

class SendOtpEvent extends OtpEvent {
  SendOtpEvent({required this.otp});

  final String otp;
}
