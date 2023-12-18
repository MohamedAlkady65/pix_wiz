import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pix_wiz/Core/colors.dart';
import 'package:pix_wiz/Features/crop/logic/crop/crop_cubit.dart';
import 'package:pix_wiz/Features/edit/logic/edit/edit_image_cubit.dart';

class ImageViewCrop extends StatelessWidget {
  const ImageViewCrop({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Align(
          alignment: Alignment.center,
          child: BlocBuilder<CropCubit, CropState>(
            builder: (context, state) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  ExtendedImage.memory(
                    BlocProvider.of<EditImageCubit>(context).imageBytes!,
                    fit: BoxFit.contain,
                    mode: ExtendedImageMode.editor,
                    extendedImageEditorKey:
                        BlocProvider.of<CropCubit>(context).extendedEditorKey,
                    initEditorConfigHandler: (state) {
                      return EditorConfig(
                        cropRectPadding: const EdgeInsets.all(8),
                        cornerColor: kPrimaryColor
                      );
                    },
                    alignment: Alignment.center,
                  ),
                  if (state is CropImageLoading)
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
