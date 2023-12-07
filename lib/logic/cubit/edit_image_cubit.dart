import 'dart:io';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

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

  void editAction() {
    editedImage = img.grayscale(originalImage);
    editedImageBytes = img.encodePng(editedImage!);
    emit(EditImageEdited(editedImageBytes!));
  }
}
