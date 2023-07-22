import 'package:flutter/material.dart';

import '../../../../core/theme/color_values.dart';
import '../../../auth/presentation/pages/otp/otp_page.dart';

class ButtonVerifikasi extends StatelessWidget {
  const ButtonVerifikasi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => const OtpPage())),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            color: ColorValues.green02,
            borderRadius: BorderRadius.circular(16.0)),
        child: const Center(
          child: Text(
            "Verifikasi",
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
