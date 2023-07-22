import 'package:flutter/material.dart';

import '../../gen/assets.gen.dart';

class IconLocation extends StatelessWidget {
  const IconLocation({
    super.key,
    required this.location,
    this.isDetail = false,
  });

  final String location;
  final bool isDetail;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        Assets.icons.location.svg(),
        const SizedBox(width: 4),
        Text(
          location,
          style: isDetail
              ? textTheme.bodySmall
              : textTheme.bodySmall!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
        ),
      ],
    );
  }
}
