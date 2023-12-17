import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pix_wiz/Core/components/action_option.dart';
import 'package:pix_wiz/Features/crop/logic/crop/crop_cubit.dart';

class CropBottomBar extends StatelessWidget {
  const CropBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      color: const Color(0xFF2A2A2A),
      child: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
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
        ),
      ),
    );
  }
}
