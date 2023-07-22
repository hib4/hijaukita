import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/color_values.dart';

Widget cardLeaderboard(String name, int index, String score, String image,BuildContext context) {
  final textTheme = Theme.of(context).textTheme;
  return Container(
    padding: const EdgeInsets.all(10.0),
    margin: const EdgeInsets.only(left: 5, right: 5, top: 10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 1,
          blurRadius: 1,
          offset: const Offset(0, 1),
        ),
      ],
    ),
    child: Row(
      children: [
        Container(
          width: 20,
          height: 20,
          margin: const EdgeInsets.only(
              left: 16, right: 16),
          decoration: BoxDecoration(
            color: ColorValues.grey02,
            borderRadius:
            BorderRadius.circular(20.0),
          ),
          child: Center(
            child: Text(
              '${index + 1}',
              style: textTheme.labelMedium!
                  .copyWith(
                  color:
                  ColorValues.green02),
            ),
          ),
        ),
        CircleAvatar(
          radius: 15,
          backgroundImage: CachedNetworkImageProvider(image),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: textTheme.labelMedium!
                    .copyWith(
                  color: ColorValues.black01,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
        Text(
          score,
          style:
          textTheme.labelMedium!.copyWith(
            color: ColorValues.black01,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    ),
  );
}