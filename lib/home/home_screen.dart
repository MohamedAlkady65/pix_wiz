import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pix_wiz/editing/editing_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Image Processing"),
      ),
      body: Align(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(
              flex: 1,
            ),
            const Text(
              "Select Image To Process",
              style: TextStyle(fontSize: 24),
            ),
            const Spacer(
              flex: 6,
            ),
            ElevatedButton(
                onPressed: () async {
                  await pickImage(context, source: ImageSource.camera);
                },
                child: const Text("From Camera")),
            const Spacer(
              flex: 2,
            ),
            ElevatedButton(
                onPressed: () async {
                  await pickImage(context, source: ImageSource.gallery);
                },
                child: const Text("From Gallery")),
            const Spacer(
              flex: 1,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> pickImage(BuildContext context,
      {required ImageSource source}) async {
    var picker = ImagePicker();
    var picked = await picker.pickImage(source: source);
    if (picked != null) {
      var image = File(picked.path);
      // ignore: use_build_context_synchronously
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EditingScreen(
              originalImage: image,
            ),
          ));
    }
  }
}
