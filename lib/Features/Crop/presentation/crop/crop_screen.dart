import 'package:flutter/material.dart';
import 'package:pix_wiz/Features/crop/presentation/crop/widgets/crop_app_bar.dart';
import 'package:pix_wiz/Features/crop/presentation/crop/widgets/crop_bottom_bar.dart';
import 'package:pix_wiz/Features/crop/presentation/crop/widgets/image_view_crop.dart';

class CropScreen extends StatelessWidget {
  const CropScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CropAppbar(),
      body: ImageViewCrop(),
      bottomNavigationBar:  CropBottomBar(),
    );
  }
}
