import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pix_wiz/Core/colors.dart';
import 'package:pix_wiz/Core/components/custom_button.dart';
import 'package:pix_wiz/Core/components/logo.dart';
import 'package:pix_wiz/Features/edit/logic/edit/edit_image_cubit.dart';
import 'package:pix_wiz/Features/edit/presentation/edit/edit_screen.dart';
import 'widgets/home_app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 10,
              ),
              const HomeAppBar(),
              const Spacer(
                flex: 1,
              ),
              const Logo(
                size: 250,
              ),
              const Spacer(
                flex: 1,
              ),
              const Text(
                "Choose To Select Photo",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 30,
              ),
              CustomButton(
                text: 'Camera',
                onPressed: () {
                  pickImage(context, source: ImageSource.camera);
                },
              ),
              const SizedBox(
                height: 20,
              ),
              CustomButton(
                text: 'Gallery',
                onPressed: () {
                  pickImage(context, source: ImageSource.gallery);
                },
              ),
              const Spacer(
                flex: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> pickImage(BuildContext context,
      {required ImageSource source}) async {
    bool success = await BlocProvider.of<EditImageCubit>(context)
        .pickImage(source: source);
    if (success) {
      // ignore: use_build_context_synchronously
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const EditScreen(),
          ));
    }
  }
}
