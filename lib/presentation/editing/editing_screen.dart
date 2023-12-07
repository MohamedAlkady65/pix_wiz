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
    return const Scaffold(
      appBar: CustomAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ImageView(),
        ],
      ),
      bottomNavigationBar: CustomBottomBar(),
    );
  }
}
