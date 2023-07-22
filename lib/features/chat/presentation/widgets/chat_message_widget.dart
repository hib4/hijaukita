import 'package:flutter/material.dart';

import '../../../../core/constant/constant.dart';
import '../../../../core/gen/assets.gen.dart';
import '../../../../core/theme/color_values.dart';
import '../../domain/entities/conversation.dart';

class ChatMessageWidget extends StatelessWidget {
  const ChatMessageWidget({
    Key? key,
    required this.conversation,
  }) : super(key: key);

  final Conversation conversation;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isAnswer = conversation.isAnswer;

    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.only(
          left: 8,
          right: 8,
          top: isAnswer ? 12 : 0,
          bottom: isAnswer ? 24 : 0,
        ),
        child: Align(
          alignment: isAnswer ? Alignment.topLeft : Alignment.topRight,
          child: Container(
            margin: isAnswer
                ? const EdgeInsets.only(right: 50)
                : const EdgeInsets.only(left: 50),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(16),
                topRight: const Radius.circular(16),
                bottomLeft: isAnswer ? Radius.zero : const Radius.circular(16),
                bottomRight: isAnswer ? const Radius.circular(16) : Radius.zero,
              ),
              color: isAnswer ? Colors.grey.shade200 : ColorValues.green02,
            ),
            child: conversation.text != typingMessage
                ? Text(
                    conversation.text,
                    style: textTheme.labelLarge!.copyWith(
                      color:
                          conversation.isAnswer ? Colors.black : Colors.white,
                    ),
                  )
                : Assets.lottie.typing.lottie(width: 24),
          ),
        ),
      ),
    );
  }
}
