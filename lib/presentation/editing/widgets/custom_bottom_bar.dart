import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pix_wiz/helper/edit_mode.dart';
import 'package:pix_wiz/logic/cubit/edit_image_cubit.dart';
import 'package:pix_wiz/presentation/editing/widgets/extended_options.dart';
import 'package:pix_wiz/presentation/editing/widgets/filters_options.dart';

class CustomBottomBar extends StatelessWidget {
  const CustomBottomBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditImageCubit, EditImageState>(
      buildWhen: (pre, cur) => cur is EditImageChangeMode,
      builder: (context, state) {
        var currentMode = BlocProvider.of<EditImageCubit>(context).currentMode;
        if (currentMode == EditMode.crop) {
          return const ExtendedOptions();
        } else if (currentMode == EditMode.filter) {
          return const FiltersOptions();
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
