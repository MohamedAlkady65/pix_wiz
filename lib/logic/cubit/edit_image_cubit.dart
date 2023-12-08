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
import 'package:pix_wiz/helper/filter_options_values.dart';

part 'edit_image_state.dart';

class EditImageCubit extends Cubit<EditImageState> {
  EditImageCubit() : super(EditImageInitial());

  img.Image? editedImage;
  Uint8List? originalImageBytes;
  Uint8List? editedImageBytes;
  Uint8List? operationsImageBytes;

  final GlobalKey<ExtendedImageEditorState> extendedEditorKey =
      GlobalKey<ExtendedImageEditorState>();

  EditMode _currentMode = EditMode.start;

  img.Command? cmd;

  FilterOptionsValues filterOptionsValues = FilterOptionsValues();

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

  Future<void> filterAction({required ActionTypes action}) async {
    emit(EditImageLoading());

    if (action == ActionTypes.original) {
      operationsImageBytes = editedImageBytes!;
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

    operationsImageBytes = await cmd!.getBytesThread();

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
    if (!editAction.needCrop &&
        !editAction.needFlip &&
        !editAction.hasRotateAngle) {
      currentMode = EditMode.start;
      return;
    }

    emit(EditImageLoading());
    var cropCmd = img.Command()..image(editedImage!);

    if (editAction.needCrop) {
      final Rect cropRect = extendedEditorKey.currentState!.getCropRect()!;
      cropCmd.copyCrop(
          x: cropRect.left.toInt(),
          y: cropRect.top.toInt(),
          width: cropRect.width.toInt(),
          height: cropRect.height.toInt());
    }

    if (editAction.needFlip) {
      if (editAction.flipX && editAction.flipY) {
        cropCmd.flip(direction: img.FlipDirection.both);
      } else if (editAction.flipY) {
        cropCmd.flip(direction: img.FlipDirection.horizontal);
      } else if (editAction.flipX) {
        cropCmd.flip(direction: img.FlipDirection.vertical);
      }
    }

    if (editAction.hasRotateAngle) {
      cropCmd.copyRotate(
          angle: extendedEditorKey.currentState!.editAction!.rotateAngle);
    }

    cropCmd.encodePng();

    await cropCmd.executeThread();

    editedImage = cropCmd.outputImage;
    editedImageBytes = cropCmd.outputBytes;

    emit(EditImageResult());
    currentMode = EditMode.start;
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
    editedImage = originalImageBytes =
        editedImageBytes = operationsImageBytes = cmd = null;
  }
}
