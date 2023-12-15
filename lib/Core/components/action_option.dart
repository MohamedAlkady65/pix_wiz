import 'package:flutter/material.dart';

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
                icon ?? Icons.star,
                size: 36,
                color: active ? Colors.blue : Colors.white,
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
