part of 'redeem_code_bloc.dart';

@immutable
abstract class RedeemCodeState {}

class RedeemCodeInitial extends RedeemCodeState {}

class RedeemCodeLoading extends RedeemCodeState {}

class RedeemCodeSuccess extends RedeemCodeState {}

class RedeemCodeFailure extends RedeemCodeState {
  RedeemCodeFailure({required this.message});

  final String message;
}
