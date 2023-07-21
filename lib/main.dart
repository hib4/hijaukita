import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'core/theme/app_style.dart';
import 'core/theme/app_theme_data.dart';
import 'features/on_boarding/presentation/pages/on_boarding_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Initialize app styles
  deviceOrientation();
  statusBarLightStyle();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('id_ID');
    return MaterialApp(
      title: 'HijauKita',
      theme: AppThemeData.getThemeLight(),
      debugShowCheckedModeBanner: false,
      home: const OnBoardingPage(),
    );
  }
}
