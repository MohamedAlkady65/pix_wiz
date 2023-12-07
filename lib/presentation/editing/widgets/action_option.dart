import 'package:flutter/material.dart';

class ActionOption extends StatelessWidget {
  const ActionOption({
    super.key,
    this.text,
    this.action,
    this.icon,
  });
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
              ),
              if (text != null) Text(text!)
            ],
          ),
        ),
      ),
    );
  }
}
