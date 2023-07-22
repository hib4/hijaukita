import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/route/navigator.dart';
import '../../../../core/theme/color_values.dart';
import '../../../../core/widgets/activity/activity_item.dart';
import '../../../../core/widgets/shimmer/shimmer_widget.dart';
import '../../domain/entities/discover.dart';
import '../bloc/discover/discover_bloc.dart';
import '../pages/more/more_recent_activity_page.dart';

class RecentActivityWidget extends StatelessWidget {
  const RecentActivityWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BlocBuilder<DiscoverBloc, DiscoverState>(
      builder: (context, state) {
        if (state is DiscoverInitial || state is DiscoverLoading) {
          return _buildLoading(textTheme);
        } else if (state is DiscoverSuccess) {
          final activities = state.discover.data.activities;
          if (activities.isEmpty) return const SizedBox();
          return _buildSuccess(context, textTheme, activities: activities);
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildLoading(TextTheme textTheme) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
      color: Colors.white,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Aktivitas',
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
          const SizedBox(height: 16),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 5,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                child: const ShimmerWidget(
                  width: double.infinity,
                  height: 80,
                  radius: 16,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSuccess(
    BuildContext context,
    TextTheme textTheme, {
    required List<Activity> activities,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
      color: Colors.white,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Aktivitas',
                style: textTheme.titleMedium,
              ),
              GestureDetector(
                onTap: () {
                  navigatorPush(context, const MoreRecentActivityPage());
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
          const SizedBox(height: 16),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: activities.length > 5 ? 5 : activities.length,
            itemBuilder: (context, index) {
              final activity = activities[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                child: ActivityItem(activity: activity),
              );
            },
          ),
        ],
      ),
    );
  }
}
