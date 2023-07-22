import 'package:flutter/material.dart';

import '../../gen/assets.gen.dart';
import '../../route/navigator.dart';
import '../../widgets/bottom_navigation/bottom_navigation.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Assets.images.personSuccess.svg(),
            const SizedBox(height: 16),
            Text(
              'Dampak kamu berarti!',
              style: textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Kamu telah memberikan dampak yang baik bagi lingkungan dan sekitar, jangan berhenti dan lakukan lebih banyak lagi!',
              style: textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                navigatorPushAndRemove(
                  context,
                  const BottomNavigation(),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(148, 48),
              ),
              child: const Text('Kembali'),
            ),
          ],
        ),
      ),
    );
  }
}
