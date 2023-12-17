// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pix_wiz/Core/components/custom_button.dart';
import 'package:pix_wiz/Core/components/logo.dart';
import 'package:pix_wiz/Features/auth/logic/sign_up/sign_up_cubit.dart';
import 'package:pix_wiz/Features/auth/presentation/sign_up/widgets/sign_up_form.dart';
import 'package:pix_wiz/Features/home/home_screen.dart';

class SignUpBody extends StatelessWidget {
  const SignUpBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpCubit, SignUpState>(
      listener: consumerListener,
      builder: (context, state) {
        return SingleChildScrollView(
          child: AbsorbPointer(
            absorbing: state is SignUpLoading,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Logo(
                    size: 150,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Sign Up",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Please Sign Up to continue using PixWiz Editor",
                    style: TextStyle(
                      color: Color(0xFFA9A9A9),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const SignUpForm(),
                  const SizedBox(
                    height: 20,
                  ),
                  signUpButton(context, state),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Have already an account?",
                        style: TextStyle(fontSize: 18),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Sign In',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void consumerListener(context, state) {
    if (state is SignUpSuccess) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ));
    }
  }

  CustomButton signUpButton(BuildContext context, SignUpState state) {
    return CustomButton(
      text: "Sign Up",
      onPressed: () {
        FocusScope.of(context).unfocus();
        BlocProvider.of<SignUpCubit>(context).signIn();
      },
      isLoading: state is SignUpLoading,
    );
  }
}
