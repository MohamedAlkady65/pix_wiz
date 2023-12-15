import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pix_wiz/Core/helper/action_types.dart';
import 'package:image/image.dart' as img;
import 'package:pix_wiz/Features/edit/logic/edit/edit_image_cubit.dart';
part 'operations_state.dart';

class OperationsCubit extends Cubit<OperationsState> {
  OperationsCubit({required this.editImageCubit}) : super(OperationsInitial());

  final EditImageCubit editImageCubit;
  Uint8List? imageBytes;

  img.Command? cmd;

  Future<void> filterAction({required ActionTypes action}) async {
    emit(OperationsLoading());

    if (action == ActionTypes.original) {
      imageBytes = editImageCubit.imageBytes!;
      emit(OperationsAction());
      return;
    }

    cmd = img.Command()
      ..image(editImageCubit.image!)
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

    imageBytes = await cmd!.getBytesThread();

    emit(OperationsAction());
  }

  void filterDone() {
    if (cmd != null) {
      editImageCubit.imageBytes = cmd!.outputBytes;
      editImageCubit.image = cmd!.outputImage;
      editImageCubit.emitResultState();
      cmd = null;
    }
  }
}
