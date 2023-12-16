import 'dart:typed_data';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pix_wiz/Core/helper/operations_types.dart';
import 'package:image/image.dart' as img;
import 'package:pix_wiz/Features/edit/logic/edit/edit_image_cubit.dart';
part 'operations_state.dart';

class OperationsCubit extends Cubit<OperationsState> {
  OperationsCubit({required this.editImageCubit})
      : imageBytes = editImageCubit.imageBytes!,
        currentAction = OperationsType.original,
        super(OperationsInitial());

  final EditImageCubit editImageCubit;
  Uint8List imageBytes;

  OperationsType currentAction;

  img.Command? cmd;

  Future<void> filterAction({required OperationsType action}) async {
    emit(OperationsLoading());

    if (action == OperationsType.original) {
      imageBytes = editImageCubit.imageBytes!;
    } else {
      cmd = img.Command()
        ..image(editImageCubit.image!)
        ..copy();

      if (action == OperationsType.sobel) {
        cmd!.sobel();
      } else if (action == OperationsType.edgeGlow) {
        cmd!.edgeGlow();
      } else if (action == OperationsType.threashold) {
        cmd!.luminanceThreshold();
      } else if (action == OperationsType.grayScale) {
        cmd!.grayscale();
      } else if (action == OperationsType.billboard) {
        cmd!.billboard();
      } else if (action == OperationsType.bumpToNormal) {
        cmd!.bumpToNormal();
      } else if (action == OperationsType.emboss) {
        cmd!.emboss();
      } else if (action == OperationsType.gaussianBlur) {
        cmd!.gaussianBlur(radius: 20);
      } else if (action == OperationsType.invert) {
        cmd!.invert();
      } else if (action == OperationsType.noise) {
        cmd!.noise(30);
      } else if (action == OperationsType.pixelate) {
        cmd!.pixelate(size: 10);
      } else if (action == OperationsType.sketch) {
        cmd!.sketch();
      }

      cmd!.encodePng();

      imageBytes = (await cmd!.getBytesThread())!;
    }

    emit(OperationsAction());
    currentAction = action;
    emit(OperationsChangeAction());
  }

  void operationDone() {
    if (cmd != null) {
      editImageCubit.changeImage(
          image: cmd!.outputImage!, imageBytes: cmd!.outputBytes!);
      cmd = null;
    }
  }
}
