part of 'discover_bloc.dart';

@immutable
abstract class DiscoverState extends Equatable {
  const DiscoverState();

  @override
  List<Object> get props => [];
}

class DiscoverInitial extends DiscoverState {}

class DiscoverLoading extends DiscoverState {}

class DiscoverSuccess extends DiscoverState {
  const DiscoverSuccess({required this.discover});

  final Discover discover;

  @override
  List<Object> get props => [discover];
}

class DiscoverFailure extends DiscoverState {
  const DiscoverFailure({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}
