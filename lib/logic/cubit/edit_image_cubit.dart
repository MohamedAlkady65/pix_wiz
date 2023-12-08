import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pix_wiz/helper/edit_mode.dart';

part 'edit_image_state.dart';

class EditImageCubit extends Cubit<EditImageState> {
  EditImageCubit() : super(EditImageInitial());

  img.Image? editedImage;
  Uint8List? originalImageBytes;
  Uint8List? editedImageBytes;
  Uint8List? operationsImageBytes;

  EditMode _currentMode = EditMode.start;


  Future<bool> pickImage({required ImageSource source}) async {
    var picker = ImagePicker();
    var picked = await picker.pickImage(source: source);
    if (picked != null) {
      originalImageBytes = File(picked.path).readAsBytesSync();
      editedImageBytes = originalImageBytes;
      editedImage = img.decodeImage(editedImageBytes!)!;
      emit(EditImageResult());
      return true;
    }
    return false;
  }

  void restoreOriginalImage() {
    editedImageBytes = originalImageBytes;
    emit(EditImageResult());
    editedImage = img.decodeImage(editedImageBytes!)!;
  }

  void emitLoadingState() {
    emit(EditImageLoading());
  }

  void emitResultState() {
    emit(EditImageResult());
  }


  set currentMode(EditMode value) {
    _currentMode = value;
    if (value == EditMode.opetrations) {
      operationsImageBytes = editedImageBytes;
    }
    emit(EditImageChangeMode());
  }

  EditMode get currentMode => _currentMode;

  void goBack(BuildContext context) {
    if (_currentMode == EditMode.start) {
      Navigator.pop(context);
      resetValues();
    } else {
      if (_currentMode == EditMode.crop ||
          _currentMode == EditMode.opetrations) {
        currentMode = EditMode.start;
      }
    }
  }

  void resetValues() {
    editedImage =
        originalImageBytes = editedImageBytes = operationsImageBytes = null;
  }
}
