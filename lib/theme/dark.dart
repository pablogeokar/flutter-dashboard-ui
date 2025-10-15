import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'theme.dart';

final darkTheme = ThemeData(
  useMaterial3: true,
  textTheme: GoogleFonts.interTextTheme(AppTheme.textTheme).apply(
    bodyColor: AppTheme.textPrimaryDark,
    displayColor: AppTheme.textPrimaryDark,
  ),
  scaffoldBackgroundColor: Colors.transparent,
  colorScheme: const ColorScheme.dark().copyWith(
    primary: AppTheme.primaryDark,
    secondary: AppTheme.textPrimaryDark,
    tertiary: AppTheme.neutral1,
    surface: AppTheme.surfaceDark,
    error: AppTheme.errorDark,
    errorContainer: AppTheme.errorSurfaceDark,
    // Extensões personalizadas usando as novas cores dark refinadas
    surfaceContainerLow: const Color(
      0xFF1E293B,
    ), // Slate 800 para área de conteúdo
    surfaceContainerHighest: AppTheme.neutral800,
    surfaceContainerHigh: AppTheme.neutral900,
    outline: AppTheme.neutral600,
    outlineVariant: AppTheme.neutral700,
    // Cores específicas para status fiscal dark
    onPrimary: Colors.white,
    onSecondary: AppTheme.neutral900,
    onError: Colors.white,
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
    elevation: 0, // Sem elevação no dark
    shadowColor: AppTheme.cardShadowDark,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8), // border-radius: 8px
      side: BorderSide(
        color: AppTheme.cardBorderDark,
        width: 1,
      ), // Borda fina no dark
    ),
  ),
);
