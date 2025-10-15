import 'package:flutter/material.dart';

class AppTheme {
  // ==========================================================================
  // 1. CORE PALETTE
  // ==========================================================================
  // Cores base que definem a identidade da marca e textos.

  // --- Cores Primárias (Destaque da Marca) ---
  static const Color primaryLight = Color(0xFF007BFF);
  static const Color primaryDark = Color(0xFF2980b9);

  // --- Cores de Texto ---
  static const Color textPrimaryLight = Color(0xFF333333);
  static const Color textPrimaryDark = Color(0xFFE0E0E0);
  static const Color textSecondaryLight = Color(0xFF666666);
  static const Color textSecondaryDark = Color(0xFFB0B0B0);

  // --- Cores Neutras (Escala de Cinza) ---
  static const Color neutral50 = Color(0xFFf9fafb);
  static const Color neutral100 = Color(0xFFf3f4f6);
  static const Color neutral200 = Color(0xFFe5e7eb);
  static const Color neutral300 = Color(0xFFd1d5db);
  static const Color neutral400 = Color(0xFF9ca3af);
  static const Color neutral500 = Color(0xFF6b7280);
  static const Color neutral600 = Color(0xFF4b5563);
  static const Color neutral700 = Color(0xFF374151);
  static const Color neutral800 = Color(0xFF1f2937);
  static const Color neutral900 = Color(0xFF111827);

  // --- Cores Neutras Legadas (para compatibilidade) ---
  static const Color neutral1 = neutral500;
  static const Color neutral2 = neutral700;

  // ==========================================================================
  // 2. SEMANTIC COLORS
  // ==========================================================================
  // Cores que comunicam significado (sucesso, erro, etc.).

  // --- Sucesso (Verde) ---
  static const Color successLight = Color(0xFF059669);
  static const Color successDark = Color(0xFF10b981);
  static const Color successSurfaceLight = Color(0xFFecfdf5);
  static const Color successSurfaceDark = Color(0xFF064e3b);

  // --- Erro (Vermelho) ---
  static const Color errorLight = Color(0xFFDC2626);
  static const Color errorDark = Color(0xFFef4444);
  static const Color errorSurfaceLight = Color(0xFFfef2f2);
  static const Color errorSurfaceDark = Color(0xFF7f1d1d);

  // --- Aviso (Laranja) ---
  static const Color warningLight = Color(0xFFD97706);
  static const Color warningDark = Color(0xFFf59e0b);
  static const Color warningSurfaceLight = Color(0xFffffbeb);
  static const Color warningSurfaceDark = Color(0xFF78350f);

  // --- Informação (Azul) ---
  static const Color infoLight = Color(0xFF3b82f6);
  static const Color infoDark = Color(0xFF60a5fa);
  static const Color infoSurfaceLight = Color(0xFFeff6ff);
  static const Color infoSurfaceDark = Color(0xFF1e3a8a);

  // ==========================================================================
  // 3. UI COMPONENT COLORS
  // ==========================================================================
  // Cores para elementos específicos da interface.

  // --- Fundo da Tela (Surface) ---
  static const Color surfaceLight = Color(0xFFE8EDF3);
  static const Color surfaceDark = Color(0xFF121212);

  // --- Drawer (Barra Lateral) ---
  static const Color drawerBackgroundLight = Color(0xFFDCE4EC);
  static const Color drawerBackgroundDark = Color(0xFF191919);

  // --- Cards e Containers ---
  static const Color cardBackgroundLight = Color(0xFFFFFFFF);
  static const Color cardBorderLight = Colors.transparent;
  static const Color cardShadowLight = Color(0x0A000000);
  static const Color cardBackgroundDark = Color(0xFF1E1E1E);
  static const Color cardBorderDark = Color(0xFF2F2F2F);
  static const Color cardShadowDark = Colors.transparent;

  // --- Campos de Formulário ---
  static const Color formFieldBackgroundLight = AppTheme.neutral50;
  static const Color formFieldBorderLight = AppTheme.neutral300;
  static const Color formFieldHoverLight = AppTheme.neutral100;
  static const Color formFieldFocusLight = Color(0xFFf0f7ff);
  static const Color formFieldBackgroundDark = Color(0xFF2A3A4B);
  static const Color formFieldBorderDark = Color(0xFF4A6C8B);
  static const Color formFieldHoverDark = Color(0xFF33465F);
  static const Color formFieldFocusDark = Color(0xFF33465F);

