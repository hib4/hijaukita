import 'package:flutter/material.dart';

class FailurePage extends StatelessWidget {
  const FailurePage({
    Key? key,
    required this.message,
    required this.onPressed,
  }) : super(key: key);

  final String message;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Error: $message',
                  style: textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  '$message, silahkan muat ulang halaman',
                  style: textTheme.bodySmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: onPressed,
                  child: const Text('Muat Ulang'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
