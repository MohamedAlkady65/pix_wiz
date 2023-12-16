import 'package:flutter/material.dart';
import 'package:pix_wiz/Core/colors.dart';

class ActionOption extends StatelessWidget {
  const ActionOption({
    super.key,
    this.text,
    this.action,
    this.icon,
    this.active = false,
  });
  final bool active;
  final String? text;
  final void Function()? action;
  final IconData? icon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: action,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon ?? Icons.lens,
                size: 36,
                color: active ? kPrimaryColor : Colors.white,
              ),
              if (text != null)
                Text(
                  text!,
                  style: TextStyle(color: active ? Colors.blue : Colors.white),
                )
            ],
          ),
        ),
      ),
    );
  }
}
