import 'dart:io';
import 'dart:typed_data';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pix_wiz/helper/action_types.dart';
import 'package:pix_wiz/helper/edit_mode.dart';

part 'edit_image_state.dart';

class EditImageCubit extends Cubit<EditImageState> {
  EditImageCubit() : super(EditImageInitial());
  File? originalImageFile;

  img.Image? originalImage;
  Uint8List? originalImageBytes;

  img.Image? editedImage;
  Uint8List? editedImageBytes;

  Uint8List? currentImageBytes;

  final GlobalKey<ExtendedImageEditorState> extendedEditorKey =
      GlobalKey<ExtendedImageEditorState>();

  EditMode _currentMode = EditMode.start;

  Future<bool> pickImage({required ImageSource source}) async {
    var picker = ImagePicker();
    var picked = await picker.pickImage(source: source);
    if (picked != null) {
      originalImageFile = File(picked.path);
      originalImageBytes = originalImageFile!.readAsBytesSync();
      originalImage = img.decodeImage(originalImageBytes!)!;
      currentImageBytes = originalImageBytes!;
      emit(EditImageResult());
      return true;
    }
    return false;
  }

  void editAction({required ActionTypes action}) async {
    if (action == ActionTypes.original) {
      currentImageBytes = originalImageBytes!;
      emit(EditImageResult());
      return;
    }

    var cmd = img.Command()
      ..image(originalImage!)
      ..copy();

    if (action == ActionTypes.sobel) {
      cmd.sobel();
    } else if (action == ActionTypes.edgeGlow) {
      cmd.edgeGlow();
    } else if (action == ActionTypes.threashold) {
      cmd.luminanceThreshold();
    } else if (action == ActionTypes.grayScale) {
      cmd.grayscale();
    }

    cmd.encodePng();

    editedImageBytes = await cmd.getBytes();
    currentImageBytes = editedImageBytes!;
    emit(EditImageResult());
  }

  void flip() {
    extendedEditorKey.currentState!.flip();
  }

  void resetCropping() {
    extendedEditorKey.currentState!.reset();
  }

  void croppingDone() {
    extendedEditorKey.currentState!.reset();
  }

  void rotateRight() {
    extendedEditorKey.currentState!.rotate(right: true);
  }

  void rotateLeft() {
    extendedEditorKey.currentState!.rotate(right: false);
  }

  set currentMode(EditMode value) {
    _currentMode = value;
    emit(EditImageChangeMode());
  }

  EditMode get currentMode => _currentMode;

  void goBack(BuildContext context) {
    if (_currentMode == EditMode.start) {
      originalImageFile = originalImage =
          originalImageBytes = editedImage = editedImageBytes = null;
      Navigator.pop(context);
    } else {
      if (_currentMode == EditMode.crop || _currentMode == EditMode.filter) {
        currentMode = EditMode.start;
      }
    }
  }
}
