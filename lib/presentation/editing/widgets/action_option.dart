import 'package:flutter/material.dart';

class ActionOption extends StatelessWidget {
  const ActionOption({
    super.key,
    required this.text,
    this.action,
  });
  final String text;
  final void Function()? action;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: action,
      child: Padding(
        padding: const EdgeInsets.only(right: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.star,
              size: 36,
            ),
            Text(text)
          ],
        ),
      ),
    );
  }
}
