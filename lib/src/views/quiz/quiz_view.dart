import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geoquest/src/controllers/quiz_controller.dart';
import 'package:geoquest/src/styles/app_colors.dart';
import 'package:geoquest/src/views/quiz/widgets/answer_tile.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

class QuizView extends StatelessWidget {
  const QuizView({super.key});

  @override
  Widget build(BuildContext context) {
    final QuizController quizController = Get.put(QuizController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("10 Questions"),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            FluentIcons.chevron_left_24_filled,
            color: Colors.white,
            size: 28.0,
          ),
        ),
      ),
      body: Obx(
        () {
          if (quizController.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(
                color: elementColor,
              ),
            );
          }

          if (quizController.questions.isEmpty) {
            return const Center(
              child: Text(
                'No Quiz data found.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }

          var currentQuestion = quizController.currentQuestion;
          var options = quizController.currentOptions;

          return Container(
            height: double.infinity,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Text(
                          "Question ${quizController.currentQuestionIndex.value + 1} of 10",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: LinearProgressIndicator(
                          borderRadius: BorderRadius.circular(10.0),
                          backgroundColor: elementBackgroundColor,
                          color: elementColor,
                          minHeight: 10.0,
                          value:
                              (quizController.currentQuestionIndex.value + 1) /
                                  10,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Text(
                          currentQuestion.questionText,
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
                            color: primaryColor,
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.network(
                            currentQuestion.imageUrl ?? '',
                            height: 175.0,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: options.length,
                        itemBuilder: (context, index) {
                          return AnswerTile(text: options[index]);
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0, bottom: 5.0),
                        child: GestureDetector(
                          onTap: () {
                            quizController.nextQuestion();
                          },
                          child: Container(
                            height: 50.0,
                            width: double.infinity,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 25.0),
                            decoration: BoxDecoration(
                              color: elementColor,
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: const Center(
                              child: Text(
                                "Next",
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
              ],
            ),
          );
        },
      ),
    );
  }
}
