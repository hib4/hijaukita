import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/pages/failure/failure_page.dart';
import '../../../../../core/widgets/shimmer/shimmer_widget.dart';
import '../../../../../injection_container.dart';
import '../../bloc/more_event/more_event_bloc.dart';
import '../../widgets/items/event_item.dart';

class MoreEventPage extends StatefulWidget {
  const MoreEventPage({super.key});

  @override
  State<MoreEventPage> createState() => _MoreEventPageState();
}

class _MoreEventPageState extends State<MoreEventPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl.get<MoreEventBloc>()..add(GetMoreEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Semua Event'),
        ),
        body: BlocBuilder<MoreEventBloc, MoreEventState>(
          builder: (context, state) {
            if (state is MoreEventLoading) {
              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                itemCount: 5,
                itemBuilder: (_, index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: const ShimmerWidget(
                      width: 264,
                      height: 160,
                      radius: 16,
                    ),
                  );
                },
              );
            } else if (state is MoreEventSuccess) {
              final events = state.moreEvent.events;
              return ListView.builder(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                itemCount: events.length,
                itemBuilder: (_, index) {
                  final event = events[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: EventItem(event: event),
                  );
                },
              );
            } else if (state is MoreEventFailure) {
              return FailurePage(
                message: state.message,
                onPressed: () {
                  sl.get<MoreEventBloc>().add(GetMoreEvent());
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
