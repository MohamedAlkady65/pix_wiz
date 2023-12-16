import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pix_wiz/Features/adjust/logic/adjust/adjust_cubit.dart';

class AdjustAppbar extends StatelessWidget implements PreferredSizeWidget {
  const AdjustAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("Adjust"),
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
                onPressed: BlocProvider.of<AdjustCubit>(context).adjustReset,
                icon: const Icon(Icons.restore)),
            IconButton(
                iconSize: 32,
                onPressed: () async {
                  await BlocProvider.of<AdjustCubit>(context).adjustDone();
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pop();
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
