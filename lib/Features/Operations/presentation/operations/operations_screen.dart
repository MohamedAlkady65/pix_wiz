import 'package:flutter/material.dart';
import 'package:pix_wiz/Features/operations/presentation/operations/widgets/image_view_operations.dart';
import 'package:pix_wiz/Features/operations/presentation/operations/widgets/operations_app_bar.dart';
import 'package:pix_wiz/Features/operations/presentation/operations/widgets/operations_bottom_bar.dart';

class OperationsScreen extends StatelessWidget {
  const OperationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: OperationsAppbar(),
      body: ImageViewOperations(),
      bottomNavigationBar:  OperationsBottomBar(),
    );
  }
}
