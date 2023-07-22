part of 'wishlist_bloc.dart';

@immutable
abstract class WishlistState {}

class WishlistInitial extends WishlistState {}

class WishlistLoading extends WishlistState {}

class WishlistSuccess extends WishlistState {}

class WishlistFailure extends WishlistState {
  WishlistFailure({required this.message});

  final String message;
}