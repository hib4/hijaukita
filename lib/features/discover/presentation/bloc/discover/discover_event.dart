part of 'discover_bloc.dart';

@immutable
abstract class DiscoverEvent extends Equatable {
  const DiscoverEvent();
}

class ValueDiscoverChangedEvent extends DiscoverEvent {
  const ValueDiscoverChangedEvent({
    this.text = '',
    this.category = const <int>{},
  });

  final String text;
  final Set<int> category;

  @override
  List<Object?> get props => [text, category];
}

class ValueDiscoverRefreshEvent extends DiscoverEvent {
  const ValueDiscoverRefreshEvent();

  @override
  List<Object?> get props => [];
}
