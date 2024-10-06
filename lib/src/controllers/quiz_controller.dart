import 'package:flutter/material.dart';
import 'package:geoquest/src/controllers/user_controller.dart';
import 'package:geoquest/src/models/question_model.dart';
import 'package:geoquest/src/services/question_service.dart';
import 'package:geoquest/src/styles/app_colors.dart';
import 'package:get/get.dart';

class QuizController extends GetxController {
  final QuestionService questionService = QuestionService();

  RxList<QuestionModel> questions = <QuestionModel>[].obs;
  RxInt currentQuestionIndex = 0.obs;
  var selectedOption = Rx<String?>(null);
  RxInt score = 0.obs;

  RxBool isLoading = true.obs;

  void loadQuestions() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      var generatedQuestions = await questionService.generateRandomQuestions();
      questions.value = generatedQuestions;
      isLoading.value = false;
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        colorText: Colors.white,
        backgroundColor: elementBackgroundColor.withOpacity(0.7),
      );
      isLoading.value = false;
    }
  }

  void nextQuestion() async {
    if (selectedOption.value == null) {
      Get.snackbar(
        "No Answer Selected",
        "Please select an answer before proceeding.",
        colorText: Colors.white,
        backgroundColor: elementBackgroundColor.withOpacity(0.7),
      );
      return;
    } else {
      checkAnswer(selectedOption.value!);

      if (currentQuestionIndex.value < questions.length - 1) {
        currentQuestionIndex.value += 1;
        selectedOption.value = null;
      } else {
        isLoading.value = true;
        await updateGamePointsAndNavigate();
      }
      isLoading.value = false;
    }
  }

  void selectOption(String option) {
    selectedOption.value = option;
  }

  void checkAnswer(String answer) {
    if (answer == currentQuestion.correctAnswer) {
      score.value += 10;
      Get.snackbar(
        "Correct Answer!",
        "Great job! You got it right. Keep it up!",
        colorText: Colors.white,
        backgroundColor: elementBackgroundColor.withOpacity(0.7),
      );
    } else {
      Get.snackbar(
        "Incorrect Answer!",
        "Oops! That’s not quite right. Don’t give up—try again!",
        colorText: Colors.white,
        backgroundColor: elementBackgroundColor.withOpacity(0.7),
      );
    }
  }

  QuestionModel get currentQuestion {
    if (questions.isEmpty) {
      return QuestionModel(
        questionText: 'Loading...',
        options: [],
        correctAnswer: '',
      );
    }
    return questions[currentQuestionIndex.value];
  }

  List<String> get currentOptions {
    if (questions.isEmpty) {
      return [];
    }
    return currentQuestion.options;
  }

  Future<void> updateGamePointsAndNavigate() async {
    final UserController userController = Get.find<UserController>();
    await userController.updateGamePoints(score.value);
    await userController.updateGameRanks();
    Get.offNamed("/result");
  }
}
