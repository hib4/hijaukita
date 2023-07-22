import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../../core/theme/color_values.dart';

class ResendingOtp extends StatefulWidget {
  const ResendingOtp({Key? key}) : super(key: key);

  @override
  State<ResendingOtp> createState() => _ResendingOtpState();
}

class _ResendingOtpState extends State<ResendingOtp> {

  final int _duration = 30; // durasi countdown dalam detik
  late Timer _timer; // timer untuk menghitung mundur waktu
  int _remainingTime = 0; // waktu yang tersisa dalam detik
  bool _isCountdownActive = false; // menunjukkan apakah countdown sedang berjalan

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
  void initState() {
    // TODO: implement initState
    super.initState();
    _startTimer();
    _remainingTime = _duration;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Belum menerima kode?",
          style: textTheme.labelMedium!.copyWith(
            color: ColorValues.grey04,
          ),
        ),
        const SizedBox(width: 5,),
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
    );
  }
}

