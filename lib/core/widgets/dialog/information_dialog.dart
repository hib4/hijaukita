import 'package:flutter/material.dart';

import '../../../../core/gen/assets.gen.dart';
import '../../../../core/route/navigator.dart';
import '../../../../core/theme/color_values.dart';

Widget informationDialog(
  BuildContext context, {
  required String title,
  required String message,
}) {
  final size = MediaQuery.of(context).size;
  final textTheme = Theme.of(context).textTheme;

  return Dialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    child: Container(
      width: size.width * 0.8,
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Assets.icons.information.svg(),
              const SizedBox(width: 8),
              Text(
                title,
                style: textTheme.titleMedium!.copyWith(
                  color: ColorValues.green02,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            message,
            style: textTheme.bodyMedium,
          ),
          const SizedBox(
            height: 16,
          ),
          ElevatedButton(
            onPressed: () {
              navigatorPop(context);
            },
            child: const Text('Mengerti'),
          ),
        ],
      ),
    ),
  );
}
