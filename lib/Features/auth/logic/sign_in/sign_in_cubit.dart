import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInInitial());
  GlobalKey<FormState> formkey = GlobalKey();
  SignInFields fields = SignInFields();
  void signIn() async {
    emit(SignInLoading());
    if (!formkey.currentState!.validate()) {
      emit(SignInInitial());
      return;
    }

    formkey.currentState!.save();
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: fields.email!,
        password: fields.pass!,
      );
      emit(SignInSuccess());
    } on FirebaseAuthException catch (_) {
      emit(SignInFailure());
    } catch (e) {
      emit(SignInError());
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      emit(SignInLoading());

      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      print(FirebaseAuth.instance.currentUser!.displayName);

      emit(SignInSuccess());
    } catch (e) {
      emit(SignInError());
    }
  }

  Future<void> signInWithFacebook() async {
    try {
      emit(SignInLoading());
      final LoginResult loginResult = await FacebookAuth.instance.login();

      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
      emit(SignInSuccess());
    } catch (e) {
      emit(SignInError());
    }
  }

  Future<String?> forgotPassword() async {
    try {
      emit(SignInLoading());

      formkey.currentState!.save();

      if (fields.email != null && fields.email!.isNotEmpty) {
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: fields.email!);

        emit(SignInInitial());
        return "success";
      } else {
        emit(SignInInitial());
        return "email-empty";
      }
    } on FirebaseException catch (e) {
      emit(SignInInitial());
      return e.code;
    } catch (e) {
      emit(SignInInitial());
      return null;
    }
  }
}

class SignInFields {
  String? email;
  String? pass;
}
