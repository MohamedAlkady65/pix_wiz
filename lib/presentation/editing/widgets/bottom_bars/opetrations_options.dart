import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pix_wiz/helper/action_types.dart';
import 'package:pix_wiz/logic/cubit/edit_image_cubit.dart';
import 'package:pix_wiz/presentation/editing/widgets/action_option.dart';

class OpetrationsOptions extends StatelessWidget {
  const OpetrationsOptions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      color: const Color(0xFF2A2A2A),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          ActionOption(
              text: "Original",
              action: () {
                BlocProvider.of<EditImageCubit>(context)
                    .filterAction(action: ActionTypes.original);
              }),
          ActionOption(
              text: "Gray",
              action: () {
                BlocProvider.of<EditImageCubit>(context)
                    .filterAction(action: ActionTypes.grayScale);
              }),
          ActionOption(
              text: "Sobel",
              action: () {
                BlocProvider.of<EditImageCubit>(context)
                    .filterAction(action: ActionTypes.sobel);
              }),
          ActionOption(
              text: "Threashold",
              action: () {
                BlocProvider.of<EditImageCubit>(context)
                    .filterAction(action: ActionTypes.threashold);
              }),
          ActionOption(
              text: "Edge Glow",
              action: () {
                BlocProvider.of<EditImageCubit>(context)
                    .filterAction(action: ActionTypes.edgeGlow);
              }),
        ],
      ),
    );
  }
}
