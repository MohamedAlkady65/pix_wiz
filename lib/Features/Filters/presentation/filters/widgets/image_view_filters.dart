import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pix_wiz/Features/edit/logic/edit/edit_image_cubit.dart';
import 'package:pix_wiz/Features/filters/logic/filters/filters_cubit.dart';

class ImageViewFilters extends StatelessWidget {
  const ImageViewFilters({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Align(
            alignment: Alignment.center,
            child: BlocBuilder<FiltersCubit, FiltersState>(
              buildWhen: (pre, cur) =>
                  cur is FiltersAction || cur is FiltersLoading,
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
                        BlocProvider.of<EditImageCubit>(context).imageBytes!,
                        fit: BoxFit.contain,
                        mode: ExtendedImageMode.gesture,
                        initGestureConfigHandler: (state) {
                          return GestureConfig();
                        },
                        alignment: Alignment.center,
                      ),
                    ),
                    if (state is FiltersLoading)
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
