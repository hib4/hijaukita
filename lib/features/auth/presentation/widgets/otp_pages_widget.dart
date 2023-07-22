import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hijaukita/core/widgets/pinput/custom_pinput.dart';

import '../../../../core/theme/color_values.dart';
import 'item/text_form_field_otp_widget.dart';

class OtpWidget extends StatefulWidget {
  const OtpWidget({Key? key, required this.controller}) : super(key: key);

  final TextEditingController controller;

  @override
  State<OtpWidget> createState() => _OtpWidgetState();
}

class _OtpWidgetState extends State<OtpWidget> {
  final int _duration = 60;
  late Timer _timer;
  int _remainingTime = 0;
  bool _isCountdownActive = false;

  @override
  void initState() {
    super.initState();
    _remainingTime = _duration;
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _isCountdownActive = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _remainingTime--;
      });

      if (_remainingTime == 0) {
        _timer.cancel();
        _isCountdownActive = false;
      }
    });
  }

  String _formatDuration(int seconds) {
    Duration duration = Duration(seconds: seconds);
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(30));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(30));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Periksa email anda",
          style: textTheme.titleLarge!.copyWith(
            color: ColorValues.black01,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          "Kami telah mengirimkan kode verifikasi ke email sdjddvdf@gmail.com",
          style: textTheme.labelMedium!.copyWith(
            color: const Color(0xff9B9B9B),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 24,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: CustomPinPut(
            controller: widget.controller,
          ),
        ),
        const SizedBox(
          height: 28,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Belum menerima kode?",
              style: textTheme.labelMedium!.copyWith(
                color: ColorValues.grey04,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            _isCountdownActive
                ? Text(
                    _formatDuration(_remainingTime),
                    style: textTheme.labelMedium!.copyWith(
                      color: ColorValues.green02,
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      _remainingTime = _duration;
                      _startTimer();
                    },
                    child: Text(
                      "Kirim ulang",
                      style: textTheme.labelMedium!.copyWith(
                        color: ColorValues.green02,
                      ),
                    ),
                  )
          ],
        ),
      ],
    );
  }
}
