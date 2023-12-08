import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pix_wiz/logic/cubit/edit_image_cubit.dart';
import 'package:pix_wiz/presentation/editing/widgets/action_option.dart';

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
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                ActionOption(
                    text: "Brightness",
                    icon: Icons.brightness_6_outlined,
                    action: () {}),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FiltersSliders extends StatelessWidget {
  const FiltersSliders({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        color: const Color(0xFF2A2A2A),
        child: BlocBuilder<EditImageCubit, EditImageState>(
          builder: (context, state) {
            return CustomSlider(
              value: 0,
              min: -2.5,
              max: 2.5,
              onChanged: (value) {
                BlocProvider.of<EditImageCubit>(context)
                    .filterOptionsValues
                    .brightnessValue = value;
                print(value);
                BlocProvider.of<EditImageCubit>(context)
                    .emit(EditImageResult());
              },
            );
          },
        ));
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
    return Slider(
        value: changedvalue,
        max: widget.max,
        min: widget.min,
        onChanged: (v) {
          setState(() {
            changedvalue = v;
          });
          widget.onChanged(v);
        });
  }
}
