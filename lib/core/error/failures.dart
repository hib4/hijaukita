import 'package:equatable/equatable.dart';

import '../constant/constant.dart';

abstract class Failure extends Equatable {
  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure {
  ServerFailure([this.message]);

  final String? message;

  @override
  List<Object?> get props => [message];
}

class NetworkFailure extends Failure {
  NetworkFailure([this.message]);

  final String? message;

  @override
  List<Object?> get props => [message];
}

class TimeOutFailure extends Failure {
  TimeOutFailure([this.message]);

  final String? message;

  @override
  List<Object?> get props => [message];
}

class CacheFailure extends Failure {
  CacheFailure([this.message]);

  final String? message;

  @override
  List<Object?> get props => [message];
}

String mapFailureToMessage(Failure failure) {
  late final String failureMessage;

  switch (failure.runtimeType) {
    case ServerFailure:
      failure as ServerFailure;
      failureMessage = failure.message ?? serverFailureMessage;
      break;
    case NetworkFailure:
      failure as NetworkFailure;
      failureMessage = failure.message ?? networkFailureMessage;
      break;
    case TimeOutFailure:
      failure as TimeOutFailure;
      failureMessage = failure.message ?? connectionFailureMessage;
      break;
    case CacheFailure:
      failure as CacheFailure;
      failureMessage = failure.message ?? cacheFailureMessage;
      break;
    default:
      failureMessage = 'Terjadi kesalahan';
      break;
  }

  return failureMessage;
}
