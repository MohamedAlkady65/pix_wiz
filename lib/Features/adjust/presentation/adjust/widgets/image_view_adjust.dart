import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pix_wiz/Features/adjust/logic/adjust/adjust_cubit.dart';
import 'package:pix_wiz/Features/edit/logic/edit/edit_image_cubit.dart';

class ImageViewAdjust extends StatelessWidget {
  const ImageViewAdjust({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Align(
            alignment: Alignment.center,
            child: BlocBuilder<AdjustCubit, AdjustState>(
              buildWhen: (pre, cur) =>
                  cur is AdjustAction || cur is AdjustLoading,
              builder: (context, state) {
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    ColorFiltered(
                      colorFilter: ColorFilter.matrix(
                          BlocProvider.of<AdjustCubit>(context)
                              .adjustOptionsValues
                              .matrix),
                      child: ExtendedImage.memory(
                        BlocProvider.of<EditImageCubit>(context).imageBytes!,
                        fit: BoxFit.contain,
                        mode: ExtendedImageMode.gesture,
                        initGestureConfigHandler: (state) {
                          return GestureConfig();
                        },
                        alignment: Alignment.center,
                      ),
                    ),
                    if (state is AdjustLoading)
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
