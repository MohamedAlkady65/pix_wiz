import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;

class EditingScreen extends StatefulWidget {
  const EditingScreen({super.key, required this.originalImage});
  final File originalImage;
  @override
  State<EditingScreen> createState() => _EditingScreenState();
}

class _EditingScreenState extends State<EditingScreen> {
  img.Image? org;
  img.Image? edited;
  Image? showed;
  double value = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Align(
                  alignment: Alignment.topCenter,
                  child: showed ??
                      Image.file(
                        widget.originalImage,
                        fit: BoxFit.cover,
                      )),
            ),
          ),
          Container(
            height: 80,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            color: const Color(0xFF2A2A2A),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                filterButton(
                    text: "Original",
                    filter: (im) {
                      return im;
                    }),
                filterButton(
                    text: "Blur",
                    filter: (im) {
                      return img.grayscale(im);
                    }),
                filterButton(
                    text: "noise",
                    filter: (im) {
                      return img.noise(im, 50);
                    }),
                filterButton(
                    text: "Contrast",
                    filter: (im) {
                      return img.contrast(im, contrast: 150);
                    }),
                filterButton(
                    text: "sobel",
                    filter: (im) {
                      return img.sobel(im);
                    }),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget filterButton(
      {required String text, required Function(img.Image src) filter}) {
    return InkWell(
      onTap: () {
        org = img.decodeImage(widget.originalImage.readAsBytesSync());
        edited = filter(org!);
        
        showed = Image.memory(
          img.encodePng(edited!),
          fit: BoxFit.cover,
        );
        setState(() {});
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.star,
              size: 36,
            ),
            Text(text)
          ],
        ),
      ),
    );
  }
}

          // ElevatedButton(
          //     onPressed: () async {
          //       org = img.decodeImage(widget.originalImage.readAsBytesSync());
          //       // edited = img.grayscale(org!);
          //       // edited = img.noise(org!, 15, type: img.NoiseType.gaussian);
          //       // edited = img.contrast(org!, contrast: 150);
          //       edited = img.gaussianBlur(org!, radius: 5);
          //       // edited =
          //       //     img.flip(org!, direction: img.FlipDirection.vertical);
          //       showed = Image.memory(img.encodePng(edited!));
          //       setState(() {});
          //     },
          //     child: const Text("123")),