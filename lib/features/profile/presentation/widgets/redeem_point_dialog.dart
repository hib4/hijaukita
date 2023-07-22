import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hijaukita/core/route/navigator.dart';

import '../../../../core/gen/assets.gen.dart';
import '../../domain/entities/profile.dart';

class RedeemPointDialog extends StatefulWidget {
  const RedeemPointDialog({
    super.key,
    required this.badges,
    required this.point,
  });

  final List badges;
  final String point;

  @override
  State<RedeemPointDialog> createState() => _RedeemPointDialogState();
}

class _RedeemPointDialogState extends State<RedeemPointDialog> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    return Dialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        width: size.width * 0.8,
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  navigatorPop(context);
                },
                child: const Icon(
                  Icons.close,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Poin Saya',
              style: textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Assets.icons.coin.svg(),
                const SizedBox(width: 8),
                Text(
                  widget.point,
                  style: textTheme.titleMedium!.copyWith(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Wrap(
              children: [
                for (var badge in widget.badges)
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        badge,
                        const SizedBox(height: 8),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Assets.icons.coin.svg(
                              width: 16,
                              height: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '100',
                              style: textTheme.titleSmall!.copyWith(
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                navigatorPop(context);
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
