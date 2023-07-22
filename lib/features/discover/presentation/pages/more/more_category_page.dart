import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/pages/failure/failure_page.dart';
import '../../../../../core/widgets/shimmer/shimmer_widget.dart';
import '../../../../../injection_container.dart';
import '../../bloc/more_category/more_category_bloc.dart';
import '../../widgets/items/category_item.dart';

class MoreCategoryPage extends StatefulWidget {
  const MoreCategoryPage({super.key});

  @override
  State<MoreCategoryPage> createState() => _MoreCategoryPageState();
}

class _MoreCategoryPageState extends State<MoreCategoryPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl.get<MoreCategoryBloc>()..add(GetMoreCategory()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Semua Kategori'),
        ),
        body: BlocBuilder<MoreCategoryBloc, MoreCategoryState>(
          builder: (context, state) {
            if (state is MoreCategoryLoading) {
              return GridView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  mainAxisExtent: 120,
                ),
                itemCount: 9,
                itemBuilder: (context, index) {
                  return const ShimmerWidget(
                    width: 100,
                    height: 120,
                    radius: 16,
                  );
                },
              );
            } else if (state is MoreCategorySuccess) {
              final categories = state.moreCategory.data;
              return GridView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  mainAxisExtent: 120,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return CategoryItem(category: category);
                },
              );
            } else if (state is MoreCategoryFailure) {
              return FailurePage(
                message: state.message,
                onPressed: () {
                  sl.get<MoreCategoryBloc>().add(GetMoreCategory());
                },
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
