import 'package:flutter/material.dart';
import 'package:geoquest/src/controllers/quiz_controller.dart';
import 'package:get/get.dart';
import 'package:geoquest/src/styles/app_colors.dart';

class AnswerTile extends StatelessWidget {
  final String text;

  const AnswerTile({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final QuizController quizController = Get.find();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Obx(() {
        bool isSelected = quizController.selectedOption.value == text;

        return GestureDetector(
          onTap: () {
            quizController.selectOption(text);
          },
          child: Container(
            height: 50.0,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            decoration: BoxDecoration(
              color: isSelected ? Colors.blue.withOpacity(0.2) : Colors.white,
              border: Border.all(
                color: isSelected ? Colors.blue : Colors.black.withOpacity(0.2),
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                text,
                textAlign: TextAlign.start,
                overflow: TextOverflow.clip,
                softWrap: false,
                maxLines: 1,
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 18.0,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
