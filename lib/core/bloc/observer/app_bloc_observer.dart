import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    debugPrint('onCreate ${bloc.runtimeType}');
    super.onCreate(bloc);
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    debugPrint('onEvent $event');
    super.onEvent(bloc, event);
  }

  @override
  void onClose(BlocBase bloc) {
    debugPrint('onClose ${bloc.runtimeType}');
    super.onClose(bloc);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    debugPrint('onError $error');
    super.onError(bloc, error, stackTrace);
  }
}