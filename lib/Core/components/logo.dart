import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Logo extends StatelessWidget {
  const Logo({
    super.key, required this.size,
  });
  final double size;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(99999),
        child: SvgPicture.asset(
          'assets/images/logo/logo1.svg',
          width: size,
        ),
      ),
    );
  }
}
