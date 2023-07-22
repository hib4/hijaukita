// import 'package:flutter/material.dart';
//
// import '../../../../../core/theme/color_values.dart';
// import '../../../domain/entities/quiz_example.dart';
// import '../../pages/answer_quiz.dart';
//
// class AnswerWidget extends StatefulWidget {
//   const AnswerWidget({Key? key, required this.answered, required this.buttonStatusList, required this.index, required this.length, required this.answerQuiz}) : super(key: key);
//   final bool answered;
//   final List<bool> buttonStatusList;
//   final int index;
//   final int length;
//   final String answerQuiz;
//
//   @override
//   State<AnswerWidget> createState() => _AnswerWidgetState();
// }
//
// class _AnswerWidgetState extends State<AnswerWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return  Container(
//       padding: const EdgeInsets.all(24.0),
//       child: Wrap(
//         children: [
//           for (int i = 0; i < widget.length; i++)
//             widget.answered
//                 ? ResultQuizPage(
//                 buttonStatusList: widget.buttonStatusList,
//                 index: widget.index,
//                 i: i,
//               answerQuizText: widget.answerQuiz,
//               selectedAnswer: widget.,
//                 )
//                 : Container(
//               width: double.infinity,
//               height: 46.0,
//               margin: const EdgeInsets.only(bottom: 20.0),
//               child: btnOption(context, widget.buttonStatusList, i, widget.index),
//             )
//         ],
//       ),
//     );
//   }
//
//   Widget btnOption(
//       BuildContext context,
//       List<bool> buttonStatusList,
//       int i,
//       int index,
//       ) {
//     final textTheme = Theme.of(context).textTheme;
//     return RawMaterialButton(
//       onPressed: () {
//         setState(() {
//           for (int j = 0; j < buttonStatusList.length; j++) {
//             buttonStatusList[j] = false;
//           }
//           buttonStatusList[i] = true;
//         });
//       },
//       fillColor: buttonStatusList[i] ? ColorValues.green02 : ColorValues.grey01,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16.0),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           Radio(
//             value: buttonStatusList[i],
//             groupValue: true,
//             onChanged: (value) {
//               setState(() {
//                 for (int j = 0; j < buttonStatusList.length; j++) {
//                   buttonStatusList[j] = false;
//                 }
//                 buttonStatusList[i] = true;
//               });
//             },
//             activeColor: Colors.white,
//             fillColor: MaterialStateProperty.resolveWith<Color?>(
//                   (states) {
//                 if (states.contains(MaterialState.selected)) {
//                   return Colors.white;
//                 } else {
//                   return ColorValues.green02;
//                 }
//               },
//             ),
//           ),
//           Text(
//             questions[index].answers!.keys.toList()[i],
//             style: textTheme.titleMedium!.copyWith(
//               color: buttonStatusList[i] ? Colors.white : ColorValues.black01,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
//
