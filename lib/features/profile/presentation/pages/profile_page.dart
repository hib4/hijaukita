import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hijaukita/core/pages/failure/failure_page.dart';
import 'package:hijaukita/core/route/navigator.dart';
import 'package:hijaukita/features/profile/presentation/pages/settings/settings.dart';
import '../../../../core/gen/assets.gen.dart';
import '../../../../core/theme/color_values.dart';
import '../../../../injection_container.dart';
import '../bloc/profile_bloc.dart';
import '../widgets/tab_text_profile_widget.dart';
import 'impact.dart';
import 'history.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final textTheme = Theme.of(context).textTheme;

    return BlocProvider(
      create: (_) => sl.get<ProfileBloc>()..add(GetProfileEvent()),
      child: Scaffold(
        body: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ProfileSuccess) {
              final user = state.profile.data.user;
              final data = state.profile.data;
              return SafeArea(
                child: RefreshIndicator(
                  onRefresh: () async {
                    context.read<ProfileBloc>().add(GetProfileEvent());
                  },
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 48,
                                backgroundColor: ColorValues.grey02,
                                backgroundImage:
                                    CachedNetworkImageProvider(user.avatarUrl),
                              ),
                              const SizedBox(
                                width: 18,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    user.name,
                                    style: textTheme.titleMedium!.copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    user.email,
                                    style: textTheme.labelMedium!.copyWith(
                                      color: ColorValues.grey04,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: [
                                      Assets.icons.coin.svg(
                                        width: 16,
                                        height: 16,
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        user.point,
                                        style: textTheme.labelMedium!.copyWith(
                                          color: ColorValues.black01,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: () {
                                  navigatorPush(context, const SettingsPage());
                                },
                                child: Assets.icons.settings.svg(
                                  alignment: Alignment.topRight,
                                  width: 24,
                                  height: 24,
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        DefaultTabController(
                          length: 2, // length of tabs
                          initialIndex: 0,
                          child: Column(
                            children: <Widget>[
                              TabBar(
                                padding:
                                    const EdgeInsets.fromLTRB(24, 0, 24, 0),
                                indicatorPadding: EdgeInsets.zero,
                                labelPadding: const EdgeInsets.symmetric(
                                  horizontal: 40.0,
                                ),
                                labelColor: ColorValues.green02,
                                unselectedLabelColor: ColorValues.grey04,
                                dividerColor: Colors.transparent,
                                //custom indicator
                                tabs: [
                                  tabTextProfile('Dampak', context),
                                  tabTextProfile('Histori', context),
                                ],
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.68,
                                child: TabBarView(
                                  children: <Widget>[
                                    ImpactPage(
                                      doneActivities: data.doneActivities,
                                      listBadges: data.listBadges,
                                      myBadges: data.myBadges,
                                      point: data.user.point,
                                    ),
                                    const HistoryPage(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else if (state is ProfileFailure) {
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
