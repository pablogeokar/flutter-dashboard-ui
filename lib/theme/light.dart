import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'theme.dart';

final lightTheme = ThemeData(
  useMaterial3: true,
  textTheme: GoogleFonts.interTextTheme(AppTheme.textTheme).apply(
    bodyColor: AppTheme.secondaryLight,
    displayColor: AppTheme.secondaryLight,
  ),
  scaffoldBackgroundColor: Colors.transparent,
  colorScheme:
      ColorScheme.fromSeed(
        seedColor: AppTheme.primaryLight,
        secondary: AppTheme.secondaryLight,
        tertiary: AppTheme.neutral1,
        surface: AppTheme.surfaceLight,
        brightness: Brightness.light,
        // Cores semânticas personalizadas
        error: AppTheme.errorLight,
        errorContainer: AppTheme.errorSurfaceLight,
      ).copyWith(
        // Extensões personalizadas usando as novas cores
        surfaceContainerHighest: AppTheme.neutral100,
        surfaceContainerHigh: AppTheme.neutral50,
        outline: AppTheme.neutral300,
        outlineVariant: AppTheme.neutral200,
      ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
  ),
  // Configurações de componentes específicos
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 2,
      shadowColor: Colors.black.withValues(alpha: 0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.borderRadiusM),
      ),
    ),
  ),
  cardTheme: CardThemeData(
    color: AppTheme.cardBackgroundLight,
    elevation: 2, // Elevação mais sutil
    shadowColor: AppTheme.cardShadowLight,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppTheme.borderRadiusL),
      side: BorderSide(color: AppTheme.cardBorderLight, width: 1),
    ),
  ),
);
