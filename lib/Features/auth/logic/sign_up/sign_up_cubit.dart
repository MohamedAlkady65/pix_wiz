import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());

  GlobalKey<FormState> formkey = GlobalKey();
  SignUpFields fields = SignUpFields();
  SignUpErrorMessages messages = SignUpErrorMessages();

  void signIn() async {
    messages.reset();
    emit(SignUpLoading());
    if (!formkey.currentState!.validate()) {
      emit(SignUpInitial());
      return;
    }
    formkey.currentState!.save();
    if (fields.pass != fields.conPass) {
      messages.conPass = "Passwords are not match";
      formkey.currentState!.validate();
      emit(SignUpFailure());
      return;
    }
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: fields.email!,
        password: fields.pass!,
      );
      await FirebaseAuth.instance.currentUser!.updateDisplayName(fields.name);

      emit(SignUpSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        messages.pass = "Passwords is too weak";
      } else if (e.code == 'email-already-in-use') {
        messages.email = "An account with this email already exists";
      } else if (e.code == 'invalid-email') {
        messages.email = "Please enter valid email";
      }
      formkey.currentState!.validate();
      emit(SignUpFailure());
    } catch (e) {
      emit(SignUpError());
    }
  }
}

class SignUpFields {
  String? name;
  String? email;
  String? pass;
  String? conPass;
}

class SignUpErrorMessages {
  String? name;
  String? email;
  String? pass;
  String? conPass;

  void reset() {
    name = email = pass = conPass = null;
  }
}
