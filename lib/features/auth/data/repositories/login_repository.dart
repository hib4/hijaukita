import 'package:dartz/dartz.dart';

import 'package:hijaukita/core/constant/constant.dart';
import 'package:hijaukita/core/error/failures.dart';
import 'package:hijaukita/core/util/local/local_storage.dart';
import 'package:hijaukita/core/util/network/network_info.dart';

import '../../../../core/error/exceptions.dart';
import '../data_sources/remote/login_remote_data_source.dart';

abstract class LoginRepository {
  Future<Either<Failure, void>> emailLogin(String email, String password);

  Future<Either<Failure, void>> googleLogin(String token);
}

class LoginRepositoryImpl implements LoginRepository {
  LoginRepositoryImpl({
    required this.remoteDataSource,
    required this.localStorage,
    required this.networkInfo,
  });

  final LoginRemoteDataSource remoteDataSource;
  final LocalStorage localStorage;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, void>> emailLogin(String email, String password) async {
    if (await networkInfo.isConnected) {
      try {
        final res = await remoteDataSource.emailLogin(email, password);
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

  @override
  Future<Either<Failure, void>> googleLogin(String idToken) async {
    if (await networkInfo.isConnected) {
      try {
        final token = await remoteDataSource.googleLogin(idToken);
        // await localStorage.setTokenString(cachedBearerToken, token);
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
