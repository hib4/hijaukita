import 'package:dartz/dartz.dart';

import '../../../../core/constant/constant.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/util/local/local_storage.dart';
import '../../../../core/util/network/network_info.dart';
import '../data_sources/remote/upload_photo_remote_data_source.dart';

abstract class UploadPhotoRepository {
  Future<Either<Failure, void>> uploadPhoto({
    required int activityId,
    required String desc,
    required String photo,
  });
}

class UploadPhotoRepositoryImpl implements UploadPhotoRepository {
  UploadPhotoRepositoryImpl({
    required this.remoteDataSource,
    required this.localStorage,
    required this.networkInfo,
  });

  final UploadPhotoRemoteDataSource remoteDataSource;
  final LocalStorage localStorage;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, void>> uploadPhoto({
    required int activityId,
    required String desc,
    required String photo,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final token = await localStorage.getTokenString(cachedBearerToken);
        await remoteDataSource.uploadPhoto(
          token: token,
          activityId: activityId,
          desc: desc,
          photo: photo,
        );
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
