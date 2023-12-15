import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pix_wiz/Features/edit/logic/edit/edit_image_cubit.dart';

class EditingAppBar extends StatelessWidget implements PreferredSizeWidget {
  const EditingAppBar({
    super.key,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("Edit"),
      leading: IconButton(
        iconSize: 32,
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(Icons.arrow_back),
      ),
      actions: [
        IconButton(
            iconSize: 32,
            onPressed:
                BlocProvider.of<EditImageCubit>(context).restoreOriginalImage,
            icon: const Icon(Icons.restore)),
        IconButton(iconSize: 32, onPressed: () {}, icon: const Icon(Icons.done))
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
