import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hijaukita/core/widgets/bottom_navigation/bottom_navigation.dart';
import 'package:hijaukita/core/widgets/snackbar/snackbar_item.dart';
import 'package:hijaukita/features/home/presentation/pages/home_page.dart';

import '../../../../../core/gen/assets.gen.dart';
import '../../../../../core/route/navigator.dart';
import '../../bloc/otp/otp_bloc.dart';
import '../../widgets/btn_verifikasi.dart';
import '../../widgets/otp_pages_widget.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({Key? key}) : super(key: key);

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Kode Verifikasi'),
        leading: IconButton(
          onPressed: () => navigatorPop(context),
          icon: Assets.icons.arrow.svg(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: OtpWidget(
                  controller: _otpController,
                ),
              ),
              BlocConsumer<OtpBloc, OtpState>(
                listener: (context, state) {
                  if (state is OtpSuccess) {
                    navigatorPushAndRemove(context, const BottomNavigation());
                  } else if (state is OtpFailure) {
                    showSnackBar(context, title: state.message);
                  }
                },
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: () {
                      context.read<OtpBloc>().add(
                            SendOtpEvent(otp: _otpController.text),
                          );
                    },
                    child: state is OtpLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text('Verifikasi'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
