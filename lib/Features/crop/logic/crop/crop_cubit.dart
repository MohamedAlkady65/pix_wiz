import 'package:bloc/bloc.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:image/image.dart' as img;
import 'package:pix_wiz/Features/edit/logic/edit/edit_image_cubit.dart';

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

  Future<void> croppingDone() async {
    EditActionDetails editAction = extendedEditorKey.currentState!.editAction!;
    if (!editAction.needCrop &&
        !editAction.needFlip &&
        !editAction.hasRotateAngle) {
      return;
    }

    emit(CropImageLoading());
    var cropCmd = img.Command()..image(editImageCubit.image!);

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

    editImageCubit.changeImage(
        image: cropCmd.outputImage!, imageBytes: cropCmd.outputBytes!);
    emit(CropImageAction());
  }
}
