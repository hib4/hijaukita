import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/pages/failure/failure_page.dart';
import '../../../../../core/widgets/activity/activity_item.dart';
import '../../../../../injection_container.dart';
import '../../bloc/more_activity/more_activity_bloc.dart';

class MoreRecentActivityPage extends StatefulWidget {
  const MoreRecentActivityPage({super.key});

  @override
  State<MoreRecentActivityPage> createState() => _MoreRecentActivityPageState();
}

class _MoreRecentActivityPageState extends State<MoreRecentActivityPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl.get<MoreActivityBloc>()..add(GetMoreActivity()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Semua Aktivitas'),
        ),
        body: BlocBuilder<MoreActivityBloc, MoreActivityState>(
          builder: (context, state) {
            if (state is MoreActivityLoading) {
              return ListView.builder(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                itemCount: 5,
                itemBuilder: (_, index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                  );
                },
              );
            } else if (state is MoreActivitySuccess) {
              final activities = state.moreActivity.activities;
              return ListView.builder(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                itemCount: activities.length,
                itemBuilder: (_, index) {
                  final activity = activities[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: ActivityItem(activity: activity),
                  );
                },
              );
            } else if (state is MoreActivityFailure) {
              return FailurePage(
                message: state.message,
                onPressed: () {
                  context.read<MoreActivityBloc>().add(GetMoreActivity());
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
