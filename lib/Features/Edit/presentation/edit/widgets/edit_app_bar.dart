import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pix_wiz/Core/helper/dialog.dart';
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
        onPressed: () async {
          final res = await showCustomDialog(
              context: context,
              title: "Exit",
              content: "Discard changes and exit");
          if (res == true) {
            // ignore: use_build_context_synchronously
            Navigator.of(context).pop();
          }
        },
        icon: const Icon(Icons.arrow_back),
      ),
      actions: [
        IconButton(
            iconSize: 32,
            onPressed: () {
              BlocProvider.of<EditImageCubit>(context)
                  .restoreOriginalImage(context);
            },
            icon: const Icon(Icons.restore)),
        IconButton(
            iconSize: 32,
            onPressed: () {
              BlocProvider.of<EditImageCubit>(context).saveToGallery(context);
            },
            icon: const Icon(Icons.save_alt))
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
