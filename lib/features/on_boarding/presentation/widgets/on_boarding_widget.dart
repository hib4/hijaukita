import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingWidget extends StatelessWidget {
  const OnBoardingWidget({
    super.key,
    required this.pageController,
    required this.image,
    required this.title,
    required this.description,
  });

  final PageController pageController;
  final SvgPicture image;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          image,
          const SizedBox(height: 16),
          SmoothPageIndicator(
            controller: pageController,
            count: 3,
            effect: const WormEffect(
              dotColor: Colors.grey,
              activeDotColor: Colors.black,
              dotHeight: 8,
              dotWidth: 8,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          Text(
            description,
            textAlign: TextAlign.center,
            style: textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
