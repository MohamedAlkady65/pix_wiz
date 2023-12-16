import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pix_wiz/Features/adjust/logic/adjust_options_values.dart';
import 'package:pix_wiz/Features/adjust/logic/adjust/adjust_cubit.dart';
import 'package:pix_wiz/Features/adjust/presentation/adjust/widgets/custom_slider.dart';

class AdjustSliders extends StatelessWidget {
  const AdjustSliders({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdjustCubit, AdjustState>(
      buildWhen: (pre, cur) => cur is AdjustChangeChoice,
      builder: (context, state) {
        var currentChoice = BlocProvider.of<AdjustCubit>(context).currentChoice;
        if (currentChoice == AdjustOptionsChoices.brightness) {
          return brightness(context);
        }
        if (currentChoice == AdjustOptionsChoices.saturation) {
          return saturation(context);
        }
        if (currentChoice == AdjustOptionsChoices.contrast) {
          return contrast(context);
        }
        if (currentChoice == AdjustOptionsChoices.hue) {
          return hue(context);
        } else {
          return const SizedBox();
        }
      },
    );
  }

  CustomSlider saturation(BuildContext context) {
    return CustomSlider(
      key: UniqueKey(),
      value: BlocProvider.of<AdjustCubit>(context)
              .adjustOptionsValues
              .saturationValue ??
          0,
      min: 0,
      max: 100,
      onChanged: (value) {
        BlocProvider.of<AdjustCubit>(context).changeSaturation(value);
      },
    );
  }

  CustomSlider brightness(BuildContext context) {
    return CustomSlider(
      key: UniqueKey(),
      value: BlocProvider.of<AdjustCubit>(context)
              .adjustOptionsValues
              .brightnessValue ??
          0,
      min: -100,
      max: 100,
      onChanged: (value) {
        BlocProvider.of<AdjustCubit>(context).changeBrightness(value);
      },
    );
  }

  CustomSlider hue(BuildContext context) {
    return CustomSlider(
      key: UniqueKey(),
      value:
          BlocProvider.of<AdjustCubit>(context).adjustOptionsValues.hueValue ??
              0,
      min: 0,
      max: 100,
      onChanged: (value) {
        BlocProvider.of<AdjustCubit>(context).changeHue(value);
      },
    );
  }

  CustomSlider contrast(BuildContext context) {
    return CustomSlider(
      key: UniqueKey(),
      value: BlocProvider.of<AdjustCubit>(context)
              .adjustOptionsValues
              .contrastValue ??
          0,
      min: -100,
      max: 100,
      onChanged: (value) {
        BlocProvider.of<AdjustCubit>(context).changeContrast(value);
      },
    );
  }
}
