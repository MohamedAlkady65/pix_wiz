import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pix_wiz/logic/cubit/edit_image_cubit.dart';

class ImageView extends StatelessWidget {
  const ImageView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Align(
            alignment: Alignment.topCenter,
            child: BlocBuilder<EditImageCubit, EditImageState>(
              builder: (context, state) {
                if (state is EditImageResult) {
                  return Image.memory(
                    state.image,
                    fit: BoxFit.cover,
                  );
                } else {
                  return const SizedBox();
                }
              },
            )),
      ),
    );
  }
}
