import 'package:dartz/dartz.dart';

import '../../../../core/constant/constant.dart';
import '../../../../core/util/network/network_info.dart';
import '../../domain/entities/leaderboard.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/util/local/local_storage.dart';
import '../data_sources/remote/leaderboard_remote_data_source.dart';

abstract class LeaderboardRepository {
  Future<Either<Failure, Leaderboard>> getLeaderboard(String type);
}

class LeaderboardRepositoryImpl implements LeaderboardRepository {
  const LeaderboardRepositoryImpl({
    required this.remoteDataSource,
    required this.localStorage,
    required this.networkInfo,
  });

  final LeaderboardRemoteDataSource remoteDataSource;
  final LocalStorage localStorage;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, Leaderboard>> getLeaderboard(String type) async {
    if (await networkInfo.isConnected) {
      try {
        final token = await localStorage.getTokenString(cachedBearerToken);
        final model = await remoteDataSource.getLeaderboard(token, type);
        return Right(model);
      } on ServerException {
        return Left(ServerFailure());
      } on TimeOutException {
        return Left(TimeOutFailure());
      } on CacheException {
        return Left(CacheFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
