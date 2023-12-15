import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pix_wiz/Features/edit/logic/edit/edit_image_cubit.dart';
import 'package:pix_wiz/Features/home/home_screen.dart';

void main() {
  runApp(const PixWiz());
}

class PixWiz extends StatelessWidget {
  const PixWiz({super.key});

  @override
  Widget build(BuildContext context) {
    final EditImageCubit editImageCubit = EditImageCubit();
    return BlocProvider(
      create: (context) => editImageCubit,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: const HomeScreen(),
      ),
    );
  }
}
