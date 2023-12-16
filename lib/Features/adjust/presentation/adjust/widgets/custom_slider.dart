import 'package:flutter/material.dart';
import 'package:pix_wiz/Core/colors.dart';

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
          thumbColor: kPrimaryColor,
          activeColor: kPrimaryColor,
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
