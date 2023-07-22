import 'package:flutter/material.dart';

import '../../../../core/theme/color_values.dart';
import '../widgets/profile_leaderboard_widget.dart';
import '../widgets/tab_text_widget.dart';
import '../widgets/tabbarview.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({Key? key}) : super(key: key);

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            const ProfileLeaderboard(),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 206, 0, 0),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
                decoration: const BoxDecoration(
                  color: ColorValues.grey01,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25)),
                ),
                child: DefaultTabController(
                  length: 3, // length of tabs
                  initialIndex: 0,
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 48,
                        decoration: BoxDecoration(
                          color: ColorValues.grey02,
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: TabBar(
                          indicatorPadding: EdgeInsets.zero,
                          labelPadding: EdgeInsets.zero,
                          labelColor: Colors.white,
                          unselectedLabelColor: ColorValues.grey04,
                          dividerColor: Colors.transparent,
                          indicator: BoxDecoration(
                            color: ColorValues.green02,
                            borderRadius: BorderRadius.circular(14.0),
                          ),
                          tabs: [
                            tabText('Hari Ini', context),
                            tabText('Minggu Ini', context),
                            tabText('Keseluruhan', context),
                          ],
                        ),
                      ),
                      const TabbarViewLeaderboard()
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
