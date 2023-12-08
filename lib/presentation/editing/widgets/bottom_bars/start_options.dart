import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pix_wiz/helper/edit_mode.dart';
import 'package:pix_wiz/logic/cubit/edit_image_cubit.dart';
import 'package:pix_wiz/presentation/editing/widgets/action_option.dart';

class StartOptions extends StatelessWidget {
  const StartOptions({super.key});

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
              text: "Opetrations",
              action: () {
                BlocProvider.of<EditImageCubit>(context).currentMode =
                    EditMode.opetrations;
              }),
          ActionOption(
              text: "Crop",
              action: () {
                BlocProvider.of<EditImageCubit>(context).currentMode =
                    EditMode.crop;
              }),
          ActionOption(
              text: "Filters",
              action: () {
                BlocProvider.of<EditImageCubit>(context).currentMode =
                    EditMode.filters;
              }),
        ],
      ),
    );
  }
}
