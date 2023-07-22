import 'package:flutter/material.dart';
import 'item/all_time_widget.dart';
import 'item/last_week_widget.dart';
import 'item/today_widget.dart';

class TabbarViewLeaderboard extends StatelessWidget {
  const TabbarViewLeaderboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 10),
        height: 386,
        child: const TabBarView(children: [
          TodayItem(),
          LastWeekItem(),
          AllTimeWidget(),
        ]));
  }
}
