import 'package:flutter/material.dart';

import '../../../../../core/theme/color_values.dart';

class QuestionWidget extends StatelessWidget {
  const QuestionWidget({Key? key, required this.index, required this.length, required this.question}) : super(key: key);
  final int index;
  final int length;
  final String question;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(17.0),
      decoration: BoxDecoration(
        color: const Color(0xffFFE1E1).withOpacity(0.2),
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Pertanyaan",
                style: textTheme.titleMedium!.copyWith(
                  color: ColorValues.black01,
                ),
              ),
              const SizedBox(width: 5.0,),
              Text(
                "${index + 1}",
                style: textTheme.titleLarge!.copyWith(
                  color: ColorValues.black01,
                ),
              ),
              Text(
                "/${length}",
                style: textTheme.bodySmall!.copyWith(
                  color: ColorValues.black01,
                ),
              ),
            ],
          ),
          Text(
            question,
            style:textTheme.bodySmall!.copyWith(
              color: ColorValues.black01,
            ),
          ),
        ],
      ),
    );
  }

}
