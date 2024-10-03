import 'package:flutter/material.dart';
import 'package:geoquest/src/models/question_model.dart';
import 'package:geoquest/src/services/question_service.dart';
import 'package:geoquest/src/styles/app_colors.dart';
import 'package:geoquest/src/views/quiz/result_quiz_view.dart';
import 'package:get/get.dart';

class QuizController extends GetxController {
  final QuestionService questionService = QuestionService();
  RxList<QuestionModel> questions = <QuestionModel>[].obs;
  RxInt currentQuestionIndex = 0.obs;
  var selectedOption = Rx<String?>(null);
  RxInt score = 0.obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadQuestions();
  }

  void loadQuestions() async {
    try {
      var generatedQuestions = await questionService.generateRandomQuestions();
      questions.value = generatedQuestions;
      isLoading.value = false;
    } catch (e) {
      print("Error loading questions: $e");
      isLoading.value = false;
    }
  }

  void nextQuestion() {
    if (selectedOption.value == null) {
      Get.snackbar(
        "No Answer Selected",
        "Please select an answer before proceeding.",
        colorText: Colors.white,
        backgroundColor: elementBackgroundColor,
      );
    } else {
      if (currentQuestionIndex.value < questions.length - 1) {
        currentQuestionIndex.value += 1;
        selectedOption.value = null;
      } else {
        Get.offAndToNamed("/result");
      }
    }
  }

  void selectOption(String option) {
    selectedOption.value = option;
  }

  void checkAnswer(String answer) {
    if (answer == currentQuestion.correctAnswer) {
      score.value += 10;
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

  @override
  void dispose() {
    super.dispose();
  }
}
