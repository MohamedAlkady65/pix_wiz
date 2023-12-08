import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pix_wiz/helper/action_types.dart';
import 'package:image/image.dart' as img;
import 'package:pix_wiz/helper/edit_mode.dart';
import 'package:pix_wiz/logic/cubit/edit_image_cubit.dart';
part 'operations_state.dart';

class OperationsCubit extends Cubit<OperationsState> {
  OperationsCubit({required this.editImageCubit}) : super(OperationsInitial());

  final EditImageCubit editImageCubit;

  img.Command? cmd;

  Future<void> filterAction({required ActionTypes action}) async {
    editImageCubit.emitLoadingState();

    if (action == ActionTypes.original) {
      editImageCubit.operationsImageBytes = editImageCubit.editedImageBytes!;
      editImageCubit.emitResultState();
      return;
    }

    cmd = img.Command()
      ..image(editImageCubit.editedImage!)
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

    editImageCubit.operationsImageBytes = await cmd!.getBytesThread();

    editImageCubit.emitResultState();
  }

  void filterDone() {
    if (cmd != null) {
      editImageCubit.editedImageBytes = cmd!.outputBytes;
      editImageCubit.editedImage = cmd!.outputImage;
      cmd = null;
    }
    editImageCubit.currentMode = EditMode.start;
  }
}
