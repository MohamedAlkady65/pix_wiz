import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pix_wiz/Features/crop/logic/crop/crop_cubit.dart';
import 'package:pix_wiz/Features/edit/logic/edit/edit_image_cubit.dart';
import 'package:pix_wiz/Features/filters/logic/filters/filters_cubit.dart';
import 'package:pix_wiz/Features/Home/home_screen.dart';
import 'package:pix_wiz/Features/operations/logic/operations/operations_cubit.dart';

void main() {
  runApp(const PixWiz());
}

class PixWiz extends StatelessWidget {
  const PixWiz({super.key});

  @override
  Widget build(BuildContext context) {
    final EditImageCubit editImageCubit = EditImageCubit();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => editImageCubit),
        BlocProvider(
            create: (BuildContext context) =>
                FiltersCubit(editImageCubit: editImageCubit)),
        BlocProvider(
            create: (BuildContext context) =>
                OperationsCubit(editImageCubit: editImageCubit)),
        BlocProvider(
            create: (BuildContext context) =>
                CropCubit(editImageCubit: editImageCubit)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: const HomeScreen(),
      ),
    );
  }
}
