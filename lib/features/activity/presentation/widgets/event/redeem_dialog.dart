import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/route/navigator.dart';
import '../../../../../core/theme/color_values.dart';
import '../../../../../core/widgets/pinput/custom_pinput.dart';
import '../../../../../injection_container.dart';
import '../../bloc/redeem_code/redeem_code_bloc.dart';

class RedeemDialog extends StatefulWidget {
  const RedeemDialog({super.key, required this.id});

  final int id;

  @override
  State<RedeemDialog> createState() => _RedeemDialogState();
}

class _RedeemDialogState extends State<RedeemDialog> {
  final _pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    return BlocProvider(
      create: (_) => sl.get<RedeemCodeBloc>(),
      child: Dialog(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          width: size.width * 0.8,
          height: 324,
          padding: const EdgeInsets.all(24),
          child: BlocBuilder<RedeemCodeBloc, RedeemCodeState>(
            builder: (context, state) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Masukkan kode',
                        style: textTheme.titleMedium!.copyWith(),
                      ),
                      GestureDetector(
                        onTap: () {
                          navigatorPop(context);
                        },
                        child: const Icon(
                          Icons.close,
                          color: ColorValues.grey04,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      state is RedeemCodeFailure
                          ? Text(
                              state.message,
                              style: textTheme.bodySmall!.copyWith(
                                color: Colors.red,
                              ),
                            )
                          : const SizedBox(),
                      CustomPinPut(controller: _pinController),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      sl.get<RedeemCodeBloc>().add(PostRedeemCodeEvent(
                          id: widget.id, code: _pinController.text));
                    },
                    child: state is RedeemCodeLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text('Submit'),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