  // ==========================================================================
  // 4. INTERACTIVE STATE COLORS
  // ==========================================================================
  // Cores para interações do usuário (hover, focus, active).

  // --- Hover ---
  static const Color hoverLight = Color(0xFFF5F7FA);
  static const Color hoverDark = Color(0xFF2A2A2A);

  // ==========================================================================
  // 5. DESIGN SYSTEM TOKENS (Non-Color)
  // ==========================================================================
  // Definições de espaçamento, tamanhos, bordas e tipografia.

  // --- Bordas Arredondadas ---
  static const double borderRadiusS = 8.0;
  static const double borderRadiusM = 12.0;
  static const double borderRadiusL = 16.0;
  static const double borderRadiusXL = 20.0;

  // --- Espaçamento (Grid de 8px) ---
  static const double spacingXS = 4.0;
  static const double spacingS = 8.0;
  static const double spacingM = 16.0;
  static const double spacingL = 24.0;
  static const double spacingXL = 32.0;
  static const double spacingXXL = 40.0;
  static const double spacingXXXL = 48.0;
  static const double spacingHuge = 64.0;

  // --- Dimensões de Layout ---
  static const double appBarHeight = 60.0;
  static const double drawerWidth = 300.0;
  static const double avatarSizeSmall = 22.0;
  static const double avatarSizeMedium = 40.0;
  static const double avatarSizeLarge = 60.0;
  static const double iconSizeXL = 80.0;

  // --- Breakpoints e Funções Responsivas ---
  static const double breakpointSmall = 1366.0;
  static const double breakpointMedium = 1600.0;
  static const double breakpointLarge = 1920.0;
  static const double breakpointXLarge = 2560.0;

  static const double drawerWidthSmall = 260.0;
  static const double drawerWidthMedium = 280.0;
  static const double drawerWidthLarge = 300.0;
  static const double drawerWidthXLarge = 320.0;

  static double getResponsiveDrawerWidth(double screenWidth) {
    if (screenWidth < breakpointSmall) return drawerWidthSmall;
    if (screenWidth < breakpointMedium) return drawerWidthMedium;
    if (screenWidth < breakpointLarge) return drawerWidthLarge;
    return drawerWidthXLarge;
  }

  static double getResponsiveFontSize(double screenWidth, double baseFontSize) {
    if (screenWidth < breakpointSmall) return baseFontSize * 0.85;
    if (screenWidth < breakpointMedium) return baseFontSize * 0.92;
    if (screenWidth < breakpointLarge) return baseFontSize;
    return baseFontSize * 1.08;
  }

  static double getResponsiveSpacing(double screenWidth, double baseSpacing) {
    if (screenWidth < breakpointSmall) return baseSpacing * 0.8;
    if (screenWidth < breakpointMedium) return baseSpacing * 0.9;
    if (screenWidth < breakpointLarge) return baseSpacing;
    return baseSpacing * 1.1;
  }

  static double getResponsiveIconSize(double screenWidth, double baseIconSize) {
    if (screenWidth < breakpointSmall) return baseIconSize * 0.9;
    if (screenWidth < breakpointMedium) return baseIconSize * 0.95;
    if (screenWidth < breakpointLarge) return baseIconSize;
    return baseIconSize * 1.05;
  }

  // --- Tipografia ---
  static const TextTheme textTheme = TextTheme(
    headlineLarge: TextStyle(
      fontSize: 28.0,
      fontWeight: FontWeight.w700,
      height: 1.2,
    ),
    headlineMedium: TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.w600,
      height: 1.3,
    ),
    headlineSmall: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      height: 1.4,
    ),
    titleLarge: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      height: 1.4,
    ),
    titleMedium: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      height: 1.4,
    ),
    titleSmall: TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.w500,
      height: 1.3,
    ),
    bodyLarge: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w400,
      height: 1.5,
    ),
    bodyMedium: TextStyle(
      fontSize: 13.0,
      fontWeight: FontWeight.w400,
      height: 1.5,
    ),
    bodySmall: TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.w500,
      height: 1.4,
    ),
    labelLarge: TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.w500,
      height: 1.4,
    ),
    labelMedium: TextStyle(
      fontSize: 11.0,
      fontWeight: FontWeight.w500,
      height: 1.3,
    ),
    labelSmall: TextStyle(
      fontSize: 10.0,
      fontWeight: FontWeight.w500,
      height: 1.3,
    ),
  );
}
