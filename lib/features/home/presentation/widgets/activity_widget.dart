import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/gen/assets.gen.dart';
import '../../../../core/widgets/activity/activity_item.dart';
import '../../../../core/widgets/shimmer/shimmer_widget.dart';
import '../bloc/home_bloc.dart';

class ActivityWidget extends StatelessWidget {
  const ActivityWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return _buildLoading();
        } else if (state is HomeSuccess) {
          final activities = state.home.data.wishlist;
          if (activities.isNotEmpty) {
            return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: activities.length,
              itemBuilder: (_, index) {
                final activity = activities[index];
                return Container(
                  margin: EdgeInsets.only(
                    bottom: index == activities.length - 1 ? 0 : 16,
                  ),
                  child: ActivityItem(activity: activity),
                );
              },
            );
          }
          return _buildNoActivity(textTheme);
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildLoading() {
    return const Column(
      children: [
        ShimmerWidget(
          width: double.infinity,
          height: 80,
          radius: 16,
        ),
        SizedBox(height: 16),
        ShimmerWidget(
          width: double.infinity,
          height: 80,
          radius: 16,
        ),
      ],
    );
  }

  Widget _buildNoActivity(TextTheme textTheme) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Assets.images.personZoom.svg(),
          const SizedBox(width: 8),
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Aktivitas belum terlihat',
                  style: textTheme.titleSmall,
                ),
                Text(
                  'Temukan sumber pengetahuan yang mendalam tentang lorem',
                  style: textTheme.bodySmall!.copyWith(
                    fontSize: 10,
                  ),
                ),
                const SizedBox(height: 4),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(56, 32),
                    textStyle: textTheme.titleSmall!.copyWith(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                  child: const Text('Cari'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
