import 'package:flutter/material.dart';
import 'package:geoquest/src/styles/app_theme.dart';
import 'package:geoquest/src/views/home/home_view.dart';
import 'package:geoquest/src/views/quiz/quiz_view.dart';
import 'package:geoquest/src/views/quiz/result_quiz_view.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'GeoQuest',
      theme: AppTheme.appTheme,
      initialRoute: "/home",
      getPages: [
        GetPage(name: "/home", page: () => const HomeView()),
        GetPage(name: "/quiz", page: () => const QuizView()),
        GetPage(name: "/result", page: () => const ResultQuizView()),
      ],
    );
  }
}
