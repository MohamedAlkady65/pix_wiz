import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pix_wiz/Features/operations/logic/operations_types.dart';
import 'package:pix_wiz/Core/components/action_option.dart';
import 'package:pix_wiz/Features/operations/logic/operations/operations_cubit.dart';

class OperationsBottomBar extends StatelessWidget {
  const OperationsBottomBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final operationsCubit = BlocProvider.of<OperationsCubit>(context);
    return BlocBuilder<OperationsCubit, OperationsState>(
      buildWhen: (pre, cur) => cur is OperationsChangeAction,
      builder: (context, state) {
        return Container(
          height: 80,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          color: const Color(0xFF2A2A2A),
          child: ListView(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            children: [
              action(
                  title: "Original",
                  type: OperationsType.original,
                  operationsCubit: operationsCubit),
              action(
                  title: "Gray",
                  type: OperationsType.grayScale,
                  operationsCubit: operationsCubit),
              action(
                  title: "Sobel",
                  type: OperationsType.sobel,
                  operationsCubit: operationsCubit),
              action(
                  title: "Threashold",
                  type: OperationsType.threashold,
                  operationsCubit: operationsCubit),
              action(
                  title: "Edge Glow",
                  type: OperationsType.edgeGlow,
                  operationsCubit: operationsCubit),
              action(
                  title: "Billboard",
                  type: OperationsType.billboard,
                  operationsCubit: operationsCubit),
              action(
                  title: "Bump",
                  type: OperationsType.bumpToNormal,
                  operationsCubit: operationsCubit),
              action(
                  title: "Chromatic",
                  type: OperationsType.chromaticAberration,
                  operationsCubit: operationsCubit),
              action(
                  title: "Emboss",
                  type: OperationsType.emboss,
                  operationsCubit: operationsCubit),
              action(
                  title: "Blur",
                  type: OperationsType.gaussianBlur,
                  operationsCubit: operationsCubit),
              action(
                  title: "Invert",
                  type: OperationsType.invert,
                  operationsCubit: operationsCubit),
              action(
                  title: "Noise",
                  type: OperationsType.noise,
                  operationsCubit: operationsCubit),
              action(
                  title: "Pixelate",
                  type: OperationsType.pixelate,
                  operationsCubit: operationsCubit),
              action(
                  title: "Sketch",
                  type: OperationsType.sketch,
                  operationsCubit: operationsCubit),
            ],
          ),
        );
      },
    );
  }

  ActionOption action(
      {required String title,
      required OperationsType type,
      required OperationsCubit operationsCubit}) {
    return ActionOption(
        text: title,
        active: operationsCubit.currentAction == type,
        action: () {
          operationsCubit.filterAction(action: type);
        });
  }
}
