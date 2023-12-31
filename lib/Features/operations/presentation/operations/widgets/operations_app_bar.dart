import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pix_wiz/Features/operations/logic/operations/operations_cubit.dart';

class OperationsAppbar extends StatelessWidget implements PreferredSizeWidget {
  const OperationsAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("Filter"),
      leading: IconButton(
        iconSize: 32,
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(Icons.arrow_back),
      ),
      actions: [
        Row(
          children: [
            IconButton(
                iconSize: 32,
                onPressed: () {
                  BlocProvider.of<OperationsCubit>(context).operationDone();
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.done))
          ],
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
