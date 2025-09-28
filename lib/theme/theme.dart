import 'package:flutter/material.dart';

class AppTheme {
  // Paleta de Cores V2: Cores harmoniosas e profissionais

  // Cores Primárias (usadas como semente para o ColorScheme)
  static const Color primaryLight = Color(0xFF3a99e8); // Azul vibrante da logo
  static const Color primaryDark = Color(
    0xFF5aa6f2,
  ); // Azul um pouco mais claro para o modo escuro

  // Cores Secundárias
  static const Color secondaryLight = Color(0xFF212529); // Cinza escuro da logo
  static const Color secondaryDark = Color(
    0xFFdee2e6,
  ); // Cinza claro para textos no modo escuro

  // Cores de Superfície (fundo principal da aplicação)
  static const Color surfaceLight = Color(0xFFf8f9fa);
  static const Color surfaceDark = Color(0xFF1a1a1a);

  // Cores de Fundo da Drawer (barra lateral)
  static const Color drawerBackgroundLight = Color(0xFFFFFFFF);
  static const Color drawerBackgroundDark = Color(0xFF212529);

  // Cores Neutras (para textos, bordas, etc.)
  static const Color neutral1 = Color(0xFF6c757d); // Cinza médio
  static const Color neutral2 = Color(0xFF343a40); // Cinza escuro

  // Bordas arredondadas padronizadas (valores de referência para uso nos widgets)
  static const double borderRadiusS = 8.0;
  static const double borderRadiusM = 12.0;
  static const double borderRadiusL = 16.0;
  static const double borderRadiusXL = 20.0;

  // Espaçamentos padronizados (valores de referência para uso nos widgets)
  static const double spacingXS = 4.0;
  static const double spacingS = 8.0;
  static const double spacingM = 16.0;
  static const double spacingL = 24.0;

  // Dimensões específicas para layout (valores de referência para uso nos widgets)
  static const double appBarHeight = 60.0;
  static const double drawerWidth = 280.0;
  static const double avatarSizeSmall = 22.0;
  static const double avatarSizeMedium = 40.0;
  static const double avatarSizeLarge = 60.0;

  // Tamanhos de ícones
  static const double iconSizeXL = 80.0;

  // Efeitos visuais
  static const double appBarBlur = 8.0;
  static const double appBarOpacity = 0.85;

  // Definição da escala de texto personalizada
  static const TextTheme textTheme = TextTheme(
    headlineLarge: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
    headlineMedium: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
    headlineSmall: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
    titleLarge: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
    titleMedium: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600),
    titleSmall: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w600),
    bodyLarge: TextStyle(fontSize: 15.0),
    bodyMedium: TextStyle(fontSize: 13.0),
    bodySmall: TextStyle(fontSize: 11.0),
    labelLarge: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w600),
    labelMedium: TextStyle(fontSize: 11.0),
    labelSmall: TextStyle(fontSize: 10.0),
  );
}
