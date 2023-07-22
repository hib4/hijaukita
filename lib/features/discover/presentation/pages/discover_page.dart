import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/pages/failure/failure_page.dart';
import '../../../../core/theme/color_values.dart';
import '../bloc/discover/discover_bloc.dart';
import '../widgets/bottom_widget.dart';
import '../widgets/category_widget.dart';
import '../widgets/event_widget.dart';
import '../widgets/recent_activity_widget.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    context.read<DiscoverBloc>().add(const ValueDiscoverChangedEvent());
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: ColorValues.grey01,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        bottom: const PreferredSize(
          preferredSize: Size(double.infinity, 76),
          child: BottomWidget(),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<DiscoverBloc>().add(const ValueDiscoverRefreshEvent());
        },
        child: BlocBuilder<DiscoverBloc, DiscoverState>(
          builder: (context, state) {
            if (state is DiscoverFailure) {
              return FailurePage(
                message: state.message,
                onPressed: () {
                  context
                      .read<DiscoverBloc>()
                      .add(const ValueDiscoverRefreshEvent());
                },
              );
            }
            return const SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: Column(
                  children: [
                    EventWidget(),
                    CategoryWidget(),
                    RecentActivityWidget(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
