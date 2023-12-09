
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pix_wiz/helper/filter_options_values.dart';
import 'package:pix_wiz/logic/cubit/edit_image_cubit.dart';
import 'package:pix_wiz/logic/filters/filters_cubit.dart';

class FiltersSliders extends StatelessWidget {
  const FiltersSliders({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FiltersCubit, FiltersState>(
      builder: (context, state) {
        var currentChoice =
            BlocProvider.of<FiltersCubit>(context).currentChoice;
        if (currentChoice == FilterOptionsChoices.none) {
          return const SizedBox();
        }
        if (currentChoice == FilterOptionsChoices.brightness) {
          return CustomSlider(
            value: 0,
            min: -2.5,
            max: 2.5,
            onChanged: (value) {
              BlocProvider.of<FiltersCubit>(context)
                  .filterOptionsValues
                  .brightnessValue = value;
              BlocProvider.of<EditImageCubit>(context).emitResultState();
            },
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}

class CustomSlider extends StatefulWidget {
  const CustomSlider({
    super.key,
    required this.value,
    required this.onChanged,
    required this.min,
    required this.max,
  });
  final double value;
  final double min;
  final double max;
  final void Function(double) onChanged;
  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  late double changedvalue;
  @override
  void initState() {
    changedvalue = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      color: const Color(0xFF2A2A2A),
      child: Slider(
          value: changedvalue,
          max: widget.max,
          min: widget.min,
          onChanged: (v) {
            setState(() {
              changedvalue = v;
            });
            widget.onChanged(v);
          }),
    );
  }
}
