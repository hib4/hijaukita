import 'package:flutter/material.dart';

import '../../../../core/gen/assets.gen.dart';
import '../../../../core/route/navigator.dart';
import '../../../../core/theme/color_values.dart';

class ConsultationWidget extends StatelessWidget {
  const ConsultationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: ColorValues.subGreen,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Assets.images.womanGlobe.svg(),
          const SizedBox(width: 4),
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sumber pengetahuan',
                  style: textTheme.titleSmall,
                ),
                Text(
                  'Temukan sumber pengetahuan yang mendalam tentang sustainability.',
                  style: textTheme.bodySmall!.copyWith(
                    fontSize: 10,
                  ),
                ),
                const SizedBox(height: 4),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(92, 32),
                    textStyle: textTheme.titleSmall!.copyWith(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                  child: const Text('Tanya'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
