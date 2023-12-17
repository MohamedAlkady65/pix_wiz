import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pix_wiz/Core/colors.dart';
import 'package:pix_wiz/Features/auth/logic/sign_up/sign_up_cubit.dart';
import 'package:pix_wiz/Features/auth/presentation/sign_up/widgets/sign_up_body.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

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
            create: (context) => SignUpCubit(),
            child: const SignUpBody(),
          ),
        ),
      ),
    );
  }
}
