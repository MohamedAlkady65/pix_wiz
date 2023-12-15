import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pix_wiz/Features/edit/logic/edit/edit_image_cubit.dart';
import 'package:pix_wiz/Features/filters/logic/filters/filters_cubit.dart';
import 'package:pix_wiz/Features/filters/presentation/filters/widgets/filters_app_bar.dart';
import 'package:pix_wiz/Features/filters/presentation/filters/widgets/filters_bottom_bar.dart';
import 'package:pix_wiz/Features/filters/presentation/filters/widgets/image_view_filters.dart';

class FiltersScreen extends StatelessWidget {
  const FiltersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FiltersCubit(
          editImageCubit: BlocProvider.of<EditImageCubit>(context)),
      child: const Scaffold(
        appBar: FiltersAppbar(),
        body: ImageViewFilters(),
        bottomNavigationBar: FiltersBottomBar(),
      ),
    );
  }
}
