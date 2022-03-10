import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unsplashed_client/theme/app_colors.dart';

class AppTheme {
  static ThemeData appTheme = ThemeData(
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.primary,
      onPrimary: AppColors.white,
      secondary: AppColors.secondary,
      onSecondary: AppColors.white,
      error: AppColors.lightRed,
      onError: AppColors.white,
      background: AppColors.background,
      onBackground: AppColors.white,
      surface: AppColors.white,
      onSurface: AppColors.white,
    ),
    fontFamily: GoogleFonts.montserrat().fontFamily,
    focusColor: AppColors.lightPurple,
    primaryColorLight: AppColors.lightPurple,
    primaryColorDark: AppColors.primary,
    hintColor: AppColors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.background,
      centerTitle: true,
    ),
    //brightness: Brightness.dark,
    //primaryColor: AppColors.primary,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
        ),
      ),
    ),
  );

  static TextStyle heroTextStyle = const TextStyle(
    color: AppColors.lightPurple,
    fontSize: 24,
    fontWeight: FontWeight.bold,
    letterSpacing: 3,
  );
}
