import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:geoquest/src/controllers/auth_controller.dart';
import 'package:geoquest/src/controllers/user_controller.dart';
import 'package:geoquest/src/models/user_model.dart';
import 'package:geoquest/src/styles/app_colors.dart';
import 'package:geoquest/src/views/home/widgets/categories_card.dart';
import 'package:get/get.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final UserController userController = Get.put(UserController(),permanent: true);
  final AuthController authController = Get.find<AuthController>();

  @override
  void initState() {
    userController.loadUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          if (userController.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(
                color: elementColor,
              ),
            );
          }

          if (userController.userModel.value == null) {
            return const Center(
              child: Text(
                'No user data available.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }

          UserModel user = userController.userModel.value!;
          return Padding(
            padding: const EdgeInsets.only(top: 40.0, left: 25.0, right: 25.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: 'Hello, ',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24.0,
                              fontWeight: FontWeight.w300,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: user.username.capitalize,
                                style: const TextStyle(
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
                Container(
                  height: 80.0,
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(vertical: 35.0),
                  padding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 25.0),
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
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                user.gamePoints.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(
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
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${user.gameRank}th",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(
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
                SizedBox(
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
                          alignment: WrapAlignment.center,
                          runAlignment: WrapAlignment.center,
                          spacing: 20.0,
                          runSpacing: 20.0,
                          children: [
                            CategoriesCard(
                              name: "Flag",
                              onTap: () => Get.toNamed("/quiz"),
                            ),
                            CategoriesCard(
                              name: "Capital",
                              onTap: () {
                                Get.snackbar(
                                  "Unavailable feature",
                                  "Sorry this feature is not available yet.",
                                  colorText: Colors.white,
                                  backgroundColor:
                                      elementBackgroundColor.withOpacity(0.7),
                                );
                              },
                            ),
                            CategoriesCard(
                              name: "Population",
                              onTap: () {
                                Get.snackbar(
                                  "Unavailable feature",
                                  "Sorry this feature is not available yet.",
                                  colorText: Colors.white,
                                  backgroundColor:
                                      elementBackgroundColor.withOpacity(0.7),
                                );
                              },
                            ),
                            CategoriesCard(
                              name: "Geo",
                              onTap: () {
                                Get.snackbar(
                                  "Unavailable feature",
                                  "Sorry this feature is not available yet.",
                                  colorText: Colors.white,
                                  backgroundColor:
                                      elementBackgroundColor.withOpacity(0.7),
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
          );
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   child: const Icon(
      //     FluentIcons.question_24_filled,
      //     color: Colors.white,
      //   ),
      // ),
    );
  }
}
