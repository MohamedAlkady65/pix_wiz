import 'package:flutter/material.dart';
import 'package:pix_wiz/Features/crop/presentation/crop/crop_screen.dart';
import 'package:pix_wiz/Core/components/action_option.dart';
import 'package:pix_wiz/Features/filters/presentation/filters/filters_screen.dart';
import 'package:pix_wiz/Features/operations/presentation/operations/operations_screen.dart';

class EditingBottomBar extends StatelessWidget {
  const EditingBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      color: const Color(0xFF2A2A2A),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ActionOption(
              text: "Opetrations",
              action: () {
                Navigator.of(context).push(PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                      const OperationsScreen(),
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero,
                ));
              }),
          ActionOption(
              text: "Crop",
              action: () {
                Navigator.of(context).push(PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                      const CropScreen(),
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero,
                ));
              }),
          ActionOption(
              text: "Filters",
              action: () {
                Navigator.of(context).push(PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                      const FiltersScreen(),
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero,
                ));
              }),
        ],
      ),
    );
  }
}
