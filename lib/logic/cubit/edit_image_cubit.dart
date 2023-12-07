import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pix_wiz/helper/action_types.dart';

part 'edit_image_state.dart';

class EditImageCubit extends Cubit<EditImageState> {
  EditImageCubit() : super(EditImageInitial());
  late File originalImageFile;

  late img.Image originalImage;
  late Uint8List originalImageBytes;

  img.Image? editedImage;
  Uint8List? editedImageBytes;

  Future<bool> pickImage({required ImageSource source}) async {
    var picker = ImagePicker();
    var picked = await picker.pickImage(source: source);
    if (picked != null) {
      originalImageFile = File(picked.path);
      originalImageBytes = originalImageFile.readAsBytesSync();
      originalImage = img.decodeImage(originalImageBytes)!;
      emit(EditImageOriginal(originalImageBytes));
      return true;
    }
    return false;
  }

  void editAction({required ActionTypes action}) async {
    if (action == ActionTypes.original) {
      emit(EditImageOriginal(originalImageBytes));
      return;
    }

    var cmd = img.Command()
      ..image(originalImage)
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
}
