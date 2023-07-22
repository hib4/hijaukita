import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'core/util/local/local_storage.dart';
import 'core/util/network/network_info.dart';
import 'features/auth/data/data_sources/remote/login_remote_data_source.dart';
import 'features/auth/data/data_sources/remote/otp_remote_data_source.dart';
import 'features/auth/data/data_sources/remote/register_remote_data_source.dart';
import 'features/auth/data/repositories/login_repository.dart';
import 'features/auth/data/repositories/otp_repository.dart';
import 'features/auth/data/repositories/register_repository.dart';
import 'features/auth/presentation/bloc/login/login_bloc.dart';
import 'features/auth/presentation/bloc/otp/otp_bloc.dart';
import 'features/auth/presentation/bloc/register/register_bloc.dart';

final sl = GetIt.I;

Future<void> initializeServiceLocator() async {
  /// Feature - Login
  _initializeLoginFeature();

  /// Core
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(
      sl(),
    ),
  );

  sl.registerLazySingleton<LocalStorage>(
    () => LocalStorageImpl(
      sharedPreferences: sl(),
    ),
  );

  /// External
  final sharedPreferences = await SharedPreferences.getInstance();

  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}

void _initializeLoginFeature() {
  // bloc
  sl.registerFactory(
    () => LoginBloc(
      repository: sl(),
    ),
  );

  sl.registerFactory(
    () => RegisterBloc(
      repository: sl(),
    ),
  );

  sl.registerFactory(
    () => OtpBloc(
      repository: sl(),
    ),
  );

  // data sources
  sl.registerLazySingleton<LoginRemoteDataSource>(
    () => LoginRemoteDataSourceImpl(
      client: sl(),
    ),
  );

  sl.registerLazySingleton<RegisterRemoteDataSource>(
    () => RegisterRemoteDataSourceImpl(
      client: sl(),
    ),
  );

  sl.registerLazySingleton<OtpRemoteDataSource>(
    () => OtpRemoteDataSourceImpl(
      client: sl(),
    ),
  );

  // repository
  sl.registerLazySingleton<LoginRepository>(
    () => LoginRepositoryImpl(
      remoteDataSource: sl(),
      localStorage: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<RegisterRepository>(
    () => RegisterRepositoryImpl(
      remoteDataSource: sl(),
      localStorage: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<OtpRepository>(
    () => OtpRepositoryImpl(
      remoteDataSource: sl(),
      localStorage: sl(),
      networkInfo: sl(),
    ),
  );
}
