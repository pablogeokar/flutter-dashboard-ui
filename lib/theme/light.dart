import 'package:flutter/material.dart';
import 'theme.dart';

final lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppTheme.primary,
    secondary: AppTheme.secondary,
    tertiary: AppTheme.neutral1,
    surface: AppTheme.surfaceLight,
    brightness: Brightness.light,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
  ),
);
