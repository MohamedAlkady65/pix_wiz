import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pix_wiz/Features/filters/logic/filters/filters_cubit.dart';

class FiltersAppbar extends StatelessWidget implements PreferredSizeWidget {
  const FiltersAppbar({
    super.key,
  });

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
        Row(
          children: [
            IconButton(
                iconSize: 32,
                onPressed: BlocProvider.of<FiltersCubit>(context).resetFilters,
                icon: const Icon(Icons.restore)),
            IconButton(
                iconSize: 32,
                onPressed: BlocProvider.of<FiltersCubit>(context).filtersDone,
                icon: const Icon(Icons.done))
          ],
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
