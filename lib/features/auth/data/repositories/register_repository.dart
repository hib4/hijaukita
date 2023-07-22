import 'package:dartz/dartz.dart';
import 'package:hijaukita/core/error/failures.dart';
import 'package:hijaukita/features/auth/data/data_sources/remote/register_remote_data_source.dart';

import '../../../../core/constant/constant.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/util/local/local_storage.dart';
import '../../../../core/util/network/network_info.dart';

abstract class RegisterRepository {
  Future<Either<Failure, void>> register(
    String fullName,
    String email,
    String password,
  );
}

class RegisterRepositoryImpl implements RegisterRepository {
  const RegisterRepositoryImpl({
    required this.remoteDataSource,
    required this.localStorage,
    required this.networkInfo,
  });

  final RegisterRemoteDataSource remoteDataSource;
  final LocalStorage localStorage;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, void>> register(
    String fullName,
    String email,
    String password,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final res = await remoteDataSource.register(fullName, email, password);
        await localStorage.setTokenString(cachedBearerToken, res);
        return const Right(null);
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
