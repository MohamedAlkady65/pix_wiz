import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pix_wiz/Core/helper/dialog.dart';
import 'package:pix_wiz/Features/auth/presentation/sign_in/sign_in_screen.dart';

part 'edit_image_state.dart';

class EditImageCubit extends Cubit<EditImageState> {
  EditImageCubit() : super(EditImageInitial());

  Uint8List? originalImageBytes;
  img.Image? image;
  Uint8List? imageBytes;

  Future<bool> pickImage({required ImageSource source}) async {
    var picker = ImagePicker();
    var picked = await picker.pickImage(source: source);
    if (picked != null) {
      originalImageBytes = File(picked.path).readAsBytesSync();
      imageBytes = originalImageBytes;
      image = img.decodeImage(imageBytes!)!;
      emit(EditImageResult());
      return true;
    }
    return false;
  }

  void restoreOriginalImage(BuildContext context) async {
    final res = await showCustomDialog(
        context: context,
        title: 'Restore Original Image',
        content: 'Are you sure you want to discard changes?');

    if (res == true) {
      imageBytes = originalImageBytes;
      emit(EditImageResult());
      image = img.decodeImage(imageBytes!)!;
    }
  }

  void changeImage({required img.Image image, required Uint8List imageBytes}) {
    this.image = image;
    this.imageBytes = imageBytes;
    emit(EditImageResult());
  }

  String getUserName(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const SignInScreen(),
          ));
      return "";
    } else {
      return user.displayName ?? "";
    }
  }

  void signOut(BuildContext context) async {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const SignInScreen(),
        ));

    await FirebaseAuth.instance.signOut();
  }
}
