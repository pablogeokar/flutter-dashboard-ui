import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'theme.dart';

final darkTheme = ThemeData(
  useMaterial3: true,
  textTheme: GoogleFonts.interTextTheme(AppTheme.textTheme).apply(
    bodyColor: AppTheme.secondaryDark,
    displayColor: AppTheme.secondaryDark,
  ),
  scaffoldBackgroundColor: Colors.transparent,
  colorScheme:
      ColorScheme.fromSeed(
        seedColor: AppTheme.primaryDark,
        secondary: AppTheme.secondaryDark,
        tertiary: AppTheme.neutral1,
        surface: AppTheme.surfaceDark,
        brightness: Brightness.dark,
        // Cores semânticas personalizadas
        error: AppTheme.errorDark,
        errorContainer: AppTheme.errorSurfaceDark,
      ).copyWith(
        // Extensões personalizadas usando as novas cores
        surfaceContainerHighest: AppTheme.neutral800,
        surfaceContainerHigh: AppTheme.neutral900,
        outline: AppTheme.neutral600,
        outlineVariant: AppTheme.neutral700,
      ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
  ),
  // Configurações de componentes específicos
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 2,
      shadowColor: Colors.black.withValues(alpha: 0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.borderRadiusM),
      ),
    ),
  ),
  cardTheme: CardThemeData(
    color: AppTheme.cardBackgroundDark,
    elevation: 2, // Elevação mais sutil
    shadowColor: AppTheme.cardShadowDark,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppTheme.borderRadiusL),
      side: BorderSide(color: AppTheme.cardBorderDark, width: 1),
    ),
  ),
);
