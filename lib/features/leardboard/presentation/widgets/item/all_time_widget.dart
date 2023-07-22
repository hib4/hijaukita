import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/pages/failure/failure_page.dart';
import '../../bloc/leaderboard_bloc.dart';
import '../../bloc/leaderboard_event.dart';
import '../../bloc/leaderboard_state.dart';
import '../card_leaderboard_widget.dart';

class AllTimeWidget extends StatefulWidget {
  const AllTimeWidget({Key? key}) : super(key: key);

  @override
  State<AllTimeWidget> createState() => _AllTimeWidgetState();
}

class _AllTimeWidgetState extends State<AllTimeWidget> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<LeaderboardBloc>().add(GetLeaderboardEvent(type: 'all-time'));
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
