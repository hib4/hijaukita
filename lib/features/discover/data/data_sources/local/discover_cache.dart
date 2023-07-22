import 'package:equatable/equatable.dart';

import '../../../domain/entities/discover.dart';

class CacheParam extends Equatable {
  const CacheParam({required this.text, required this.category});

  final String text;
  final Set<int> category;

  @override
  List<Object?> get props => [text, category];
}

class DiscoverCache {
  final _cache = <CacheParam, Discover>{};

  Discover? get(CacheParam term) => _cache[term];

  void set(CacheParam term, Discover result) => _cache[term] = result;

  bool contains(CacheParam term) => _cache.containsKey(term);

  void remove(CacheParam term) => _cache.remove(term);
}
