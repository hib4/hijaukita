import 'package:dartz/dartz.dart';

import '../../../../core/constant/constant.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/util/local/local_storage.dart';
import '../../../../core/util/network/network_info.dart';
import '../../domain/entities/discover.dart';
import '../data_sources/local/discover_cache.dart';
import '../data_sources/remote/discover_remote_data_source.dart';

abstract class DiscoverRepository {
  Future<Either<Failure, Discover>> search(String text, Set<int> category);
}

class DiscoverRepositoryImpl implements DiscoverRepository {
  DiscoverRepositoryImpl({
    required this.remoteDataSource,
    required this.localStorage,
    required this.cache,
    required this.networkInfo,
  });

  final DiscoverRemoteDataSource remoteDataSource;
  final LocalStorage localStorage;
  final DiscoverCache cache;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, Discover>> search(
    String text,
    Set<int> category,
  ) async {
    final cachedTerm = CacheParam(text: text, category: category);
    final cachedResult = cache.get(cachedTerm);
    if (cachedResult != null) {
      return Right(cachedResult);
    }
    if (await networkInfo.isConnected) {
      try {
        final token = await localStorage.getTokenString(cachedBearerToken);
        final result = await remoteDataSource.search(token, text, category);
        cache.set(cachedTerm, result);
        return Right(result);
      } on ServerException {
        return Left(ServerFailure());
      } on TimeOutException {
        return Left(TimeOutFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
