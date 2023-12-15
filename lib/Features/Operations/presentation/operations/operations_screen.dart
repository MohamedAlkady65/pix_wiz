import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pix_wiz/Features/edit/logic/edit/edit_image_cubit.dart';
import 'package:pix_wiz/Features/operations/logic/operations/operations_cubit.dart';
import 'package:pix_wiz/Features/operations/presentation/operations/widgets/image_view_operations.dart';
import 'package:pix_wiz/Features/operations/presentation/operations/widgets/operations_app_bar.dart';
import 'package:pix_wiz/Features/operations/presentation/operations/widgets/operations_bottom_bar.dart';

class OperationsScreen extends StatelessWidget {
  const OperationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OperationsCubit(
          editImageCubit: BlocProvider.of<EditImageCubit>(context)),
      child: const Scaffold(
        appBar: OperationsAppbar(),
        body: ImageViewOperations(),
        bottomNavigationBar: OperationsBottomBar(),
      ),
    );
  }
}
