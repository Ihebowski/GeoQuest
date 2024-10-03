import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:geoquest/src/styles/app_colors.dart';
import 'package:geoquest/src/views/home/widgets/categories_card.dart';
import 'package:geoquest/src/views/quiz/quiz_view.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 25.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: const TextSpan(
                        text: 'Hello, ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                          fontWeight: FontWeight.w300,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Iheb',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Text(
                      "Glad you're back",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
                CircleAvatar(
                  radius: 28.0,
                  backgroundColor: elementBackgroundColor,
                  child: Image.asset(
                    "assets/icons/user.png",
                    width: 28.0,
                  ),
                ),
              ],
            ),
            Container(
              height: 80.0,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 35.0),
              padding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
              decoration: BoxDecoration(
                color: elementBackgroundColor,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        "assets/icons/coin.png",
                        width: 25.0,
                      ),
                      const SizedBox(width: 10.0),
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "1000",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Points",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  VerticalDivider(
                    color: Colors.white.withOpacity(0.5),
                  ),
                  Row(
                    children: [
                      Image.asset(
                        "assets/icons/rank.png",
                        width: 25.0,
                      ),
                      const SizedBox(width: 10.0),
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "30th",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Ranking",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Categories",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const SizedBox(height: 25.0),
                  SizedBox(
                    width: double.infinity,
                    child: Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      children: [
                        CategoriesCard(
                          name: "Flag",
                          onTap: () => Get.offAndToNamed("/quiz"),
                        ),
                        CategoriesCard(
                          name: "Capital",
                          onTap: () {
                            Get.snackbar(
                              "Unavailable feature",
                              "Sorry this feature is not available yet.",
                              colorText: Colors.white,
                              backgroundColor: elementBackgroundColor,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(
          FluentIcons.question_24_filled,
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(FluentIcons.home_24_regular),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(FluentIcons.data_usage_20_regular),
            label: "Leaderboard",
          ),
          BottomNavigationBarItem(
            icon: Icon(FluentIcons.settings_24_regular),
            label: "Settings",
          ),
        ],
      ),
    );
  }
}
