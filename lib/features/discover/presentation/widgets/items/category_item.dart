import 'package:flutter/material.dart';

import '../../../../../core/route/navigator.dart';
import '../../../../../core/theme/color_values.dart';
import '../../pages/detail_category_page.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key, required this.category});

  final category;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () {
        navigatorPush(context, DetailCategoryPage(id: category.id));
      },
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _backgroundColorMap[category.categoryId],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: _colorsMap[category.categoryId]!,
                ),
              ),
            ),
            Text(
              category.name,
              style: textTheme.labelMedium,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

final Map<String, Color> _backgroundColorMap = {
  '1': ColorValues.subGreen,
  '2': ColorValues.subPink,
  '3': ColorValues.subBlue,
};

final Map<String, List<Color>> _colorsMap = {
  '1': ColorValues.gradient01,
  '2': ColorValues.gradient02,
  '3': ColorValues.gradient03,
};
