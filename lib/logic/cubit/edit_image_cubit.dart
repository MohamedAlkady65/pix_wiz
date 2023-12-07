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

  img.Image? editedImage;
  Uint8List? originalImageBytes;
  Uint8List? editedImageBytes;
  Uint8List? filteredImageBytes;

  final GlobalKey<ExtendedImageEditorState> extendedEditorKey =
      GlobalKey<ExtendedImageEditorState>();

  EditMode _currentMode = EditMode.start;

  img.Command? cmd;

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
    editedImage = img.decodeImage(editedImageBytes!)!;
    emit(EditImageResult());
  }

  void filterAction({required ActionTypes action}) async {
    if (action == ActionTypes.original) {
      filteredImageBytes = editedImageBytes!;
      emit(EditImageResult());
      return;
    }

    cmd = img.Command()
      ..image(editedImage!)
      ..copy();

    if (action == ActionTypes.sobel) {
      cmd!.sobel();
    } else if (action == ActionTypes.edgeGlow) {
      cmd!.edgeGlow();
    } else if (action == ActionTypes.threashold) {
      cmd!.luminanceThreshold();
    } else if (action == ActionTypes.grayScale) {
      cmd!.grayscale();
    }

    cmd!.encodePng();

    filteredImageBytes = await cmd!.getBytes();
    emit(EditImageResult());
  }

  void filterDone() {
    if (cmd != null) {
      editedImageBytes = cmd!.outputBytes;
      editedImage = cmd!.outputImage;
      cmd = null;
    }
    currentMode = EditMode.start;
  }

  void flip() {
    extendedEditorKey.currentState!.flip();
  }

  void rotateRight() {
    extendedEditorKey.currentState!.rotate(right: true);
  }

  void rotateLeft() {
    extendedEditorKey.currentState!.rotate(right: false);
  }

  void resetCropping() {
    extendedEditorKey.currentState!.reset();
  }

  void croppingDone() async {
    EditActionDetails editAction = extendedEditorKey.currentState!.editAction!;
    print("x => ${editAction.flipX}");
    print("y => ${editAction.flipY}");

    if (editAction.needCrop) {
      final Rect cropRect = extendedEditorKey.currentState!.getCropRect()!;
      editedImage = img.copyCrop(editedImage!,
          x: cropRect.left.toInt(),
          y: cropRect.top.toInt(),
          width: cropRect.width.toInt(),
          height: cropRect.height.toInt());
    }

    if (editAction.needFlip) {
      if (editAction.flipX && editAction.flipY) {
        editedImage = img.flip(editedImage!, direction: img.FlipDirection.both);
      } else if (editAction.flipY) {
        editedImage =
            img.flip(editedImage!, direction: img.FlipDirection.horizontal);
      } else if (editAction.flipX) {
        editedImage =
            img.flip(editedImage!, direction: img.FlipDirection.vertical);
      }
    }

    if (editAction.hasRotateAngle) {
      editedImage = img.copyRotate(editedImage!,
          angle: extendedEditorKey.currentState!.editAction!.rotateAngle);
    }

    editedImageBytes = img.encodePng(editedImage!);

    emit(EditImageResult());
    currentMode = EditMode.start;
  }

  set currentMode(EditMode value) {
    _currentMode = value;
    if (value == EditMode.filter) {
      filteredImageBytes = editedImageBytes;
    }
    emit(EditImageChangeMode());
  }

  EditMode get currentMode => _currentMode;

  void goBack(BuildContext context) {
    if (_currentMode == EditMode.start) {
      Navigator.pop(context);
      resetValues();
    } else {
      if (_currentMode == EditMode.crop || _currentMode == EditMode.filter) {
        currentMode = EditMode.start;
      }
    }
  }

  void resetValues() {
    editedImage =
        originalImageBytes = editedImageBytes = filteredImageBytes = cmd = null;
  }
}
