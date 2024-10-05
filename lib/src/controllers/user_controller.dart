import 'package:flutter/material.dart';
import 'package:geoquest/src/models/user_model.dart';
import 'package:geoquest/src/services/user_service.dart';
import 'package:geoquest/src/styles/app_colors.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  var isLoading = false.obs;
  var userModel = Rxn<UserModel>();
  final UserService userService = UserService();

  Future<void> loadUserData() async {
    try {
      isLoading.value = true;
      userModel.value = null;
      UserModel? data = await userService.getUserData();
      if (data != null) {
        userModel.value = data;
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

  Future<void> saveUserData(UserModel userModel) async {
    try {
      await userService.saveUserData(userModel);
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        colorText: Colors.white,
        backgroundColor: elementBackgroundColor.withOpacity(0.7),
      );
    }
  }

  Future<void> updateGamePoints(int newGamePoints) async {
    if (userModel.value != null) {
      int currentPoints = userModel.value!.gamePoints;
      int pointsToAdd = newGamePoints;

      userModel.update((model) {
        model?.gamePoints = currentPoints + pointsToAdd;
      });

      try {
        await userService.updateUserGamePoints(
            userModel.value!.uid, userModel.value!.gamePoints);
      } catch (e) {
        Get.snackbar(
          "Error",
          e.toString(),
          colorText: Colors.white,
          backgroundColor: elementBackgroundColor.withOpacity(0.7),
        );
      }
    }
  }

  Future<void> updateGameRanks() async {
    try {
      isLoading.value = true;
      await userService.updateGameRanks();
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
}
