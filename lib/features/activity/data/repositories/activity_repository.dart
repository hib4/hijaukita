import 'package:dartz/dartz.dart';

import '../../../../core/constant/constant.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/util/local/local_storage.dart';
import '../../../../core/util/network/network_info.dart';
import '../../domain/entities/activity.dart';
import '../data_sources/remote/activity_remote_data_source.dart';

abstract class ActivityRepository {
  Future<Either<Failure, Activity>> getActivity(int id);
}

class ActivityRepositoryImpl implements ActivityRepository {
  const ActivityRepositoryImpl({
    required this.remoteDataSource,
    required this.localStorage,
    required this.networkInfo,
  });

  final ActivityRemoteDataSource remoteDataSource;
  final LocalStorage localStorage;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, Activity>> getActivity(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final token = await localStorage.getTokenString(cachedBearerToken);
        final model = await remoteDataSource.getActivity(token, id);
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
