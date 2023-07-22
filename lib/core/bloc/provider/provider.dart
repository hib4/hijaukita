import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hijaukita/features/profile/presentation/bloc/logout_bloc.dart';

import '../../../features/auth/presentation/bloc/login/login_bloc.dart';
import '../../../features/auth/presentation/bloc/otp/otp_bloc.dart';
import '../../../features/auth/presentation/bloc/register/register_bloc.dart';
import '../../../features/chat/presentation/bloc/chat_bloc.dart';
import '../../../features/discover/presentation/bloc/discover/discover_bloc.dart';
import '../../../features/home/presentation/bloc/home_bloc.dart';
import '../../../features/leardboard/presentation/bloc/leaderboard_bloc.dart';
import '../../../injection_container.dart';

class Provider {
  static providers() {
    return [
      BlocProvider(
        create: (_) => sl.get<LoginBloc>(),
      ),
      BlocProvider(
        create: (_) => sl.get<RegisterBloc>(),
      ),
      BlocProvider(
        create: (_) => sl.get<OtpBloc>(),
      ),
      BlocProvider(
        create: (_) => sl.get<HomeBloc>(),
      ),
      BlocProvider(
        create: (_) => sl.get<ChatBloc>(),
      ),
      BlocProvider(
        create: (_) => sl.get<DiscoverBloc>(),
      ),
      BlocProvider(
        create: (_) => sl.get<LeaderboardBloc>(),
      ),
      BlocProvider(
        create: (_) => sl.get<LogoutBloc>(),
      ),
    ];
  }
}