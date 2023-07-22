import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

import '../../theme/color_values.dart';

final defaultPinTheme = PinTheme(
  width: 56,
  height: 56,
  textStyle: GoogleFonts.nunito(
    fontSize: 20,
    color: Colors.black,
    fontWeight: FontWeight.w600,
  ),
  decoration: BoxDecoration(
    color: ColorValues.grey01,
    borderRadius: BorderRadius.circular(16),
  ),
);

final focusedPinTheme = defaultPinTheme.copyDecorationWith(
  border: Border.all(
    color: ColorValues.green02,
  ),
);

final submittedPinTheme = defaultPinTheme.copyWith(
  decoration: defaultPinTheme.decoration!.copyWith(),
);

class CustomPinPut extends StatelessWidget {
  const CustomPinPut({super.key, required this.controller, this.validator});

  final TextEditingController controller;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Pinput(
      controller: controller,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: focusedPinTheme,
      submittedPinTheme: submittedPinTheme,
      validator: validator,
    );
  }
}
