import 'package:flutter/material.dart';

import '../../theme/color_values.dart';

class GradientText extends StatelessWidget {
  const GradientText({super.key, required this.text, required this.category});

  final String text;
  final int category;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => _gradient().createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: textTheme.labelMedium),
    );
  }

  Gradient _gradient() {
    switch (category) {
      case 1:
        return const LinearGradient(colors: ColorValues.gradient01);
      case 2:
        return const LinearGradient(colors: ColorValues.gradient02);
      case 3:
        return const LinearGradient(colors: ColorValues.gradient03);
      default:
        return const LinearGradient(colors: ColorValues.gradient01);
    }
  }
}
