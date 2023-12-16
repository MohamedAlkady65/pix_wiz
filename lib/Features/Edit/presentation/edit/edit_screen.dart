import 'package:flutter/material.dart';
import 'package:pix_wiz/Features/edit/presentation/edit/widgets/edit_app_bar.dart';
import 'package:pix_wiz/Features/edit/presentation/edit/widgets/image_view_edit.dart';
import 'package:pix_wiz/Features/edit/presentation/edit/widgets/edit_bottom_bar.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({super.key});
  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: const Scaffold(
        appBar: EditingAppBar(),
        body: ImageViewEdit(),
        bottomNavigationBar: EditingBottomBar(),
      ),
    );
  }
}
