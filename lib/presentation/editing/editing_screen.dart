import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pix_wiz/logic/cubit/edit_image_cubit.dart';
import 'package:pix_wiz/presentation/editing/widgets/custom_app_bar.dart';
import 'package:pix_wiz/presentation/editing/widgets/custom_bottom_bar.dart';
import 'package:pix_wiz/presentation/editing/widgets/image_view.dart';

class EditingScreen extends StatefulWidget {
  const EditingScreen({super.key});
  @override
  State<EditingScreen> createState() => _EditingScreenState();
}

class _EditingScreenState extends State<EditingScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (value) {
        BlocProvider.of<EditImageCubit>(context).goBack(context);
      },
      child: const Scaffold(
        appBar: CustomAppBar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ImageView(),
          ],
        ),
        bottomNavigationBar: CustomBottomBar(),
      ),
    );
  }
}
