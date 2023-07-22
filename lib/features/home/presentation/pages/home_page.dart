import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/gen/assets.gen.dart';
import '../../../../core/pages/failure/failure_page.dart';
import '../../../../core/theme/color_values.dart';
import '../../../../core/widgets/shimmer/shimmer_widget.dart';
import '../bloc/home_bloc.dart';
import '../widgets/activity_widget.dart';
import '../widgets/consultation_widget.dart';
import '../widgets/window_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(GetHomeEvent());
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final textTheme = Theme.of(context).textTheme;

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeFailure) {
          return FailurePage(
            message: state.message,
            onPressed: () {},
          );
        }
        return Scaffold(
          body: SafeArea(
            child: RefreshIndicator(
              onRefresh: () async {
                context.read<HomeBloc>().add(GetHomeEvent());
              },
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Hai,', style: textTheme.bodySmall),
                              BlocBuilder<HomeBloc, HomeState>(
                                builder: (context, state) {
                                  if (state is HomeLoading) {
                                    return const ShimmerWidget(
                                      width: 80,
                                      height: 24,
                                      radius: 8,
                                    );
                                  } else if (state is HomeSuccess) {
                                    final initial = state.home.data.user.name;
                                    final first = initial
                                        .split(' ')
                                        .first
                                        .substring(0, 1);
                                    final last =
                                        initial.split(' ').first.substring(1);
                                    return Text(
                                      '$first$last',
                                      style: textTheme.titleMedium,
                                      maxLines: 1,
                                    );
                                  }
                                  return const Text('-');
                                },
                              ),
                            ],
                          ),
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 16,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Assets.icons.bell.svg(),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const WindowWidget(),
                      const SizedBox(height: 16),
                      Text('BuGuru AI', style: textTheme.titleLarge),
                      const SizedBox(height: 8),
                      const ConsultationWidget(),
                      const SizedBox(height: 16),
                      Text('Aktivitas saya', style: textTheme.titleLarge),
                      const SizedBox(height: 8),
                      const ActivityWidget(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
