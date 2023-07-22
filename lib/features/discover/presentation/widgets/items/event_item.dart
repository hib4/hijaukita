import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../core/gen/assets.gen.dart';
import '../../../../../core/route/navigator.dart';
import '../../../../../core/widgets/icon/icon_location.dart';
import '../../../../activity/presentation/pages/event/event_page.dart';

class EventItem extends StatelessWidget {
  const EventItem({super.key, required this.event});

  final event;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () {
        navigatorPush(context, EventPage(id: event.id));
      },
      child: Container(
        width: 264,
        height: 160,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: CachedNetworkImageProvider(event.imageUrl),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: [
                Colors.black.withOpacity(0.35),
                Colors.transparent,
              ],
              begin: const Alignment(1, 1),
              end: const Alignment(1, -1),
            ),
          ),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.name,
                  style: textTheme.titleSmall!.copyWith(
                    color: Colors.white,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  event.description,
                  style: textTheme.bodySmall!.copyWith(
                    color: Colors.white,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Row(
                      children: [
                        Assets.icons.coin.svg(
                          width: 16,
                          height: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          event.reward,
                          style: textTheme.bodySmall!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 8),
                    IconLocation(location: event.regency),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
