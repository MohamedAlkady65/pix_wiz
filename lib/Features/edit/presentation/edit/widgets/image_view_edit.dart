import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pix_wiz/Core/colors.dart';
import 'package:pix_wiz/Features/edit/logic/edit/edit_image_cubit.dart';

class ImageViewEdit extends StatelessWidget {
  const ImageViewEdit({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Align(
          alignment: Alignment.center,
          child: BlocBuilder<EditImageCubit, EditImageState>(
            builder: (context, state) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  ExtendedImage.memory(
                    BlocProvider.of<EditImageCubit>(context).imageBytes!,
                    fit: BoxFit.contain,
                    mode: ExtendedImageMode.gesture,
                    initGestureConfigHandler: (state) {
                      return GestureConfig();
                    },
                    alignment: Alignment.center,
                  ),
                  if (state is EditImageLoading)
                    Container(
                      color: const Color(0x0F151515).withOpacity(0.4),
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: kPrimaryColor,
                        ),
                      ),
                    )
                ],
              );
            },
          )),
    );
  }
}
