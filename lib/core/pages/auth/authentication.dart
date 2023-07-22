import 'package:flutter/material.dart';
import 'package:hijaukita/core/widgets/bottom_navigation/bottom_navigation.dart';
import 'package:hijaukita/features/auth/presentation/pages/login/login_page.dart';
import 'package:hijaukita/features/home/presentation/pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../features/auth/presentation/pages/otp/otp_page.dart';
import '../../../features/on_boarding/presentation/pages/on_boarding_page.dart';
import '../../../injection_container.dart';
import '../../constant/constant.dart';
import '../../route/navigator.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({super.key});

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  Future _initialize() async {
    final sharedPreferences = sl.get<SharedPreferences>();
    final token = sharedPreferences.getString(cachedBearerToken);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (token == null) {
        navigatorPushAndRemove(
          context,
          const LoginPage(),
        );
      } else {
        navigatorPushAndRemove(context, const BottomNavigation());
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
