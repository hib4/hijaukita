import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/util/network/network_info.dart';
import '../../domain/entities/chat.dart';
import '../data_sources/remote/chat_remote_data_source.dart';

abstract class ChatRepository {
  Future<Either<Failure, Chat>> postChat(String message);
}

class ChatRepositoryImpl implements ChatRepository {
  const ChatRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  final ChatRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, Chat>> postChat(String message) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.postChat(message);
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
