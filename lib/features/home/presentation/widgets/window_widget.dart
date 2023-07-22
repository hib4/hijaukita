import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/gen/assets.gen.dart';
import '../../../../core/theme/color_values.dart';
import '../bloc/home_bloc.dart';
import 'information_widget.dart';

class WindowWidget extends StatelessWidget {
  const WindowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Stack(
        children: [
          Assets.window.background.svg(
            width: size.width,
            fit: BoxFit.cover,
          ),
          BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeSuccess) {
                final point = int.parse(state.home.data.user.point);
                return Positioned.fill(
                  child: Stack(
                    children: [
                      Visibility(
                        visible: point < 100,
                        child: Positioned(
                          right: 6,
                          top: 140,
                          child: Assets.window.paper.svg(),
                        ),
                      ),
                      Visibility(
                        visible: point < 200,
                        child: Positioned(
                          left: 80,
                          top: 220,
                          child: Assets.window.bottle.svg(),
                        ),
                      ),
                      Visibility(
                        visible: point < 400,
                        child: Positioned(
                          left: 30,
                          bottom: 135,
                          child: Assets.window.trash.svg(),
                        ),
                      ),
                      Visibility(
                        visible: point < 50,
                        child: Positioned(
                          right: 36,
                          bottom: 115,
                          child: Assets.window.smallPaper.svg(),
                        ),
                      ),
                      Visibility(
                        visible: point < 300,
                        child: Positioned(
                          left: 36,
                          bottom: 20,
                          child: Assets.window.waveBottle.svg(),
                        ),
                      ),
                      const InformationWidget(),
                    ],
                  ),
                );
              }
              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }
}
