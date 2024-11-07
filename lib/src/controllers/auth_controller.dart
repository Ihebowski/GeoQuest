import 'package:flutter/material.dart';
import 'package:geoquest/src/services/auth_service.dart';
import 'package:geoquest/src/styles/app_colors.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  var isLoggedIn = false.obs;

  final AuthService authService = AuthService();

  var username = ''.obs;
  var phoneNumber = ''.obs;
  var email = ''.obs;
  var password = ''.obs;

  Future<void> registerUser() async {
    try {
      isLoading.value = true;

      if (email.value.isEmpty ||
          password.value.isEmpty ||
          username.value.isEmpty ||
          phoneNumber.value.isEmpty) {
        Get.snackbar(
          "Input Error",
          "All fields are required.",
          colorText: Colors.white,
          backgroundColor: elementBackgroundColor.withOpacity(0.7),
        );
        return;
      }

      final emailRegex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
      if (!emailRegex.hasMatch(email.value)) {
        Get.snackbar(
          "Invalid Email",
          "Please enter a valid email address.",
          colorText: Colors.white,
          backgroundColor: elementBackgroundColor.withOpacity(0.7),
        );
        return;
      }

      if (phoneNumber.value.length != 8 || !phoneNumber.value.isNumericOnly) {
        Get.snackbar(
          "Invalid Phone Number",
          "Phone number should be exactly 8 digits.",
          colorText: Colors.white,
          backgroundColor: elementBackgroundColor.withOpacity(0.7),
        );
        return;
      }

      if (password.value.length < 6) {
        Get.snackbar(
          "Weak Password",
          "Password must be at least 6 characters long.",
          colorText: Colors.white,
          backgroundColor: elementBackgroundColor.withOpacity(0.7),
        );
        return;
      }

      bool usernameExists =
          await authService.checkUsernameExists(username.value);
      if (usernameExists) {
        Get.snackbar(
          "Username Unavailable",
          "The username is already taken. Please choose another one.",
          colorText: Colors.white,
          backgroundColor: elementBackgroundColor.withOpacity(0.7),
        );
        return;
      }

      var user = await authService.registerUser(
        email.value,
        password.value,
        username.value,
        phoneNumber.value,
      );

      if (user != null) {
        await Future.delayed(const Duration(seconds: 1));
        await authService.saveUser(user.uid);
        isLoggedIn.value = true;
        Get.snackbar(
          "Registration Successful!",
          "Welcome aboard! You are now registered and ready to explore the app!",
          colorText: Colors.white,
          backgroundColor: elementBackgroundColor.withOpacity(0.7),
        );
        Get.offAllNamed('/main');
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        colorText: Colors.white,
        backgroundColor: elementBackgroundColor.withOpacity(0.7),
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loginUser() async {
    try {
      isLoading.value = true;

      if (email.value.isEmpty || password.value.isEmpty) {
        Get.snackbar(
          "Input Error",
          "Email and password cannot be empty.",
          colorText: Colors.white,
          backgroundColor: elementBackgroundColor.withOpacity(0.7),
        );
        return;
      }

      final emailRegex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
      if (!emailRegex.hasMatch(email.value)) {
        Get.snackbar(
          "Invalid Email",
          "Please enter a valid email address.",
          colorText: Colors.white,
          backgroundColor: elementBackgroundColor.withOpacity(0.7),
        );
        return;
      }

      var user = await authService.loginUser(email.value, password.value);
      if (user != null) {
        await Future.delayed(const Duration(seconds: 1));
        await authService.saveUser(user.uid);
        isLoggedIn.value = true;
        Get.snackbar(
          "Welcome Back!",
          "You are successfully logged in. Enjoy your experience!",
          colorText: Colors.white,
          backgroundColor: elementBackgroundColor.withOpacity(0.7),
        );
        Get.offAllNamed('/main');
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        colorText: Colors.white,
        backgroundColor: elementBackgroundColor.withOpacity(0.7),
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logoutUser() async {
    try {
      isLoading.value = true;
      await Future.delayed(const Duration(seconds: 1));
      await authService.logoutUser();
      await authService.clearUser();
      isLoggedIn.value = false;
      Get.offAllNamed('/login');
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        colorText: Colors.white,
        backgroundColor: elementBackgroundColor.withOpacity(0.7),
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> checkLoggedInUser() async {
    await Future.delayed(const Duration(seconds: 3));
    String? uid = await authService.getSavedUser();
    if (uid != null) {
      isLoggedIn.value = true;
      Get.snackbar(
        "Welcome Back!",
        "You are successfully logged in. Enjoy your experience!",
        colorText: Colors.white,
        backgroundColor: elementBackgroundColor.withOpacity(0.7),
      );
      Get.offAndToNamed('/main');
    } else {
      isLoggedIn.value = false;
      Get.snackbar(
        "Access Denied!",
        "You are not logged in. Please log in to continue.",
        colorText: Colors.white,
        backgroundColor: elementBackgroundColor.withOpacity(0.7),
      );
      Get.offAndToNamed('/login');
    }
  }
}
