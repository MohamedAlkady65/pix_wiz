import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pix_wiz/helper/edit_mode.dart';
import 'package:pix_wiz/logic/cubit/edit_image_cubit.dart';

class ImageView extends StatelessWidget {
  const ImageView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    EditImageCubit editImageCubit = BlocProvider.of<EditImageCubit>(context);
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Align(
            alignment: Alignment.center,
            child: BlocBuilder<EditImageCubit, EditImageState>(
              builder: (context, state) {
                if (state is EditImageResult || state is EditImageChangeMode) {
                  return ExtendedImage.memory(
                    editImageCubit.currentMode ==
                            EditMode.filter
                        ? editImageCubit
                            .filteredImageBytes!
                        : editImageCubit
                            .editedImageBytes!,
                    fit: BoxFit.contain,
                    mode:
                        editImageCubit.currentMode ==
                                EditMode.crop
                            ? ExtendedImageMode.editor
                            : ExtendedImageMode.gesture,
                    extendedImageEditorKey:
                        editImageCubit
                            .extendedEditorKey,
                    initGestureConfigHandler: (state) {
                      return GestureConfig();
                    },
                    initEditorConfigHandler: (state) {
                      return EditorConfig(
                        cropRectPadding: const EdgeInsets.all(8),
                      );
                    },
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
