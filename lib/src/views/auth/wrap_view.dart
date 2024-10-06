import 'package:flutter/material.dart';
import 'package:geoquest/src/controllers/auth_controller.dart';
import 'package:geoquest/src/styles/app_colors.dart';
import 'package:get/get.dart';

class WrapView extends StatelessWidget {
  const WrapView({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController =
        Get.put(AuthController(), permanent: true);

    Future.delayed(const Duration(seconds: 1), () async {
      await authController.checkLoggedInUser();
    });
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: elementColor,
        ),
      ),
    );
  }
}
