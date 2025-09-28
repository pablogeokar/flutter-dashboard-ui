import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'theme.dart';

final lightTheme = ThemeData(
  useMaterial3: true,
  textTheme: GoogleFonts.interTextTheme(AppTheme.textTheme).apply(
    bodyColor: AppTheme.secondaryLight,
    displayColor: AppTheme.secondaryLight,
  ),
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppTheme.primaryLight,
    secondary: AppTheme.secondaryLight,
    tertiary: AppTheme.neutral1,
    surface: AppTheme.surfaceLight,
    brightness: Brightness.light,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
  ),
);
