import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pix_wiz/Core/colors.dart';
import 'package:pix_wiz/Features/auth/presentation/sign_in/sign_in_screen.dart';
import 'package:pix_wiz/Features/edit/logic/edit/edit_image_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pix_wiz/Features/home/home_screen.dart';
import 'firebase_options.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const PixWiz());
}

class PixWiz extends StatelessWidget {
  const PixWiz({super.key});

  @override
  Widget build(BuildContext context) {
    final initialPage = FirebaseAuth.instance.currentUser == null
        ? const SignInScreen()
        : const HomeScreen();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => EditImageCubit(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          textTheme: GoogleFonts.robotoTextTheme(),
          colorScheme: ColorScheme.fromSwatch(primarySwatch: primaryColor),
        ),
        debugShowCheckedModeBanner: false,
        home: initialPage,
      ),
    );
  }
}
