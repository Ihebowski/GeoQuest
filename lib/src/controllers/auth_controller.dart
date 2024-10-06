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
        Get.offAllNamed('/');
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
        Get.offAllNamed('/');
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
    await Future.delayed(const Duration(seconds: 1));
    String? uid = await authService.getSavedUser();
    if (uid != null) {
      isLoggedIn.value = true;
      Get.snackbar(
        "Welcome Back!",
        "You are successfully logged in. Enjoy your experience!",
        colorText: Colors.white,
        backgroundColor: elementBackgroundColor.withOpacity(0.7),
      );
      Get.offAllNamed('/');
    } else {
      isLoggedIn.value = false;
      Get.snackbar(
        "Access Denied!",
        "You are not logged in. Please log in to continue.",
        colorText: Colors.white,
        backgroundColor: elementBackgroundColor.withOpacity(0.7),
      );
      Get.offAllNamed('/login');
    }
  }
}
