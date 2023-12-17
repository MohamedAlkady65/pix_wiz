import 'package:flutter/material.dart';
import 'package:pix_wiz/Core/colors.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.hintText,
    this.icon,
    this.isPassword = false,
    this.onSaved,
    this.validator,
  });
  final String hintText;
  final IconData? icon;
  final bool isPassword;
  final Function(String? value)? onSaved;
  final String? Function(String? value)? validator;
  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool visable;

  @override
  void initState() {
    visable = !widget.isPassword;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: widget.onSaved,
      validator: widget.validator,
      decoration: decoration(),
      obscureText: widget.isPassword && !visable,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
    );
  }

  InputDecoration decoration() {
    return InputDecoration(
      enabledBorder: border(const Color(0xFFeeeeee)),
      focusedBorder: border(kPrimaryColor),
      errorBorder: border(kRedColor),
      focusedErrorBorder: border(kRedColor),
      errorStyle: const TextStyle(fontSize: 14),
      filled: true,
      fillColor: const Color(0xFFeeeeee),
      hintText: widget.hintText,
      hintStyle: const TextStyle(
        fontWeight: FontWeight.w600,
        color: Color(0xFF808080),
      ),
      prefixIcon: widget.icon == null ? null : Icon(widget.icon!),
      suffixIcon: widget.isPassword
          ? IconButton(
              onPressed: () {
                setState(() {
                  visable = !visable;
                });
              },
              icon: Icon(visable ? Icons.visibility : Icons.visibility_off))
          : null,
      prefixIconColor: MaterialStateColor.resolveWith(
        (states) => states.contains(MaterialState.focused)
            ? kPrimaryColor
            : const Color(0xFF808080),
      ),
      suffixIconColor: MaterialStateColor.resolveWith(
        (states) => states.contains(MaterialState.focused)
            ? kPrimaryColor
            : const Color(0xFF808080),
      ),
    );
  }

  OutlineInputBorder border(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: color, width: 1.5),
    );
  }
}
