import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pix_wiz/logic/cubit/edit_image_cubit.dart';
import 'package:pix_wiz/presentation/editing/widgets/action_option.dart';

class EditOptions extends StatelessWidget {
  const EditOptions({
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
              text: "Gray",
              action: () {
                BlocProvider.of<EditImageCubit>(context).editAction();
              }),
        ],
      ),
    );
  }
}
