
  import 'package:flutter/material.dart';
import 'package:pix_wiz/Core/colors.dart';

Future<bool?> showCustomDialog(
      {required BuildContext context,
      required String title,
      required String content}) {
    return showDialog<bool>(
        context: context,
        builder: (context) => Theme(
              data: ThemeData.light(),
              child: AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                insetPadding: const EdgeInsets.symmetric(horizontal: 18),
                title: Text(
                  title,
                ),
                content: Text(
                  content,
                  style: const TextStyle(fontSize: 18),
                ),
                actions: [
                  TextButton(
                    style: TextButton.styleFrom(foregroundColor: kPrimaryColor),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: const Text(
                      'CANCEL',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(foregroundColor: kPrimaryColor),
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: const Text(
                      'OK',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ));
  }
