import 'package:flutter/material.dart';
import 'package:geoquest/src/styles/app_colors.dart';

class AppTheme {
  static ThemeData appTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: backgroundColor,
    shadowColor: elementColor,
    splashColor: backgroundColor,
    appBarTheme: const AppBarTheme(
      elevation: 0.0,
      backgroundColor: backgroundColor,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: elementColor,
      shape: CircleBorder(),
      elevation: 4.0,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: backgroundColor,
      selectedItemColor: elementColor,
      unselectedItemColor: Colors.white,
      selectedLabelStyle: TextStyle(
        fontSize: 14.0,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 14.0,
      ),
    ),
  );
}
