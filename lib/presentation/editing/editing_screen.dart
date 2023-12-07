import 'package:flutter/material.dart';
import 'package:pix_wiz/presentation/editing/widgets/edit_options.dart';
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
    return Scaffold(
      appBar: AppBar(title: const Text("Edit")),
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [ImageView(), EditOptions()],
      ),
    );
  }
}
