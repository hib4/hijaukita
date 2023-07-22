import 'package:flutter/material.dart';

import '../../../../core/route/navigator.dart';
import '../../../../core/theme/color_values.dart';
import '../../domain/entities/detail_category.dart';
import '../pages/more/more_related_event_page.dart';
import 'items/event_item.dart';

class RelatedChallengeWidget extends StatelessWidget {
  const RelatedChallengeWidget({super.key, required this.events});

  final List<Event> events;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.symmetric(vertical: 16),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Event Terkait',
                  style: textTheme.titleMedium,
                ),
                GestureDetector(
                  onTap: () {
                    navigatorPush(context, const MoreRelatedEventPage());
                  },
                  child: Text(
                    'Lihat Semua',
                    style: textTheme.bodySmall!.copyWith(
                      color: ColorValues.green02,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 160,
            child: ListView.builder(
              padding: const EdgeInsets.only(left: 24, right: 8),
              scrollDirection: Axis.horizontal,
              itemCount: events.length,
              itemBuilder: (context, index) {
                final event = events[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: EventItem(event: event),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
