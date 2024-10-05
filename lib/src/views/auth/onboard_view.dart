import 'package:flutter/material.dart';
import 'package:geoquest/src/styles/app_colors.dart';
import 'package:get/get.dart';

class OnboardView extends StatelessWidget {
  const OnboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Text(
              "GeoQuest",
              style: TextStyle(
                fontSize: 28.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 25.0),
            const Text(
              textAlign: TextAlign.justify,
              "Welcome to GeoQuest! Test your knowledge of countries, flags, and capitals as you explore the world. Let the adventure begin!",
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w300,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 40.0),
            GestureDetector(
              onTap: () {
                Get.offAllNamed("/loading");
              },
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
                    "Get Started",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
