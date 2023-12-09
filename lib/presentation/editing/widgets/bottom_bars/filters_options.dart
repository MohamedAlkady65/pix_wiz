import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pix_wiz/helper/filter_options_values.dart';
import 'package:pix_wiz/logic/filters/filters_cubit.dart';
import 'package:pix_wiz/presentation/editing/widgets/action_option.dart';
import 'package:pix_wiz/presentation/editing/widgets/filters_sliders.dart';

class FiltersOptions extends StatelessWidget {
  const FiltersOptions({super.key});

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
              builder: (context, state) {
                FiltersCubit filtersCubit =
                    BlocProvider.of<FiltersCubit>(context);
                return ListView(
                  scrollDirection: Axis.horizontal,
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
