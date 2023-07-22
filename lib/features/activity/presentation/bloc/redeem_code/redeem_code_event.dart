part of 'redeem_code_bloc.dart';

@immutable
abstract class RedeemCodeEvent {}

class PostRedeemCodeEvent extends RedeemCodeEvent {
  PostRedeemCodeEvent({required this.id, required this.code});

  final int id;
  final String code;
}
