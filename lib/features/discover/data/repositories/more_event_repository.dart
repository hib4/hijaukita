import 'package:dartz/dartz.dart';

import '../../../../core/constant/constant.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/util/local/local_storage.dart';
import '../../../../core/util/network/network_info.dart';
import '../../domain/entities/more_event.dart';
import '../data_sources/remote/more_event_remote_data_source.dart';

abstract class MoreEventRepository {
  Future<Either<Failure, MoreEvent>> getMoreEvent();
}

class MoreEventRepositoryImpl implements MoreEventRepository {
  MoreEventRepositoryImpl({
    required this.remoteDataSource,
    required this.localStorage,
    required this.networkInfo,
  });

  final MoreEventRemoteDataSource remoteDataSource;
  final LocalStorage localStorage;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, MoreEvent>> getMoreEvent() async {
    if (await networkInfo.isConnected) {
      try {
        final token = await localStorage.getTokenString(cachedBearerToken);
        final result = await remoteDataSource.getMoreEvent(token);
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
