import 'package:flutter/material.dart';
import 'package:pix_wiz/Features/adjust/presentation/adjust/adjust_screen.dart';
import 'package:pix_wiz/Features/operations/presentation/operations/operations_screen.dart';
import 'package:pix_wiz/Features/crop/presentation/crop/crop_screen.dart';
import 'package:pix_wiz/Core/components/action_option.dart';

class EditingBottomBar extends StatelessWidget {
  const EditingBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      color: const Color(0xFF2A2A2A),
      child: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ActionOption(
                  text: "Filter",
                  icon: Icons.workspaces_rounded,
                  action: () {
                    Navigator.of(context).push(PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) =>
                          const OperationsScreen(),
                      transitionDuration: Duration.zero,
                      reverseTransitionDuration: Duration.zero,
                    ));
                  }),
              ActionOption(
                  text: "Adjust",
                  icon: Icons.tune,
                  action: () {
                    Navigator.of(context).push(PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) =>
                          const AdjustScreen(),
                      transitionDuration: Duration.zero,
                      reverseTransitionDuration: Duration.zero,
                    ));
                  }),
              ActionOption(
                  text: "Crop",
                  icon: Icons.crop_rotate,
                  action: () {
                    Navigator.of(context).push(PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) =>
                          const CropScreen(),
                      transitionDuration: Duration.zero,
                      reverseTransitionDuration: Duration.zero,
                    ));
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
