import 'package:dartz/dartz.dart';

import '../../../../core/constant/constant.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/util/local/local_storage.dart';
import '../../../../core/util/network/network_info.dart';
import '../../domain/entities/detail_category.dart';
import '../data_sources/remote/detail_category_remote_data_source.dart';

abstract class DetailCategoryRepository {
  Future<Either<Failure, DetailCategory>> getDetailCategory(int id);
}

class DetailCategoryRepositoryImpl implements DetailCategoryRepository {
  const DetailCategoryRepositoryImpl({
    required this.remoteDataSource,
    required this.localStorage,
    required this.networkInfo,
  });

  final DetailCategoryRemoteDataSource remoteDataSource;
  final LocalStorage localStorage;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, DetailCategory>> getDetailCategory(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final token = await localStorage.getTokenString(cachedBearerToken);
        final result = await remoteDataSource.getDetailCategory(token, id);
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
