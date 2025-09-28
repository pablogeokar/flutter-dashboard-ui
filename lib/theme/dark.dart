import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'theme.dart';

final darkTheme = ThemeData(
  useMaterial3: true,
  textTheme: GoogleFonts.interTextTheme(AppTheme.textTheme).apply(
    bodyColor: AppTheme.secondaryDark,
    displayColor: AppTheme.secondaryDark,
  ),
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppTheme.primaryDark,
    secondary: AppTheme.secondaryDark,
    tertiary: AppTheme.neutral1,
    surface: AppTheme.surfaceDark,
    brightness: Brightness.dark,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
  ),
);
