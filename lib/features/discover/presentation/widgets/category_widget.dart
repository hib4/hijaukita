import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/route/navigator.dart';
import '../../../../core/theme/color_values.dart';
import '../../../../core/widgets/shimmer/shimmer_widget.dart';
import '../../domain/entities/discover.dart';
import '../bloc/discover/discover_bloc.dart';
import '../pages/more/more_category_page.dart';
import 'items/category_item.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BlocBuilder<DiscoverBloc, DiscoverState>(
      builder: (context, state) {
        if (state is DiscoverInitial || state is DiscoverLoading) {
          return _buildLoading(textTheme);
        } else if (state is DiscoverSuccess) {
          final categories = state.discover.data.subCategories;
          if (categories.isEmpty) return const SizedBox();
          return _buildSuccess(context, textTheme, categories: categories);
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
                  'Kategori',
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
            height: 120,
            child: ListView.builder(
              padding: const EdgeInsets.only(left: 24, right: 8),
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                return const Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: ShimmerWidget(
                    width: 100,
                    height: 120,
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
    required List<SubCategory> categories,
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
                  'Kategori',
                  style: textTheme.titleMedium,
                ),
                GestureDetector(
                  onTap: () {
                    navigatorPush(context, const MoreCategoryPage());
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
            height: 120,
            child: ListView.builder(
              padding: const EdgeInsets.only(left: 24, right: 8),
              scrollDirection: Axis.horizontal,
              itemCount: categories.length > 5 ? 5 : categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: CategoryItem(category: category),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
