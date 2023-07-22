import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../core/theme/color_values.dart';

Widget buildTextFormFieldOtpWidget(BuildContext context, TextEditingController controller, FocusNode focusNode) {
  final textTheme = Theme.of(context).textTheme;
  return Container(
    height: 49,
    width: 49,
    decoration: BoxDecoration(
      color: ColorValues.grey01,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: focusNode.hasFocus ? ColorValues.green02 : ColorValues.grey01,
        width: 1,
      ),
    ),
    child: TextFormField(
      controller: controller,
      focusNode: focusNode,
      onChanged: (value) {
        if (value.length == 1) {
          FocusScope.of(context).nextFocus();
        }
      },
      style: textTheme.titleMedium!.copyWith(
        color: ColorValues.black01,
        fontWeight: FontWeight.w700,
      ),
      decoration: const InputDecoration(
        border: InputBorder.none,
      ),
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      inputFormatters: [
        LengthLimitingTextInputFormatter(1),
        FilteringTextInputFormatter.digitsOnly
      ],
    ),
  );
}