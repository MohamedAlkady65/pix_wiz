import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pix_wiz/Features/crop/logic/crop/crop_cubit.dart';
import 'package:pix_wiz/Features/crop/presentation/crop/widgets/crop_app_bar.dart';
import 'package:pix_wiz/Features/crop/presentation/crop/widgets/crop_bottom_bar.dart';
import 'package:pix_wiz/Features/crop/presentation/crop/widgets/image_view_crop.dart';
import 'package:pix_wiz/Features/edit/logic/edit/edit_image_cubit.dart';

class CropScreen extends StatelessWidget {
  const CropScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CropCubit(editImageCubit: BlocProvider.of<EditImageCubit>(context)),
      child: Theme(
        data: ThemeData.dark(),
        child: const Scaffold(
          appBar: CropAppbar(),
          body: ImageViewCrop(),
          bottomNavigationBar: CropBottomBar(),
        ),
      ),
    );
  }
}
