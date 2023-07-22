import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/gen/assets.gen.dart';
import '../../../../core/theme/color_values.dart';
import '../../domain/entities/profile.dart';

Widget PointWidget(
  VoidCallback onTap,
  BuildContext context,
  List badges,
) {
  final textTheme = Theme.of(context).textTheme;
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 24),
    child: Container(
      alignment: Alignment.bottomCenter,
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
      decoration: const BoxDecoration(
        color: ColorValues.grey01,
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      child: Column(
        children: [
          Text(
            'Stiker saya',
            style: textTheme.titleMedium!.copyWith(
              color: ColorValues.black01,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            children: [
              for (int i = 0; i < 2; i++)
                Container(
                  padding: const EdgeInsets.all(8),
                  child: badges[i],
                ),
            ],
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(145, 36),
              primary: ColorValues.green02,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
            ),
            child: Text(
              'Tukar Poin',
              style: textTheme.titleMedium!.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
