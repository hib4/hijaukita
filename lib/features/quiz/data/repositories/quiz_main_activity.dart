import 'package:dartz/dartz.dart';

import '../../../../core/constant/constant.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/util/local/local_storage.dart';
import '../../../../core/util/network/network_info.dart';
import '../../domain/entities/quiz_detail_activity.dart';
import '../data_sources/remote/quiz_main_activity.dart';

abstract class QuizMainRepository {
  Future<Either<Failure, QuizDetailActivity>> getQuizMain(int id);
}

class QuizMainRepositoryImpl implements QuizMainRepository {
  const QuizMainRepositoryImpl({
    required this.remoteDataSource,
    required this.localStorage,
    required this.networkInfo,
  });

  final QuizMainRemoteDataSource remoteDataSource;
  final LocalStorage localStorage;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, QuizDetailActivity>> getQuizMain(int id) async {
    if(await networkInfo.isConnected){
      try {
        final token = await localStorage.getTokenString(cachedBearerToken);
        final model = await remoteDataSource.getQuizMain(token, id);
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