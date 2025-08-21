import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legumlex_customer/common/components/dialog/exit_dialog.dart';

class WillPopWidget extends StatelessWidget {
  final Widget child;
  final String nextRoute;

  const WillPopWidget({super.key, required this.child, this.nextRoute = ''});

  @override
  Widget build(BuildContext context) {
    return PopScope(
        onPopInvoked: (didPop) async {
          if (nextRoute.isEmpty) {
            showExitDialog(context);
          } else {
            Get.offAndToNamed(nextRoute);
          }
        },
        child: child);
  }
}
