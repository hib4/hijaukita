import 'package:dartz/dartz.dart';

import '../../../../core/constant/constant.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/util/local/local_storage.dart';
import '../../../../core/util/network/network_info.dart';
import '../data_sources/remote/redeem_code_remote_data_source.dart';

abstract class RedeemCodeRepository {
  Future<Either<Failure, void>> redeemCode(int id, String code);
}

class RedeemCodeRepositoryImpl implements RedeemCodeRepository {
  RedeemCodeRepositoryImpl({
    required this.remoteDataSource,
    required this.localStorage,
    required this.networkInfo,
  });

  final RedeemCodeRemoteDataSource remoteDataSource;
  final LocalStorage localStorage;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, void>> redeemCode(int id, String code) async {
    if (await networkInfo.isConnected) {
      try {
        final token = await localStorage.getTokenString(cachedBearerToken);
        await remoteDataSource.redeemCode(token, id, code);
        return const Right(null);
      } on ServerException {
        return Left(ServerFailure('Kode tidak valid'));
      } on TimeOutException {
        return Left(TimeOutFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
