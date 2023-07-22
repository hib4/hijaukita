import 'package:dartz/dartz.dart';

import '../../../../../core/constant/constant.dart';
import '../../../../../core/error/exceptions.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/util/local/local_storage.dart';
import '../../../../../core/util/network/network_info.dart';

abstract class LogoutRepository {
  Future<Either<Failure, void>> logout();
}

class LogoutRepositoryImpl implements LogoutRepository {
  const LogoutRepositoryImpl({
    required this.localStorage,
    required this.networkInfo,
  });

  final LocalStorage localStorage;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await localStorage.removeToken(cachedBearerToken);
      await
      return const Right(null);
    }
  }
}