import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryBlue = Color(0xFF428BCA);
  static const Color navbarBg = Color(0xFFDBEAF9);
  static const Color navbarText = Color(0xFF1A5276);
  static const Color navbarActive = Color(0xFF00A2E8);
  static const Color titleBlue = Color(0xFF3AB0E2);
  static const Color titleGreen = Color(0xFF5CB85C);
  static const Color titleYellow = Color(0xFFF0AD4E);
  static const Color btnGreen = Color(0xFF5CB85C);
  static const Color btnGreenHover = Color(0xFF4CAE4C);
  static const Color footerBg = Color(0xFF005C8A);
  static const Color scaffoldBg = Color(0xFFFAFDFC);
  static const Color panelHeaderBlue = Color(0xFF63B2F5);
  static const Color textDark = Color(0xFF4A4A4A);
  static const Color textMuted = Color(0xFF777777);
  static const Color borderGray = Color(0xFFE5E9EC);
}

ThemeData buildAppTheme() {
  return ThemeData(
    primaryColor: AppColors.primaryBlue,
    scaffoldBackgroundColor: AppColors.scaffoldBg,
    useMaterial3: true,
    fontFamily: 'Open Sans',
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.textDark, fontSize: 13, height: 1.6),
      bodyMedium: TextStyle(color: AppColors.textDark, fontSize: 13, height: 1.6),
      titleLarge: TextStyle(color: AppColors.primaryBlue, fontSize: 18, fontWeight: FontWeight.bold),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      isDense: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(color: Color(0xFFCCCCCC)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(color: Color(0xFFCCCCCC)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(color: AppColors.titleBlue, width: 1.5),
      ),
    ),
  );
}
