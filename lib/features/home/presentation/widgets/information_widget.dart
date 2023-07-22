import 'package:flutter/material.dart';

import '../../../../core/theme/color_values.dart';

enum Status { idle, first, second, third }

class InformationWidget extends StatefulWidget {
  const InformationWidget({super.key});

  @override
  State<InformationWidget> createState() => _InformationWidgetState();
}

class _InformationWidgetState extends State<InformationWidget> {
  final ValueNotifier<Status> _status = ValueNotifier<Status>(Status.idle);
  String _text = 'Lihatlah pemandagan di jendela ini, terdapat banyak sampah.';

  Future _initialize() async {
    await Future.delayed(const Duration(seconds: 1));
    _status.value = Status.first;
  }

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  @override
  void dispose() {
    _status.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Align(
      alignment: Alignment.bottomCenter,
      child: ValueListenableBuilder(
        valueListenable: _status,
        builder: (_, value, __) {
          return AnimatedOpacity(
            opacity: value == Status.first || value == Status.second ? 1 : 0,
            duration: const Duration(milliseconds: 500),
            child: Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 24,
              ),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Informasi',
                              style: textTheme.titleSmall,
                            ),
                            Text(
                              _text,
                              style: textTheme.bodySmall,
                            )
                          ],
                        ),
                      ),
                      ClipOval(
                        child: Material(
                          color: ColorValues.green02,
                          child: InkWell(
                            onTap: () => _changeStatus(value),
                            child: SizedBox(
                              width: 38,
                              height: 38,
                              child: Center(
                                child: value == Status.second ||
                                        value == Status.third
                                    ? const Icon(
                                        Icons.done_rounded,
                                        color: Colors.white,
                                      )
                                    : const Icon(
                                        Icons.arrow_forward_rounded,
                                        color: Colors.white,
                                      ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _changeStatus(Status status) async {
    if (status == Status.first) {
      _status.value = Status.idle;
      await Future.delayed(const Duration(milliseconds: 500));
      _text = 'Bantu kami menguranginya dengan cara menyelesaikan aktivitas.';
      _status.value = Status.second;
    } else {
      _status.value = Status.third;
    }
  }
}
