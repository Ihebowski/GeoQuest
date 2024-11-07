import 'package:flutter/material.dart';
import 'package:geoquest/src/controllers/leaderboard_controller.dart';
import 'package:geoquest/src/styles/app_colors.dart';
import 'package:geoquest/src/views/home/widgets/leaderboard_tile.dart';
import 'package:get/get.dart';

class LeaderboardView extends StatefulWidget {
  const LeaderboardView({super.key});

  @override
  State<LeaderboardView> createState() => _LeaderboardViewState();
}

class _LeaderboardViewState extends State<LeaderboardView> {
  final LeaderboardController leaderboardController =
      Get.put(LeaderboardController(), permanent: true);

  @override
  void initState() {
    leaderboardController.fetchLeaderboard();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Leaderboard"),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Obx(
        () {
          if (leaderboardController.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(
                color: elementColor,
              ),
            );
          }

          if (leaderboardController.leaderboardList.isEmpty) {
            return const Center(
              child: Text(
                'Failed to get leaderboard data.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }

          var leaderboard = leaderboardController.leaderboardList;

          return Container(
            height: double.infinity,
            width: double.infinity,
            padding:
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      children: [
                        CircleAvatar(
                          radius: 42.0,
                          backgroundColor: elementBackgroundColor,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Image.asset(
                              "assets/icons/second.png",
                              color: leaderboard.length > 1
                                  ? null
                                  : Colors.black.withOpacity(0.2),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          leaderboard.length > 1
                              ? (leaderboard[1].username.capitalizeFirst ?? '')
                              : "Unknown",
                          style: TextStyle(
                            color: leaderboard.length > 1
                                ? Colors.white
                                : Colors.white.withOpacity(0.2),
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        CircleAvatar(
                          radius: 58.0,
                          backgroundColor: elementBackgroundColor,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Image.asset(
                              "assets/icons/first.png",
                              color: leaderboard.isNotEmpty
                                  ? null
                                  : Colors.black.withOpacity(0.2),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          leaderboard.isNotEmpty
                              ? (leaderboard[0].username.capitalizeFirst ?? '')
                              : "Unknown",
                          style: TextStyle(
                            color: leaderboard.isNotEmpty
                                ? Colors.white
                                : Colors.white.withOpacity(0.2),
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        CircleAvatar(
                          radius: 42.0,
                          backgroundColor: elementBackgroundColor,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Image.asset(
                              "assets/icons/third.png",
                              color: leaderboard.length > 2
                                  ? null
                                  : Colors.black.withOpacity(0.2),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          leaderboard.length > 2
                              ? (leaderboard[2].username.capitalizeFirst ?? '')
                              : "Unknown",
                          style: TextStyle(
                            color: leaderboard.length > 2
                                ? Colors.white
                                : Colors.white.withOpacity(0.2),
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 25.0),
                Expanded(
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            "Rest of leaderboard",
                            style: TextStyle(
                              fontSize: 24.0,
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        if (leaderboard.isEmpty) ...[
                          const Expanded(
                            child: Center(
                              child: Text(
                                "No other players in the list.",
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                        if (leaderboard.isNotEmpty) ...[
                          ListView.separated(
                            shrinkWrap: true,
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 10.0),
                            itemCount: leaderboard.length,
                            itemBuilder: (context, index) {
                              var user = leaderboard[index];
                              return LeaderboardTile(
                                user: user.username,
                                rank: user.gameRank,
                                points: user.gamePoints,
                              );
                            },
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<LeaderboardController>();
    super.dispose();
  }
}
