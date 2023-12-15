import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pix_wiz/Core/helper/filter_options_values.dart';
import 'package:pix_wiz/Features/filters/logic/filters/filters_cubit.dart';
import 'package:pix_wiz/Features/filters/presentation/filters/widgets/custom_slider.dart';

class FiltersSliders extends StatelessWidget {
  const FiltersSliders({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FiltersCubit, FiltersState>(
      buildWhen: (pre, cur) => cur is FiltersChangeChoice,
      builder: (context, state) {
        var currentChoice =
            BlocProvider.of<FiltersCubit>(context).currentChoice;
        if (currentChoice == FilterOptionsChoices.none) {
          return const SizedBox();
        }
        if (currentChoice == FilterOptionsChoices.brightness) {
          return CustomSlider(
            key: UniqueKey(),
            value: BlocProvider.of<FiltersCubit>(context)
                    .filterOptionsValues
                    .brightnessValue ??
                0,
            min: -100,
            max: 100,
            onChanged: (value) {
              BlocProvider.of<FiltersCubit>(context).changeBrightness(value);
            },
          );
        }

        if (currentChoice == FilterOptionsChoices.saturation) {
          return CustomSlider(
            key: UniqueKey(),
            value: BlocProvider.of<FiltersCubit>(context)
                    .filterOptionsValues
                    .saturationValue ??
                0,
            min: 0,
            max: 100,
            onChanged: (value) {
              BlocProvider.of<FiltersCubit>(context).changeSaturation(value);
            },
          );
        }

        if (currentChoice == FilterOptionsChoices.contrast) {
          return CustomSlider(
            key: UniqueKey(),
            value: BlocProvider.of<FiltersCubit>(context)
                    .filterOptionsValues
                    .contrastValue ??
                0,
            min: -100,
            max: 100,
            onChanged: (value) {
              BlocProvider.of<FiltersCubit>(context).changeContrast(value);
            },
          );
        }

        if (currentChoice == FilterOptionsChoices.hue) {
          return CustomSlider(
            key: UniqueKey(),
            value: BlocProvider.of<FiltersCubit>(context)
                    .filterOptionsValues
                    .hueValue ??
                0,
            min: 0,
            max: 100,
            onChanged: (value) {
              BlocProvider.of<FiltersCubit>(context).changeHue(value);
            },
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
