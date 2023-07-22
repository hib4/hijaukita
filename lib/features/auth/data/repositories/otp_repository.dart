import 'package:dartz/dartz.dart';
import 'package:hijaukita/core/util/local/local_storage.dart';

import '../../../../core/constant/constant.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/util/network/network_info.dart';
import '../data_sources/remote/otp_remote_data_source.dart';

abstract class OtpRepository {
  Future<Either<Failure, void>> sendOtp(String otp);
}

class OtpRepositoryImpl implements OtpRepository {
  const OtpRepositoryImpl({
    required this.remoteDataSource,
    required this.localStorage,
    required this.networkInfo,
  });

  final OtpRemoteDataSource remoteDataSource;
  final LocalStorage localStorage;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, void>> sendOtp(String otp) async {
    if (await networkInfo.isConnected) {
      try {
        final token = await localStorage.getTokenString(cachedBearerToken);
        await remoteDataSource.sendOtp(token, otp);
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
