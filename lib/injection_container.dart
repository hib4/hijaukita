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
import 'features/chat/data/data_sources/remote/chat_remote_data_source.dart';
import 'features/chat/data/repositories/chat_repository.dart';
import 'features/chat/presentation/bloc/chat_bloc.dart';
import 'features/home/data/data_sources/remote/home_remote_data_source.dart';
import 'features/home/data/repositories/home_repository.dart';
import 'features/home/presentation/bloc/home_bloc.dart';
import 'features/profile/data/data_sources/remote/profile_remote_data_source.dart';
import 'features/profile/data/repositories/profile_repository.dart';
import 'features/profile/presentation/bloc/profile_bloc.dart';
import 'features/quiz/data/data_sources/remote/quiz_detail_activity_data_source.dart';
import 'features/quiz/data/data_sources/remote/quiz_main_activity.dart';
import 'features/quiz/data/repositories/quiz_detail_activity_respository.dart';
import 'features/quiz/data/repositories/quiz_main_activity.dart';
import 'features/quiz/presentation/bloc/detail_quiz_activity/quiz_bloc.dart';
import 'features/quiz/presentation/bloc/main_quiz/main_quiz_bloc.dart';

final sl = GetIt.I;

Future<void> initializeServiceLocator() async {
  /// Feature - Authentication
  _initializeAuthenticationFeature();

  /// Feature - Home
  _initializeHomeFeature();

  /// Feature - Chat
  _initializeChatFeature();

  /// Feature - Profile
  _initializeProfileFeature();
  
  /// Feature - Activity
  _initializeActivityFeature();

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

void _initializeAuthenticationFeature() {
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

void _initializeHomeFeature() {
  // bloc
  sl.registerFactory(
    () => HomeBloc(
      repository: sl(),
    ),
  );

  // data sources
  sl.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(
      client: sl(),
    ),
  );

  // repository
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(
      remoteDataSource: sl(),
      localStorage: sl(),
      networkInfo: sl(),
    ),
  );
}

void _initializeChatFeature() {
  // bloc
  sl.registerFactory(
    () => ChatBloc(
      repository: sl(),
    ),
  );

  // data sources
  sl.registerLazySingleton<ChatRemoteDataSource>(
    () => ChatRemoteDataSourceImpl(
      client: sl(),
    ),
  );

  // repository
  sl.registerLazySingleton<ChatRepository>(
    () => ChatRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );
}

void _initializeProfileFeature() {
  // bloc
  sl.registerFactory(
    () => ProfileBloc(
      
void _initializeActivityFeature() {
  // bloc
  sl.registerFactory(
        () => QuizBloc(
      repository: sl(),
    ),
  );

  sl.registerFactory(
        () => QuizMainBloc(
      repository: sl(),
    ),
  );

  // data sources
  sl.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(

  sl.registerLazySingleton<QuizDetailActivityRemoteDataSource>(
        () => QuizDetailActivityRemoteDataSourceImpl(
      client: sl(),
    ),
  );

  sl.registerLazySingleton<QuizMainRemoteDataSource>(
        () => QuizMainRemoteDataSourceImpl(
      client: sl(),
    ),
  );

  // repository
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(

  sl.registerLazySingleton<QuizDetailActivityRepository>(
        () => QuizDetailActivityRepositoryImpl(
      remoteDataSource: sl(),
      localStorage: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<QuizMainRepository>(
        () => QuizMainRepositoryImpl(
      remoteDataSource: sl(),
      localStorage: sl(),
      networkInfo: sl(),
    ),
  );
}
