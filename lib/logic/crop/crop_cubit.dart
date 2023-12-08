import 'package:bloc/bloc.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:pix_wiz/helper/edit_mode.dart';
import 'package:pix_wiz/logic/cubit/edit_image_cubit.dart';
import 'package:image/image.dart' as img;

part 'crop_state.dart';

class CropCubit extends Cubit<CropState> {
  CropCubit({required this.editImageCubit}) : super(CropInitial());
  final EditImageCubit editImageCubit;

  final GlobalKey<ExtendedImageEditorState> extendedEditorKey =
      GlobalKey<ExtendedImageEditorState>();

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
      editImageCubit.currentMode = EditMode.start;
      return;
    }

    editImageCubit.emitLoadingState();
    var cropCmd = img.Command()..image(editImageCubit.editedImage!);

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

    editImageCubit.editedImage = cropCmd.outputImage;
    editImageCubit.editedImageBytes = cropCmd.outputBytes;

    editImageCubit.emitResultState();
    editImageCubit.currentMode = EditMode.start;
  }
}
