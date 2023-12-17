import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pix_wiz/Core/components/custom_text_field.dart';
import 'package:pix_wiz/Features/auth/logic/sign_up/sign_up_cubit.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: BlocProvider.of<SignUpCubit>(context).formkey,
      child: Column(
        children: [
          CustomTextField(
            hintText: "Username",
            icon: Icons.person_outline,
            onSaved: (value) {
              BlocProvider.of<SignUpCubit>(context).fields.name = value;
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please Enter Your Username";
              }
              return BlocProvider.of<SignUpCubit>(context).messages.name;
            },
          ),
          const SizedBox(
            height: 10,
          ),
          CustomTextField(
            hintText: "Email Adderess",
            icon: Icons.email_outlined,
            onSaved: (value) {
              BlocProvider.of<SignUpCubit>(context).fields.email = value;
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please Enter Your Email";
              }
              return BlocProvider.of<SignUpCubit>(context).messages.email;
            },
          ),
          const SizedBox(
            height: 10,
          ),
          CustomTextField(
            hintText: "Password",
            icon: Icons.lock_outline,
            isPassword: true,
            onSaved: (value) {
              BlocProvider.of<SignUpCubit>(context).fields.pass = value;
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please Enter Your Password";
              }
              return BlocProvider.of<SignUpCubit>(context).messages.pass;
            },
          ),
          const SizedBox(
            height: 10,
          ),
          CustomTextField(
            hintText: "Confirm Password",
            icon: Icons.lock_outline,
            isPassword: true,
            onSaved: (value) {
              BlocProvider.of<SignUpCubit>(context).fields.conPass = value;
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please Confirm Your Password";
              }
              return BlocProvider.of<SignUpCubit>(context).messages.conPass;
            },
          ),
        ],
      ),
    );
  }
}
