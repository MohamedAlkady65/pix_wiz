import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pix_wiz/Core/colors.dart';
import 'package:pix_wiz/Core/helper/dialog.dart';
import 'package:pix_wiz/Features/edit/logic/edit/edit_image_cubit.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final userName =
        BlocProvider.of<EditImageCubit>(context).getUserName(context);
    return Row(
      children: [
        Expanded(
          child: Text(
            "Welcome\n$userName\nTo PixWiz Editor",
            textAlign: TextAlign.left,
            style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: kPrimaryColor),
          ),
        ),
        Column(
          children: [
            RotatedBox(
              quarterTurns: 2,
              child: IconButton(
                iconSize: 38,
                color: kPrimaryColor,
                onPressed: () async {
                  final res = await showCustomDialog(
                      context: context,
                      title: "Logout",
                      content: "Are you sure you want to logout");
                  if (res == true) {
                    // ignore: use_build_context_synchronously
                    BlocProvider.of<EditImageCubit>(context).signOut(context);
                  }
                },
                icon: const Icon(Icons.login_outlined),
              ),
            ),
            const Text(
              "Logut",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: kPrimaryColor,
              ),
            )
          ],
        )
      ],
    );
  }
}
