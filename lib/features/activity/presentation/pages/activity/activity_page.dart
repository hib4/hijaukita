import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/gen/assets.gen.dart';
import '../../../../../core/pages/failure/failure_page.dart';
import '../../../../../core/route/navigator.dart';
import '../../../../../core/theme/color_values.dart';
import '../../../../../core/widgets/bullet_list/bullet_list.dart';
import '../../../../../core/widgets/text/gradient_text.dart';
import '../../../../../injection_container.dart';
import '../../../../quiz/presentation/pages/quiz.dart';
import '../../bloc/activity/activity_bloc.dart';
import '../../bloc/wishlist/wishlist_bloc.dart';
import '../../widgets/activity/wishlist_widget.dart';
import '../upload_photo/upload_photo_page.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key, required this.id});

  final int id;

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => sl.get<ActivityBloc>()
            ..add(
              GetActivityEvent(id: widget.id),
            ),
        ),
        BlocProvider(
          create: (context) => sl.get<WishlistBloc>(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Aktivitas'),
        ),
        body: BlocBuilder<ActivityBloc, ActivityState>(
          builder: (context, state) {
            if (state is ActivityLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ActivitySuccess) {
              final data = state.activity.data;
              return Stack(
                children: [
                  SingleChildScrollView(
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CachedNetworkImage(
                              imageUrl: data.imageUrl,
                              width: double.infinity,
                              height: size.height * 0.25,
                              fit: BoxFit.cover,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(24),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GradientText(
                                    text: data.subCategory.name,
                                    category:
                                        int.parse(data.subCategory.categoryId),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    data.name,
                                    style: textTheme.titleMedium,
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'Dalam mendukung SDGs',
                                    style: textTheme.titleMedium,
                                  ),
                                  const SizedBox(height: 4),
                                  Wrap(
                                    children: [
                                      for (final i
                                          in data.subCategory.susdevGoals)
                                        Container(
                                          margin:
                                              const EdgeInsets.only(right: 4),
                                          child: CachedNetworkImage(
                                            imageUrl: i.imageUrl,
                                            width: 28,
                                            height: 28,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'Ketentuan',
                                    style: textTheme.titleMedium,
                                  ),
                                  const SizedBox(height: 4),
                                  for (final i in data.provision)
                                    BulletList(text: i.provision),
                                  const SizedBox(height: 16),
                                  Text(
                                    'Deskripsi',
                                    style: textTheme.titleMedium,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    data.description,
                                    style: textTheme.bodySmall,
                                  ),
                                  const SizedBox(height: 16),
                                  data.isDone
                                      ? Text(
                                          '*Anda telah menyelesaikan aktivitas ini, anda bisa mengulang lagi besok hari.',
                                          style: textTheme.bodySmall!.copyWith(
                                              color: ColorValues.green02),
                                        )
                                      : const SizedBox(),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          top: size.height * 0.25 - 28,
                          right: 24,
                          child: WishlistWidget(
                            id: data.id,
                            isAdded: data.isWishlist,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Assets.icons.coin.svg(),
                                const SizedBox(width: 4),
                                Text(
                                  data.reward,
                                  style: textTheme.titleLarge,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: data.isDone
                                  ? null
                                  : () {
                                      navigatorPush(
                                        context,
                                        data.activityType == 'photo'
                                            ? UploadPhotoPage(
                                                activityId: data.id,
                                                category: data.label,
                                              )
                                            : QuizPage(id: data.id),
                                      );
                                    },
                              child: Text(
                                data.activityType == 'photo'
                                    ? 'Unggah foto'
                                    : 'Ikuti kuis',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else if (state is ActivityFailure) {
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
