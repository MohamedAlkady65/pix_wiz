import 'package:flutter/material.dart';
import 'package:pix_wiz/Features/filters/presentation/filters/widgets/filters_app_bar.dart';
import 'package:pix_wiz/Features/filters/presentation/filters/widgets/filters_bottom_bar.dart';
import 'package:pix_wiz/Features/filters/presentation/filters/widgets/image_view_filters.dart';

class FiltersScreen extends StatelessWidget {
  const FiltersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: FiltersAppbar(),
      body: ImageViewFilters(),
      bottomNavigationBar:  FiltersBottomBar(),
    );
  }
}
