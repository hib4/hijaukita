import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hijaukita/core/pages/auth/authentication.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'core/bloc/observer/app_bloc_observer.dart';
import 'core/bloc/provider/provider.dart';
import 'core/theme/app_style.dart';
import 'core/theme/app_theme_data.dart';
import 'injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Initialize app styles
  deviceOrientation();
  statusBarLightStyle();

  /// Initialize service locator
  await initializeServiceLocator();

  /// Initialize BLoC observer
  Bloc.observer = AppBlocObserver();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('id_ID');
    return MultiBlocProvider(
      providers: Provider.providers(),
      child: MaterialApp(
        title: 'HijauKita',
        theme: AppThemeData.getThemeLight(),
        debugShowCheckedModeBanner: false,
        home: const AuthenticationPage(),
      ),
    );
  }
}
