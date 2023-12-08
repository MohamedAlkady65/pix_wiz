import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pix_wiz/logic/crop/crop_cubit.dart';
import 'package:pix_wiz/presentation/editing/widgets/action_option.dart';

class ExtendedOptions extends StatelessWidget {
  const ExtendedOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      color: const Color(0xFF2A2A2A),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ActionOption(
              icon: Icons.rotate_right,
              action: () {
                BlocProvider.of<CropCubit>(context).rotateRight();
              }),
          ActionOption(
              icon: Icons.flip,
              action: () {
                BlocProvider.of<CropCubit>(context).flip();
              }),
          ActionOption(
              icon: Icons.rotate_left,
              action: () {
                BlocProvider.of<CropCubit>(context).rotateLeft();
              }),
        ],
      ),
    );
  }
}
