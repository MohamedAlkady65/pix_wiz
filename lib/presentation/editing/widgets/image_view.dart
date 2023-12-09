import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pix_wiz/helper/edit_mode.dart';
import 'package:pix_wiz/logic/crop/crop_cubit.dart';
import 'package:pix_wiz/logic/cubit/edit_image_cubit.dart';
import 'package:pix_wiz/logic/filters/filters_cubit.dart';

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
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    ColorFiltered(
                      colorFilter: ColorFilter.matrix(
                          BlocProvider.of<FiltersCubit>(context)
                              .filterOptionsValues
                              .matrix),
                      child: ExtendedImage.memory(
                        editImageCubit.currentMode == EditMode.opetrations
                            ? editImageCubit.operationsImageBytes!
                            : editImageCubit.editedImageBytes!,
                        fit: BoxFit.contain,
                        mode: editImageCubit.currentMode == EditMode.crop
                            ? ExtendedImageMode.editor
                            : ExtendedImageMode.gesture,
                        extendedImageEditorKey:
                            BlocProvider.of<CropCubit>(context)
                                .extendedEditorKey,
                        initGestureConfigHandler: (state) {
                          return GestureConfig();
                        },
                        initEditorConfigHandler: (state) {
                          return EditorConfig(
                            cropRectPadding: const EdgeInsets.all(8),
                          );
                        },
                        alignment: Alignment.center,
                      ),
                    ),
                    if (state is EditImageLoading)
                      Container(
                          color: const Color(0x0F151515).withOpacity(0.4),
                          child:
                              const Center(child: CircularProgressIndicator()))
                  ],
                );
              },
            )),
      ),
    );
  }
}
