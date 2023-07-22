import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/route/navigator.dart';
import '../../../../core/theme/color_values.dart';
import '../../../../core/widgets/shimmer/shimmer_widget.dart';
import '../../domain/entities/discover.dart';
import '../bloc/discover/discover_bloc.dart';
import '../pages/more/more_event_page.dart';
import 'items/event_item.dart';

class EventWidget extends StatelessWidget {
  const EventWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BlocBuilder<DiscoverBloc, DiscoverState>(
      builder: (context, state) {
        if (state is DiscoverInitial || state is DiscoverLoading) {
          return _buildLoading(textTheme);
        } else if (state is DiscoverSuccess) {
          final data = state.discover.data;
          if (data.events.isEmpty &&
              data.subCategories.isEmpty &&
              data.activities.isEmpty) {
            return SizedBox(
              height: 300,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Center(
                  child: Text(
                    'Data tidak ditemukan :(',
                    style: textTheme.bodyMedium,
                  ),
                ),
              ),
            );
          }
          if (data.events.isEmpty) return const SizedBox();
          return _buildSuccess(context, textTheme, events: data.events);
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildLoading(TextTheme textTheme) {
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
                  'Event',
                  style: textTheme.titleMedium,
                ),
                Text(
                  'Lihat Semua',
                  style: textTheme.bodySmall!.copyWith(
                    color: ColorValues.green02,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 160,
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.only(left: 24, right: 8),
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                return const Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: ShimmerWidget(
                    width: 264,
                    height: 160,
                    radius: 16,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccess(
    BuildContext context,
    TextTheme textTheme, {
    required List<Event> events,
  }) {
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
                  'Event Populer',
                  style: textTheme.titleMedium,
                ),
                GestureDetector(
                  onTap: () {
                    navigatorPush(context, const MoreEventPage());
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
              itemCount: events.length > 5 ? 5 : events.length,
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
