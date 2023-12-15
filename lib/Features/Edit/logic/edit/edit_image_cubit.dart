import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

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

  void restoreOriginalImage() {
    imageBytes = originalImageBytes;
    emit(EditImageResult());
    image = img.decodeImage(imageBytes!)!;
  }

  void emitResultState() {
    emit(EditImageResult());
  }
}
