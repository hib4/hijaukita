import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/color_values.dart';
import '../bloc/chat_bloc.dart';

class ChatTextField extends StatelessWidget {
  const ChatTextField({
    super.key,
    required this.controller,
    required this.onSubmitted,
  });

  final TextEditingController controller;
  final void Function() onSubmitted;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return TextFormField(
      controller: controller,
      autocorrect: true,
      enableSuggestions: true,
      style: textTheme.labelLarge,
      decoration: InputDecoration(
        hintText: 'Tulis sesuatu...',
        hintStyle: textTheme.bodyMedium,
        filled: true,
        fillColor: ColorValues.grey01,
        suffixIcon: BlocBuilder<ChatBloc, ChatState>(
          builder: (context, state) {
            return IconButton(
              onPressed: state is! ChatLoading ? onSubmitted : null,
              icon: const Icon(
                Icons.send_rounded,
                color: ColorValues.green02,
              ),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            );
          },
        ),
        contentPadding: const EdgeInsets.all(16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            width: 2,
            color: ColorValues.green03,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            width: 2,
            color: Colors.red,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            width: 2,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
