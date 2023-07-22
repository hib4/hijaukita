import 'package:flutter/material.dart';

import '../../../../core/gen/assets.gen.dart';
import '../../../../core/theme/color_values.dart';

class DiscoverTextField extends StatefulWidget {
  const DiscoverTextField({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  final TextEditingController controller;
  final Function(String value) onChanged;

  @override
  State<DiscoverTextField> createState() => _DiscoverTextFieldState();
}

class _DiscoverTextFieldState extends State<DiscoverTextField> {
  final _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return WillPopScope(
      onWillPop: () async {
        if (_focusNode.hasFocus) {
          _focusNode.unfocus();
          return false;
        }
        return true;
      },
      child: TextFormField(
        controller: widget.controller,
        autocorrect: true,
        enableSuggestions: true,
        focusNode: _focusNode,
        style: textTheme.labelLarge,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          hintText: 'Cari sesuatu...',
          hintStyle: textTheme.bodyMedium,
          filled: true,
          fillColor: ColorValues.grey01,
          suffixIcon: IconButton(
            onPressed: () {},
            icon: Assets.icons.search.svg(),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
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
      ),
    );
  }
}
