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
        currentAction = OperationsTypes.original,
        super(OperationsInitial());

  final EditImageCubit editImageCubit;
  Uint8List imageBytes;

  OperationsTypes currentAction;

  img.Command? cmd;

  Future<void> filterAction({required OperationsTypes action}) async {
    emit(OperationsLoading());

    if (action == OperationsTypes.original) {
      imageBytes = editImageCubit.imageBytes!;
    } else {
      cmd = img.Command()
        ..image(editImageCubit.image!)
        ..copy();

      if (action == OperationsTypes.sobel) {
        cmd!.sobel();
      } else if (action == OperationsTypes.edgeGlow) {
        cmd!.edgeGlow();
      } else if (action == OperationsTypes.threashold) {
        cmd!.luminanceThreshold();
      } else if (action == OperationsTypes.grayScale) {
        cmd!.grayscale();
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
