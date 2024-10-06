import 'package:flutter/material.dart';
import 'package:geoquest/src/models/user_model.dart';
import 'package:geoquest/src/services/leaderboard_service.dart';
import 'package:geoquest/src/styles/app_colors.dart';
import 'package:get/get.dart';

class LeaderboardController extends GetxController {
  var leaderboardList = <UserModel>[].obs;
  var isLoading = true.obs;
  final LeaderboardService _leaderboardService = LeaderboardService();

  Future<void> fetchLeaderboard() async {
    isLoading.value = true;
    try {
      leaderboardList.clear();
      await Future.delayed(const Duration(seconds: 1));
      var entries = await _leaderboardService.fetchLeaderboard();
      leaderboardList.assignAll(entries);
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
