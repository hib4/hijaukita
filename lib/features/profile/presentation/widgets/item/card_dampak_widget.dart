import 'package:flutter/material.dart';

import '../../../../../core/theme/color_values.dart';

Widget CardDampak(
  BuildContext context,
  Color color,
  List<Color> colorCircle,
  String title,
  String subtitle,
) {
  final textTheme = Theme.of(context).textTheme;
  return Container(
    width: 92,
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(16.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: colorCircle,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: textTheme.titleMedium,
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: textTheme.bodySmall!.copyWith(
            color: ColorValues.black01,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    ),
  );
}
