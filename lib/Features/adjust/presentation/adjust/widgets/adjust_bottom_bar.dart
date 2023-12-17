import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pix_wiz/Features/adjust/logic/adjust_options_values.dart';
import 'package:pix_wiz/Features/adjust/logic/adjust/adjust_cubit.dart';
import 'package:pix_wiz/Features/adjust/presentation/adjust/widgets/adjust_sliders.dart';
import 'package:pix_wiz/Core/components/action_option.dart';

class AdjustBottomBar extends StatelessWidget {
  const AdjustBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const AdjustSliders(),
          Container(
            height: 80,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            color: const Color(0xFF2A2A2A),
            child: BlocBuilder<AdjustCubit, AdjustState>(
              buildWhen: (pre, cur) => cur is AdjustChangeChoice,
              builder: (context, state) {
                AdjustCubit filtersCubit =
                    BlocProvider.of<AdjustCubit>(context);
                return Center(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ActionOption(
                            text: "Brightness",
                            icon: Icons.brightness_6_outlined,
                            active: filtersCubit.currentChoice ==
                                AdjustOptionsChoices.brightness,
                            action: () {
                              filtersCubit.currentChoice =
                                  AdjustOptionsChoices.brightness;
                            }),
                        ActionOption(
                            text: "Contrast",
                            icon: Icons.contrast,
                            active: filtersCubit.currentChoice ==
                                AdjustOptionsChoices.contrast,
                            action: () {
                              filtersCubit.currentChoice =
                                  AdjustOptionsChoices.contrast;
                            }),
                        ActionOption(
                            text: "Saturation",
                            icon: Icons.gradient,
                            active: filtersCubit.currentChoice ==
                                AdjustOptionsChoices.saturation,
                            action: () {
                              filtersCubit.currentChoice =
                                  AdjustOptionsChoices.saturation;
                            }),
                        ActionOption(
                            text: "Hue",
                            icon: Icons.invert_colors,
                            active: filtersCubit.currentChoice ==
                                AdjustOptionsChoices.hue,
                            action: () {
                              filtersCubit.currentChoice =
                                  AdjustOptionsChoices.hue;
                            }),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
