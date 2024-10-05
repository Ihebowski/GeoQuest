import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:geoquest/src/controllers/auth_controller.dart';
import 'package:geoquest/src/styles/app_colors.dart';
import 'package:get/get.dart';

class LoginView extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();
  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Column(
              children: [
                Text(
                  "Welcome back",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 15.0),
                Text(
                  "Please login to your account.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                TextField(
                  textAlign: TextAlign.start,
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: Colors.white,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    decoration: TextDecoration.none,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: elementBackgroundColor,
                    labelText: "Email Address",
                    labelStyle: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 16.0,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: (value) {
                    authController.email.value = value;
                  },
                ),
                const SizedBox(height: 15.0),
                TextField(
                  textAlign: TextAlign.start,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  cursorColor: Colors.white,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    decoration: TextDecoration.none,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: elementBackgroundColor,
                    labelText: "Password",
                    labelStyle: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 16.0,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide.none,
                    ),
                    suffix: Icon(
                      FluentIcons.eye_20_regular,
                      color: Colors.white.withOpacity(0.7),
                      size: 18.0,
                    ),
                  ),
                  onChanged: (value) {
                    authController.password.value = value;
                  },
                ),
              ],
            ),
            Column(
              children: [
                GestureDetector(
                  onTap: () => authController.loginUser(),
                  child: Container(
                    height: 50.0,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    decoration: BoxDecoration(
                      color: elementColor,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: const Center(
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "You don't have an account?",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    GestureDetector(
                      onTap: () => Get.toNamed("/register"),
                      child: const Text(
                        "Register",
                        style: TextStyle(
                          color: elementColor,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
