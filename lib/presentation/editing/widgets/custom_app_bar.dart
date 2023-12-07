import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pix_wiz/helper/edit_mode.dart';
import 'package:pix_wiz/logic/cubit/edit_image_cubit.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("Edit"),
      leading: IconButton(
        iconSize: 32,
        onPressed: () {
          BlocProvider.of<EditImageCubit>(context).goBack(context);
        },
        icon: const Icon(Icons.arrow_back),
      ),
      actions: [
        BlocBuilder<EditImageCubit, EditImageState>(
          buildWhen: (pre, cur) => cur is EditImageChangeMode,
          builder: (context, state) {
            return buildActions(context);
          },
        )
      ],
    );
  }

  Row buildActions(BuildContext context) {
    var currentMode = BlocProvider.of<EditImageCubit>(context).currentMode;
    if (currentMode == EditMode.crop) {
      return buildCropActions(context);
    } else if (currentMode == EditMode.filter) {
      return buildFiltersActions(context);
    } else {
      return const Row(
        children: [],
      );
    }
  }

  Row buildCropActions(BuildContext context) {
    return Row(
      children: [
        IconButton(
            iconSize: 32,
            onPressed: () {
              BlocProvider.of<EditImageCubit>(context).resetCropping();
            },
            icon: const Icon(Icons.restore)),
        IconButton(iconSize: 32, onPressed: () {}, icon: const Icon(Icons.done))
      ],
    );
  }

  Row buildFiltersActions(BuildContext context) {
    return Row(
      children: [
        IconButton(
            iconSize: 32, onPressed: () {}, icon: const Icon(Icons.restore)),
        IconButton(iconSize: 32, onPressed: () {}, icon: const Icon(Icons.done))
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
