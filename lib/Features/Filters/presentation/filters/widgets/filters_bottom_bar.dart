import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pix_wiz/Core/helper/filter_options_values.dart';
import 'package:pix_wiz/Features/filters/logic/filters/filters_cubit.dart';
import 'package:pix_wiz/Core/components/action_option.dart';
import 'package:pix_wiz/Features/filters/presentation/filters/widgets/filters_sliders.dart';

class FiltersBottomBar extends StatelessWidget {
  const FiltersBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const FiltersSliders(),
          Container(
            height: 80,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            color: const Color(0xFF2A2A2A),
            child: BlocBuilder<FiltersCubit, FiltersState>(
              buildWhen: (pre, cur) => cur is FiltersChangeChoice,
              builder: (context, state) {
                FiltersCubit filtersCubit =
                    BlocProvider.of<FiltersCubit>(context);
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ActionOption(
                        text: "Brightness",
                        icon: Icons.brightness_6_outlined,
                        active: filtersCubit.currentChoice ==
                            FilterOptionsChoices.brightness,
                        action: () {
                          filtersCubit.currentChoice =
                              FilterOptionsChoices.brightness;
                        }),
                    ActionOption(
                        text: "Saturation",
                        icon: Icons.brightness_6_outlined,
                        active: filtersCubit.currentChoice ==
                            FilterOptionsChoices.saturation,
                        action: () {
                          filtersCubit.currentChoice =
                              FilterOptionsChoices.saturation;
                        }),
                    ActionOption(
                        text: "Contrast",
                        icon: Icons.brightness_6_outlined,
                        active: filtersCubit.currentChoice ==
                            FilterOptionsChoices.contrast,
                        action: () {
                          filtersCubit.currentChoice =
                              FilterOptionsChoices.contrast;
                        }),
                    ActionOption(
                        text: "Hue",
                        icon: Icons.brightness_6_outlined,
                        active: filtersCubit.currentChoice ==
                            FilterOptionsChoices.hue,
                        action: () {
                          filtersCubit.currentChoice = FilterOptionsChoices.hue;
                        }),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
