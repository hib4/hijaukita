import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../theme/color_values.dart';
import '../snackbar/snackbar_item.dart';

class BulletList extends StatelessWidget {
  const BulletList({super.key, required this.text, this.isHyperLink = false});

  final String text;
  final bool isHyperLink;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        const SizedBox(width: 8),
        Text('\u2022', style: textTheme.bodySmall),
        const SizedBox(width: 8),
        Expanded(
          child: isHyperLink
              ? GestureDetector(
                  onTap: () async {
                    try {
                      await _launchUrl(Uri.parse(text));
                    } on Exception catch (e) {
                      showSnackBar(context, title: e.toString());
                    }
                  },
                  child: Text(
                    text,
                    style: textTheme.bodySmall!.copyWith(
                      color: ColorValues.green02,
                      decoration: TextDecoration.underline,
                      decorationColor: ColorValues.green02,
                    ),
                  ),
                )
              : Text(
                  text,
                  style: textTheme.bodySmall,
                ),
        ),
      ],
    );
  }

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }
}
