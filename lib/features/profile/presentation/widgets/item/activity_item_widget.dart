import 'package:flutter/material.dart';

import '../../../../../core/gen/assets.gen.dart';
import '../../../../../core/theme/color_values.dart';
import '../../../../../core/widgets/text/gradient_text.dart';

Widget activityItem(
    BuildContext context,
    String title,
    String category,
    String subtitle,
    String point,
    ) {
  final textTheme = Theme.of(context).textTheme;
  return IntrinsicHeight(
    child: Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Assets.images.trash.path),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        const SizedBox(width: 12),
        Flexible(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GradientText(
                text: title,
                category: 1,
              ),
              Text(
                subtitle,
                style: textTheme.titleMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                children: [
                  Assets.icons.coin.svg(width: 16, height: 16),
                  const SizedBox(width: 4),
                  Text(
                    point,
                    style: textTheme.bodySmall!
                        .copyWith(color: ColorValues.green02),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
