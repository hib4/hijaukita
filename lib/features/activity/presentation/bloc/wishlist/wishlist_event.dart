part of 'wishlist_bloc.dart';

@immutable
abstract class WishlistEvent {}

class AddOrRemoveWishlistEvent extends WishlistEvent {
  AddOrRemoveWishlistEvent({required this.id});

  final int id;
}