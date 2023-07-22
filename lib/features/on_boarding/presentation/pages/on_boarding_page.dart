import 'package:flutter/material.dart';
import 'package:hijaukita/core/route/navigator.dart';
import 'package:hijaukita/core/theme/color_values.dart';
import 'package:hijaukita/features/auth/presentation/pages/login/login_page.dart';
import 'package:hijaukita/features/on_boarding/presentation/widgets/on_boarding_widget.dart';

import '../../../../core/gen/assets.gen.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final _pageController = PageController();
  late List<Widget> _onBoarding;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
    _onBoarding = [
      OnBoardingWidget(
        pageController: _pageController,
        image: Assets.images.globe.svg(),
        title: 'Menuju Masa Depan Berkelanjutan',
        description:
            'Mari bersama-sama menciptakan masa depan yang berkelanjutan bagi generasi mendatang!',
      ),
      OnBoardingWidget(
        pageController: _pageController,
        image: Assets.images.birdBottle.svg(),
        title: 'Bersama Membangun Lingkungan',
        description:
            'Saling berbagi kisah, pengalaman, dan inspirasi dalam menjaga lingkungan!',
      ),
      OnBoardingWidget(
        pageController: _pageController,
        image: Assets.images.earth.svg(),
        title: 'Inspirasi Perubahan Positif',
        description:
            'Jadilah sumber inspirasi bagi orang lain untuk melakukan perubahan positif!',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: _currentPage != 2
                ? Padding(
                    padding: const EdgeInsets.all(24),
                    child: GestureDetector(
                      onTap: () {
                        _pageController.animateToPage(
                          2,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.ease,
                        );
                      },
                      child: const Align(
                        alignment: Alignment.centerRight,
                        child: Text('Lewati'),
                      ),
                    ),
                  )
                : const SizedBox(),
          ),
          Expanded(
            flex: 2,
            child: PageView.builder(
              controller: _pageController,
              itemCount: _onBoarding.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return _onBoarding[index];
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: _currentPage != 2
                ? Padding(
                    padding: const EdgeInsets.all(24),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: FloatingActionButton(
                        onPressed: () {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.ease,
                          );
                        },
                        backgroundColor: ColorValues.green02,
                        child: RotatedBox(
                          quarterTurns: 2,
                          child: Assets.icons.arrow.svg(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(24),
                        child: ElevatedButton(
                          onPressed: () {
                            navigatorPushAndRemove(context, const LoginPage());
                          },
                          child: const Text('Mulai Sekarang'),
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
