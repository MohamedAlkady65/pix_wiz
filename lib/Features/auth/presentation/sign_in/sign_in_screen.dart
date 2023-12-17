import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pix_wiz/Core/colors.dart';
import 'package:pix_wiz/Features/auth/logic/sign_in/sign_in_cubit.dart';
import 'package:pix_wiz/Features/auth/presentation/sign_in/widgets/sign_in_body.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: kBackgroundColor,
          body: BlocProvider(
            create: (context) => SignInCubit(),
            child: const SignInBody(),
          ),
        ),
      ),
    );
  }
}
