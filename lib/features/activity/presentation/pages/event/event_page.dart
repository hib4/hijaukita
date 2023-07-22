import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../../core/gen/assets.gen.dart';
import '../../../../../core/pages/failure/failure_page.dart';
import '../../../../../core/theme/color_values.dart';
import '../../../../../core/widgets/bullet_list/bullet_list.dart';
import '../../../../../core/widgets/icon/icon_location.dart';
import '../../widgets/event/redeem_dialog.dart';
import '../../../../../core/widgets/text/gradient_text.dart';
import '../../../../../injection_container.dart';
import '../../bloc/event/event_bloc.dart';

class EventPage extends StatefulWidget {
  const EventPage({super.key, required this.id});

  final int id;

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    return BlocProvider(
      create: (_) => sl.get<EventBloc>()..add(GetEventEvent(id: widget.id)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Event'),
        ),
        body: BlocBuilder<EventBloc, EventState>(
          builder: (context, state) {
            if (state is EventLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is EventSuccess) {
              final data = state.event.data;
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
                                    category: int.parse(data.subCategoryId),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    data.name,
                                    style: textTheme.titleMedium,
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Text(
                                        _convertDate(
                                            data.dateStart, data.dateEnd),
                                        style: textTheme.bodySmall,
                                      ),
                                      const SizedBox(width: 4),
                                      const Icon(
                                        Icons.circle,
                                        size: 8,
                                        color: ColorValues.grey01,
                                      ),
                                      const SizedBox(width: 4),
                                      IconLocation(
                                        location: data.regency,
                                        isDetail: true,
                                      ),
                                    ],
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
                                    'Link Pendaftaran',
                                    style: textTheme.titleMedium,
                                  ),
                                  const SizedBox(height: 4),
                                  BulletList(
                                    text: data.registrationLink,
                                    isHyperLink: true,
                                  ),
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
                                ],
                              ),
                            ),
                          ],
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
                              onPressed: () => showDialog(
                                context: context,
                                builder: (context) => RedeemDialog(id: data.id),
                              ),
                              child: const Text('Tukar kode'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else if (state is EventFailure) {
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

  String _convertDate(DateTime dateStart, DateTime dateEnd) {
    final startDay = DateFormat('d').format(dateStart);
    final endDay = DateFormat('d').format(dateEnd);
    final startMonthYear = DateFormat('MMMM yyyy', 'id_ID').format(dateStart);
    final endMonthYear = DateFormat('MMMM yyyy', 'id_ID').format(dateEnd);

    if (dateEnd.isAfter(dateStart) && dateStart.month != dateEnd.month) {
      return '$startDay $startMonthYear - $endDay $endMonthYear';
    } else {
      return '$startDay-$endDay $endMonthYear';
    }
  }
}
