import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:geoquest/src/controllers/auth_controller.dart';
import 'package:geoquest/src/styles/app_colors.dart';
import 'package:get/get.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();
    return Scaffold(
      body: Column(
        children: [
          GestureDetector(
            onTap: authController.logoutUser,
            child: const CircleAvatar(
              radius: 28.0,
              backgroundColor: primaryColor,
              child: Icon(
                FluentIcons.person_24_filled,
                color: Colors.white,
                size: 38.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
