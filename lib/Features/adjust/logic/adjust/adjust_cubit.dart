import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pix_wiz/Features/adjust/logic/adjust_options_values.dart';
import 'package:pix_wiz/Features/edit/logic/edit/edit_image_cubit.dart';
import 'package:image/image.dart' as img;
import 'package:image_editor/image_editor.dart';
part 'adjust_state.dart';

class AdjustCubit extends Cubit<AdjustState> {
  AdjustCubit({required this.editImageCubit}) : super(AdjustInitial());
  final EditImageCubit editImageCubit;

  AdjustOptionsValues adjustOptionsValues = AdjustOptionsValues();

  set currentChoice(AdjustOptionsChoices choice) {
    if (choice != AdjustOptionsChoices.none &&
        adjustOptionsValues.choice == choice) {
      adjustOptionsValues.choice = AdjustOptionsChoices.none;
    } else {
      adjustOptionsValues.choice = choice;
    }
    emit(AdjustChangeChoice());
  }

  AdjustOptionsChoices get currentChoice => adjustOptionsValues.choice;

  void changeBrightness(value) {
    adjustOptionsValues.brightnessValue = value;
    emit(AdjustAction());
  }

  void changeSaturation(value) {
    adjustOptionsValues.saturationValue = value;
    emit(AdjustAction());
  }

  void changeHue(value) {
    adjustOptionsValues.hueValue = value;
    emit(AdjustAction());
  }

  void changeContrast(value) {
    adjustOptionsValues.contrastValue = value;
    emit(AdjustAction());
  }

  void adjustReset() {
    adjustOptionsValues.reset();
    emit(AdjustAction());
    emit(AdjustChangeChoice());
  }

  Future<void> adjustDone() async {
    emit(AdjustLoading());

    final editorOption = ImageEditorOption();
    editorOption.addOption(ColorOption(matrix: adjustOptionsValues.matrix));

    final editedImageBytes = (await ImageEditor.editImage(
        image: editImageCubit.imageBytes!, imageEditorOption: editorOption))!;

    final editedImage = img.decodeImage(editedImageBytes)!;

    editImageCubit.changeImage(
        image: editedImage, imageBytes: editedImageBytes);

    emit(AdjustAction());
  }
}
