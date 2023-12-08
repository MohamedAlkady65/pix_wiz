import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pix_wiz/helper/filter_options_values.dart';
import 'package:pix_wiz/logic/cubit/edit_image_cubit.dart';

part 'filters_state.dart';

class FiltersCubit extends Cubit<FiltersState> {
  FiltersCubit({required this.editImageCubit}) : super(FiltersInitial());
  final EditImageCubit editImageCubit;

  FilterOptionsValues filterOptionsValues = FilterOptionsValues();
}
