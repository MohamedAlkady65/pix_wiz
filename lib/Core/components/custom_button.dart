import 'package:flutter/material.dart';
import 'package:pix_wiz/Core/colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.text,
      required this.onPressed,
      this.isLoading = false});
  final String text;
  final void Function() onPressed;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: kPrimaryColor,
            fixedSize: const Size.fromHeight(60),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16))),
        onPressed: onPressed,
        child: isLoading
            ? const CircularProgressIndicator(
                color: Colors.white,
              )
            : Text(
                text,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w600),
              ));
  }
}
