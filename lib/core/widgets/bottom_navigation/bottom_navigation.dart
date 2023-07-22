import 'package:flutter/material.dart';
import 'package:hijaukita/features/leardboard/presentation/pages/leaderboard.dart';

import '../../../features/home/presentation/pages/home_page.dart';
import '../../../features/profile/presentation/pages/profile_page.dart';
import '../../gen/assets.gen.dart';
import '../../theme/color_values.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _currentIndex = 0;
  late final PageController _controller;

  final _tabs = [
    const HomePage(),
    const SizedBox(),
    const LeaderboardPage(),
    const ProfilePage(),
  ];

  final _items = [
    BottomNavigationBarItem(
      icon: Assets.icons.home.svg(),
      activeIcon: Assets.icons.home.svg(color: ColorValues.green02),
      label: 'Beranda',
      tooltip: 'Beranda',
    ),
    BottomNavigationBarItem(
      icon: Assets.icons.discover.svg(),
      activeIcon: Assets.icons.discover.svg(color: ColorValues.green02),
      label: 'Cari',
      tooltip: 'Cari',
    ),
    BottomNavigationBarItem(
      icon: Assets.icons.leaderboard.svg(),
      activeIcon: Assets.icons.leaderboard.svg(color: ColorValues.green02),
      label: 'Peringkat',
      tooltip: 'Peringkat',
    ),
    BottomNavigationBarItem(
      icon: Assets.icons.profile.svg(),
      activeIcon: Assets.icons.profile.svg(color: ColorValues.green02),
      label: 'Profil',
      tooltip: 'Profil',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: PageView(
        controller: _controller,
        physics: const NeverScrollableScrollPhysics(),
        children: _tabs,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _items,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: ColorValues.green02,
        selectedLabelStyle: textTheme.bodySmall,
        unselectedLabelStyle: textTheme.bodySmall,
        showUnselectedLabels: true,
        showSelectedLabels: true,
        elevation: 5,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            _controller.jumpToPage(index);
          });
        },
      ),
    );
  }
}
