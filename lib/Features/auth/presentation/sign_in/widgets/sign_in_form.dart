
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pix_wiz/Core/components/custom_text_field.dart';
import 'package:pix_wiz/Features/auth/logic/sign_in/sign_in_cubit.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: BlocProvider.of<SignInCubit>(context).formkey,
      child: Column(
        children: [
          CustomTextField(
            hintText: "Email Adderess",
            icon: Icons.email_outlined,
            onSaved: (value) {
              BlocProvider.of<SignInCubit>(context).fields.email = value;
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please Enter Your Email";
              }
              return null;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          CustomTextField(
            hintText: "Password",
            icon: Icons.lock_outline,
            isPassword: true,
            onSaved: (value) {
              BlocProvider.of<SignInCubit>(context).fields.pass = value;
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please Enter Your Password";
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
