import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/pages/failure/failure_page.dart';
import '../../../../core/theme/color_values.dart';
import '../bloc/leaderboard_bloc.dart';
import '../bloc/leaderboard_event.dart';
import '../bloc/leaderboard_state.dart';

class ProfileLeaderboard extends StatefulWidget {
  const ProfileLeaderboard({Key? key}) : super(key: key);

  @override
  State<ProfileLeaderboard> createState() => _ProfileLeaderboardState();
}

class _ProfileLeaderboardState extends State<ProfileLeaderboard> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<LeaderboardBloc>().add(GetLeaderboardEvent(type: 'today'));
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BlocBuilder<LeaderboardBloc, LeaderboardState>(
      builder: (context, state) {
        if (state is LeaderboardLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is LeaderboardSuccess) {
          final data = state.leaderboard.data;
          return Padding(
            padding: const EdgeInsets.only(top: 22),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: CachedNetworkImageProvider(data.myPoint.avatarUrl),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  data.myPoint.name,
                  style: textTheme.titleMedium!.copyWith(
                    color: ColorValues.black01,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  data.myPoint.point,
                  style: textTheme.titleMedium!.copyWith(
                    color: ColorValues.green01,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          );
        } else if (state is LeaderboardFailure) {
          return FailurePage(
            message: state.message,
            onPressed: () {},
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}

