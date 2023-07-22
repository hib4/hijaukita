import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/pages/failure/failure_page.dart';
import '../../../../core/theme/color_values.dart';
import '../../../../core/widgets/activity/activity_item.dart';
import '../../../../injection_container.dart';
import '../bloc/detail_category/detail_category_bloc.dart';
import '../widgets/related_event_widget.dart';

class DetailCategoryPage extends StatefulWidget {
  const DetailCategoryPage({super.key, required this.id});

  final int id;

  @override
  State<DetailCategoryPage> createState() => _DetailCategoryPageState();
}

class _DetailCategoryPageState extends State<DetailCategoryPage> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BlocProvider(
      create: (_) => sl.get<DetailCategoryBloc>()
        ..add(GetDetailCategoryEvent(id: widget.id)),
      child: Scaffold(
        backgroundColor: ColorValues.grey01,
        appBar: AppBar(
          title: const Text('Detail Kategori'),
        ),
        body: BlocBuilder<DetailCategoryBloc, DetailCategoryState>(
          builder: (context, state) {
            if (state is DetailCategoryLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is DetailCategorySuccess) {
              final data = state.detailCategory.data;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                      color: Colors.white,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: _colorMap[int.parse(data.categoryId)],
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data.name,
                              style: textTheme.titleMedium,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              data.name,
                              style: textTheme.bodySmall,
                            ),
                            const SizedBox(height: 8),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Wrap(
                                children: [
                                  for (final i in data.susdevGoals)
                                    Container(
                                      margin: const EdgeInsets.only(right: 4),
                                      child: CachedNetworkImage(
                                        imageUrl: i.imageUrl,
                                        width: 28,
                                        height: 28,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    data.challanges.isEmpty
                        ? const SizedBox()
                        : RelatedChallengeWidget(events: data.challanges),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 16),
                      padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Semua Aktivitas',
                            style: textTheme.titleMedium,
                          ),
                          const SizedBox(height: 16),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: data.activities.length,
                            itemBuilder: (context, index) {
                              final activity = data.activities[index];
                              return Container(
                                margin: const EdgeInsets.only(bottom: 16),
                                child: ActivityItem(activity: activity),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              );
            } else if (state is DetailCategoryFailure) {
              return FailurePage(
                message: state.message,
                onPressed: () {},
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}

final Map<int, Color> _colorMap = {
  1: ColorValues.subGreen,
  2: ColorValues.subPink,
  3: ColorValues.subBlue,
};
