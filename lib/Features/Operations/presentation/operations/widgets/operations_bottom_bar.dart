import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pix_wiz/Core/helper/operations_types.dart';
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
            children: [
              ActionOption(
                  text: "Original",
                  active:
                      operationsCubit.currentAction == OperationsTypes.original,
                  action: () {
                    operationsCubit.filterAction(
                        action: OperationsTypes.original);
                  }),
              ActionOption(
                  text: "Gray",
                  active: operationsCubit.currentAction ==
                      OperationsTypes.grayScale,
                  action: () {
                    operationsCubit.filterAction(
                        action: OperationsTypes.grayScale);
                  }),
              ActionOption(
                  text: "Sobel",
                  active:
                      operationsCubit.currentAction == OperationsTypes.sobel,
                  action: () {
                    operationsCubit.filterAction(action: OperationsTypes.sobel);
                  }),
              ActionOption(
                  text: "Threashold",
                  active: operationsCubit.currentAction ==
                      OperationsTypes.threashold,
                  action: () {
                    operationsCubit.filterAction(
                        action: OperationsTypes.threashold);
                  }),
              ActionOption(
                  text: "Edge Glow",
                  active:
                      operationsCubit.currentAction == OperationsTypes.edgeGlow,
                  action: () {
                    operationsCubit.filterAction(
                        action: OperationsTypes.edgeGlow);
                  }),
            ],
          ),
        );
      },
    );
  }
}
