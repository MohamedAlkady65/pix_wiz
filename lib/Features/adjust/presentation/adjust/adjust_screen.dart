import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pix_wiz/Features/adjust/logic/adjust/adjust_cubit.dart';
import 'package:pix_wiz/Features/adjust/presentation/adjust/widgets/adjust_app_bar.dart';
import 'package:pix_wiz/Features/adjust/presentation/adjust/widgets/adjust_bottom_bar.dart';
import 'package:pix_wiz/Features/adjust/presentation/adjust/widgets/image_view_adjust.dart';
import 'package:pix_wiz/Features/edit/logic/edit/edit_image_cubit.dart';

class AdjustScreen extends StatelessWidget {
  const AdjustScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AdjustCubit(editImageCubit: BlocProvider.of<EditImageCubit>(context)),
      child: const Scaffold(
        appBar: AdjustAppbar(),
        body: ImageViewAdjust(),
        bottomNavigationBar: AdjustBottomBar(),
      ),
    );
  }
}
