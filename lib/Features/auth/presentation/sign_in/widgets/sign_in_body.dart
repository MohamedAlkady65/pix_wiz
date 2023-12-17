// ignore_for_file: use_build_context_synchronously

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pix_wiz/Core/colors.dart';
import 'package:pix_wiz/Core/components/custom_button.dart';
import 'package:pix_wiz/Core/components/logo.dart';
import 'package:pix_wiz/Core/helper/dialog.dart';
import 'package:pix_wiz/Features/auth/logic/sign_in/sign_in_cubit.dart';
import 'package:pix_wiz/Features/auth/presentation/sign_in/widgets/sign_in_form.dart';
import 'package:pix_wiz/Features/auth/presentation/sign_in/widgets/social_buttons.dart';
import 'package:pix_wiz/Features/auth/presentation/sign_up/sign_up_screen.dart';
import 'package:pix_wiz/Features/home/home_screen.dart';

class SignInBody extends StatelessWidget {
  const SignInBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInCubit, SignInState>(
      listener: consumerListener,
      builder: (context, state) {
        return SingleChildScrollView(
          child: AbsorbPointer(
            absorbing: state is SignInLoading,
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
                    "Sign In",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Please Login to continue using PixWiz Editor",
                    style: TextStyle(
                      color: Color(0xFFA9A9A9),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const SignInForm(),
                  const SizedBox(
                    height: 5,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: () {
                        forgotPassword(context);
                      },
                      child: const Text(
                        'Forgot Password ?',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ...failureMessage(state),
                  const SizedBox(
                    height: 10,
                  ),
                  signInButton(context, state),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Or Login with",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SocialButtons(),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account",
                        style: TextStyle(fontSize: 18),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignUpScreen(),
                                ));
                          },
                          child: const Text(
                            'Sign Up',
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

  void forgotPassword(BuildContext context) async {
    final msg = await BlocProvider.of<SignInCubit>(context).forgotPassword();
    if (msg == 'success') {
      awesomeDialog(
        context: context,
        title: 'Forgot Password',
        message: 'We have sent password reset link to your email address',
        type: DialogType.success,
      );
    } else if (msg == 'email-empty') {
      awesomeDialog(
        context: context,
        title: 'Forgot Password',
        message: 'Please enter your email address',
        type: DialogType.warning,
      );
    } else if (msg == 'user-not-found') {
      awesomeDialog(
        context: context,
        title: 'Forgot Password',
        message: 'No account exists for this email',
        type: DialogType.warning,
      );
    } else if (msg == 'invalid-email') {
      awesomeDialog(
        context: context,
        title: 'Forgot Password',
        message: 'Please enter valid email address',
        type: DialogType.warning,
      );
    } else {
      awesomeDialog(
        context: context,
        title: 'Oops!',
        message: 'Something went wrong',
        type: DialogType.warning,
      );
    }
  }



  void consumerListener(context, state) {
    if (state is SignInSuccess) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ));
    }
  }

  CustomButton signInButton(BuildContext context, SignInState state) {
    return CustomButton(
      text: "Sign In",
      onPressed: () {
        FocusScope.of(context).unfocus();
        BlocProvider.of<SignInCubit>(context).signIn();
      },
      isLoading: state is SignInLoading,
    );
  }

  List<Widget> failureMessage(SignInState state) {
    return state is SignInFailure
        ? [
            const Text(
              "Email or Password is incorrect",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: kRedColor, fontSize: 16, fontWeight: FontWeight.w600),
            )
          ]
        : [];
  }
}
