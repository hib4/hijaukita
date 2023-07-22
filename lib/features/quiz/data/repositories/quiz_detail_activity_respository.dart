
import 'package:dartz/dartz.dart';

import '../../../../core/constant/constant.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/util/local/local_storage.dart';
import '../../../../core/util/network/network_info.dart';
import '../../domain/entities/quiz_detail_activity.dart';
import '../data_sources/remote/quiz_detail_activity_data_source.dart';

abstract class QuizDetailActivityRepository {
  Future<Either<Failure, QuizDetailActivity>> getQuizDetailActivity(int id);
}

class QuizDetailActivityRepositoryImpl implements QuizDetailActivityRepository {
  const QuizDetailActivityRepositoryImpl({
    required this.remoteDataSource,
    required this.localStorage,
    required this.networkInfo,
  });

  final QuizDetailActivityRemoteDataSource remoteDataSource;
  final LocalStorage localStorage;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, QuizDetailActivity>> getQuizDetailActivity(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final token = await localStorage.getTokenString(cachedBearerToken);
        final model = await remoteDataSource.getQuizDetailActivity(token, id);
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