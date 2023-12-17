import 'dart:io';
import 'dart:typed_data';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pix_wiz/Core/helper/dialog.dart';
import 'package:pix_wiz/Features/auth/presentation/sign_in/sign_in_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
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


  void saveToGallery(BuildContext context) async {
    var permission = await Permission.storage.status;
    if (permission.isDenied) {
      permission = await Permission.storage.request();
    }
    if (permission.isGranted) {
      emit(EditImageLoading());
      try {
        await ImageGallerySaver.saveImage(
          imageBytes!,
        );
        // ignore: use_build_context_synchronously
        awesomeDialog(
            context: context,
            title: "Save To Gallery",
            message: "Photo is saved successfully to the gallery",
            type: DialogType.success);
      } catch (_) {}
      emit(EditImageResult());
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
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const SignInScreen(),
            ));
      });

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
