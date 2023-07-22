import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/pages/failure/failure_page.dart';
import '../../bloc/leaderboard_bloc.dart';
import '../../bloc/leaderboard_event.dart';
import '../../bloc/leaderboard_state.dart';
import '../card_leaderboard_widget.dart';

class LastWeekItem extends StatefulWidget {
  const LastWeekItem({Key? key}) : super(key: key);

  @override
  State<LastWeekItem> createState() => _LastWeekItemState();
}

class _LastWeekItemState extends State<LastWeekItem> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<LeaderboardBloc>().add(GetLeaderboardEvent(type: 'last-week'));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LeaderboardBloc, LeaderboardState>(
      builder: (context, state) {
        if (state is LeaderboardLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is LeaderboardSuccess) {
          final data = state.leaderboard.data;
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: data.leaderboard.length,
            itemBuilder: (context, index) {
              return cardLeaderboard(data.leaderboard[index].user.name, index, data.leaderboard[index].totalPoint, data.leaderboard[index].user.avatarUrl, context);
            },
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
