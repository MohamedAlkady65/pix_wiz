import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pix_wiz/Core/helper/filter_options_values.dart';
import 'package:pix_wiz/Features/edit/logic/edit/edit_image_cubit.dart';

part 'filters_state.dart';

class FiltersCubit extends Cubit<FiltersState> {
  FiltersCubit({required this.editImageCubit}) : super(FiltersInitial());
  final EditImageCubit editImageCubit;

  FilterOptionsValues filterOptionsValues = FilterOptionsValues();

  set currentChoice(FilterOptionsChoices choice) {
    if (choice != FilterOptionsChoices.none &&
        filterOptionsValues.choice == choice) {
      filterOptionsValues.choice = FilterOptionsChoices.none;
    } else {
      filterOptionsValues.choice = choice;
    }
    emit(FiltersChangeChoice());
  }

  FilterOptionsChoices get currentChoice => filterOptionsValues.choice;

  void changeBrightness(value) {
    filterOptionsValues.brightnessValue = value;
    emit(FiltersAction());
  }

  void changeSaturation(value) {
    filterOptionsValues.saturationValue = value;
    emit(FiltersAction());
  }

  void changeHue(value) {
    filterOptionsValues.hueValue = value;
    emit(FiltersAction());
  }

  void changeContrast(value) {
    filterOptionsValues.contrastValue = value;
    emit(FiltersAction());
  }

  void resetFilters() {}
  void filtersDone() {}
}
