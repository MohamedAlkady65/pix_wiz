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

  final GlobalKey<ExtendedImageEditorState> extendedEditorKey =
      GlobalKey<ExtendedImageEditorState>();

  EditMode currentMode = EditMode.filter;

  Future<bool> pickImage({required ImageSource source}) async {
    var picker = ImagePicker();
    var picked = await picker.pickImage(source: source);
    if (picked != null) {
      originalImageFile = File(picked.path);
      originalImageBytes = originalImageFile!.readAsBytesSync();
      originalImage = img.decodeImage(originalImageBytes!)!;
      emit(EditImageOriginal(originalImageBytes!));
      return true;
    }
    return false;
  }

  void editAction({required ActionTypes action}) async {
    if (action == ActionTypes.original) {
      emit(EditImageOriginal(originalImageBytes!));
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
    emit(EditImageEdited(editedImageBytes!));
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

  void goBack(BuildContext context) {
    if (currentMode == EditMode.start) {
      originalImageFile = originalImage =
          originalImageBytes = editedImage = editedImageBytes = null;
      Navigator.pop(context);
    } else {
      if (currentMode == EditMode.crop || currentMode == EditMode.filter) {
        currentMode = EditMode.start;
        emit(EditImageChangeMode());
      }
    }
  }
}
