import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pix_wiz/Features/crop/logic/crop/crop_cubit.dart';

class CropAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CropAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("Crop & Rotate"),
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
                onPressed: BlocProvider.of<CropCubit>(context).resetCropping,
                icon: const Icon(Icons.restore)),
            IconButton(
                iconSize: 32,
                onPressed: () async {
                  await BlocProvider.of<CropCubit>(context).croppingDone();
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
