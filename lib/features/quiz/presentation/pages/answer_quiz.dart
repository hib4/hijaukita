import 'package:flutter/material.dart';
import '../../../../core/theme/color_values.dart';

class ResultQuizPage extends StatelessWidget {
  const ResultQuizPage({
    Key? key,
    required this.buttonStatusList,
    required this.index,
    required this.i,
    required this.selectedAnswer,
    required this.answerQuizText,
    required this.isCoorect
  }) : super(key: key);

  final List<bool> buttonStatusList;
  final int index;
  final int i;
  final String selectedAnswer;
  final String answerQuizText;
  final String isCoorect;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Visibility(
      visible: buttonStatusList[i],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Jawaban yang benar',
            style: textTheme.titleMedium,
          ),
          const SizedBox(height: 10.0),
          Text(
            answerQuizText,
            style: textTheme.bodySmall!.copyWith(
              color: ColorValues.grey04,
            ),
          ),
          const SizedBox(height: 10.0),
          Row(
            children: [
              Text(
                'Jawaban anda :',
                style: textTheme.bodySmall,
              ),
              const SizedBox(width: 10.0),
              Text(
                buttonStatusList[i]
                    ? selectedAnswer == isCoorect
                    ? 'Benar'
                    : 'Salah'
                    : 'Salah',
                style: textTheme.bodySmall!.copyWith(
                  color: buttonStatusList[i]
                      ? selectedAnswer == isCoorect
                      ? ColorValues.green02
                      : Colors.red
                      : Colors.red,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20.0),
        ],
      ),
    );
  }
}
