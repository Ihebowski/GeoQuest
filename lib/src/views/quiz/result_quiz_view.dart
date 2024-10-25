import 'dart:math';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:geoquest/src/controllers/quiz_controller.dart';
import 'package:geoquest/src/styles/app_colors.dart';
import 'package:get/get.dart';

class ResultQuizView extends StatefulWidget {
  const ResultQuizView({super.key});

  @override
  State<ResultQuizView> createState() => _ResultQuizViewState();
}

class _ResultQuizViewState extends State<ResultQuizView> {
  final QuizController quizController = Get.find<QuizController>();
  final ConfettiController confettiController = ConfettiController(
    duration: const Duration(seconds: 1),
  );

  @override
  void initState() {
    confettiController.play();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  child: Text(
                    "Congrats!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 52.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Text(
                  "You scored:",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/icons/coin.png",
                        height: 25.0,
                        width: 25.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Obx(
                          () => Text(
                            "${quizController.score.value} Points",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 32.0,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25.0),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: GestureDetector(
                    onTap: () => Get.offNamed("/main"),
                    child: Container(
                      height: 50.0,
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: const Center(
                        child: Text(
                          "Return Menu",
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: GestureDetector(
                    onTap: () => Get.offNamed("/quiz"),
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
                          "New Quiz",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              blastDirection: pi / 2,
              emissionFrequency: 0.2,
              numberOfParticles: 20,
              gravity: 0.1,
            ),
          ),
        ],
      ),
    );
  }
}
