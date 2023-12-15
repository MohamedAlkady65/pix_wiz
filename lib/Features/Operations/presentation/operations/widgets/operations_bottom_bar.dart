import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pix_wiz/Core/helper/action_types.dart';
import 'package:pix_wiz/Core/components/action_option.dart';
import 'package:pix_wiz/Features/operations/logic/operations/operations_cubit.dart';

class OperationsBottomBar extends StatelessWidget {
  const OperationsBottomBar({
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
                BlocProvider.of<OperationsCubit>(context)
                    .filterAction(action: ActionTypes.original);
              }),
          ActionOption(
              text: "Gray",
              action: () {
                BlocProvider.of<OperationsCubit>(context)
                    .filterAction(action: ActionTypes.grayScale);
              }),
          ActionOption(
              text: "Sobel",
              action: () {
                BlocProvider.of<OperationsCubit>(context)
                    .filterAction(action: ActionTypes.sobel);
              }),
          ActionOption(
              text: "Threashold",
              action: () {
                BlocProvider.of<OperationsCubit>(context)
                    .filterAction(action: ActionTypes.threashold);
              }),
          ActionOption(
              text: "Edge Glow",
              action: () {
                BlocProvider.of<OperationsCubit>(context)
                    .filterAction(action: ActionTypes.edgeGlow);
              }),
        ],
      ),
    );
  }
}
