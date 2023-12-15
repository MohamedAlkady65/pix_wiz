import 'package:flutter/material.dart';
import 'package:pix_wiz/presentation/editing/widgets/custom_app_bar.dart';
import 'package:pix_wiz/presentation/editing/widgets/custom_bottom_bar.dart';
import 'package:pix_wiz/presentation/editing/widgets/image_view.dart';

class EditingScreen extends StatefulWidget {
  const EditingScreen({super.key});
  @override
  State<EditingScreen> createState() => _EditingScreenState();
}

class _EditingScreenState extends State<EditingScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: const Scaffold(
        appBar: CustomAppBar(),
        body: ImageView(),
        bottomNavigationBar: CustomBottomBar(),
      ),
    );
  }
}
