import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geoquest/src/styles/app_theme.dart';
import 'package:geoquest/src/views/auth/login_view.dart';
import 'package:geoquest/src/views/auth/onboard_view.dart';
import 'package:geoquest/src/views/auth/register_view.dart';
import 'package:geoquest/src/views/home/home_view.dart';
import 'package:geoquest/src/views/home/leaderboard_view.dart';
import 'package:geoquest/src/views/home/main_view.dart';
import 'package:geoquest/src/views/quiz/quiz_view.dart';
import 'package:geoquest/src/views/quiz/result_quiz_view.dart';
import 'package:geoquest/src/views/splash/splash_view.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'GeoQuest',
      theme: AppTheme.appTheme,
      initialRoute: "/splash",
      getPages: [
        GetPage(name: "/onboard", page: () => const OnboardView()),
        GetPage(name: "/splash", page: () => const SplashView()),
        GetPage(name: "/register", page: () => RegisterView()),
        GetPage(name: "/login", page: () => LoginView()),
        GetPage(name: "/main", page: () => const MainView()),
        GetPage(name: "/home", page: () => const HomeView()),
        GetPage(name: "/leaderboard", page: () => const LeaderboardView()),
        GetPage(name: "/quiz", page: () => const QuizView()),
        GetPage(name: "/result", page: () => const ResultQuizView()),
      ],
    );
  }
}
