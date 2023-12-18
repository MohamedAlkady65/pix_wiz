// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pix_wiz/Features/auth/logic/sign_in/sign_in_cubit.dart';

class SocialButtons extends StatelessWidget {
  const SocialButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            BlocProvider.of<SignInCubit>(context).signInWithGoogle();
          },
          child: const CircleAvatar(
            backgroundColor: Colors.white,
            backgroundImage: AssetImage('assets/images/social/google.png'),
            radius: 30,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        GestureDetector(
          onTap: () {
            BlocProvider.of<SignInCubit>(context).signInWithFacebook();
          },
          child: const CircleAvatar(
            backgroundColor: Colors.white,
            backgroundImage: AssetImage('assets/images/social/facebook.png'),
            radius: 30,
          ),
        ),
      ],
    );
  }
}
