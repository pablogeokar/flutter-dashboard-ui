import 'package:flutter/material.dart';
import 'theme.dart';

final lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppTheme.primary,
    secondary: AppTheme.secondary,
    tertiary: AppTheme.neutral1,
    brightness: Brightness.light,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
  ),
);
