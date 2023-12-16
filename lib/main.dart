import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pix_wiz/Features/edit/logic/edit/edit_image_cubit.dart';
import 'package:pix_wiz/Features/home/home_screen.dart';

void main() async {
  runApp(const PixWiz());
}

class PixWiz extends StatelessWidget {
  const PixWiz({super.key});

  @override
  Widget build(BuildContext context) {
    final EditImageCubit editImageCubit = EditImageCubit();
    return BlocProvider(
      create: (context) => editImageCubit,
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }

  MaterialColor primaryColor() {
    return const MaterialColor(0xFF2A93DA, {
      50: Color.fromRGBO(42, 147, 218, .1),
      100: Color.fromRGBO(42, 147, 218, .2),
      200: Color.fromRGBO(42, 147, 218, .3),
      300: Color.fromRGBO(42, 147, 218, .4),
      400: Color.fromRGBO(42, 147, 218, .5),
      500: Color.fromRGBO(42, 147, 218, .6),
      600: Color.fromRGBO(42, 147, 218, .7),
      700: Color.fromRGBO(42, 147, 218, .8),
      800: Color.fromRGBO(42, 147, 218, .9),
      900: Color.fromRGBO(42, 147, 218, 1),
    });
  }
}
