import 'package:dartz/dartz.dart';
import 'package:hijaukita/features/profile/domain/entities/profile.dart';

import '../../../../core/constant/constant.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/util/local/local_storage.dart';
import '../../../../core/util/network/network_info.dart';
import '../data_sources/remote/profile_remote_data_source.dart';

abstract class ProfileRepository {
  Future<Either<Failure, Profile>> getProfile();
}

class ProfileRepositoryImpl implements ProfileRepository {
  ProfileRepositoryImpl({
    required this.remoteDataSource,
    required this.localStorage,
    required this.networkInfo,
  });

  final ProfileRemoteDataSource remoteDataSource;
  final LocalStorage localStorage;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, Profile>> getProfile() async {
    if (await networkInfo.isConnected) {
      try {
        final token = await localStorage.getTokenString(cachedBearerToken);
        final model = await remoteDataSource.getProfile(token);
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
