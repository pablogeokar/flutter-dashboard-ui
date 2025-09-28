import 'package:flutter/material.dart';

class AppTheme {
  // Cores principais usadas como "sementes" para gerar o ColorScheme
  static const Color primary = Color(0xFF6C91C2); // Azul
  static const Color secondary = Color(0xFFC3C9E9); // Azul claro

  // Cores adicionais da paleta
  static const Color neutral1 = Color(0xFFAAABBC); // Cinza azulado
  static const Color neutral2 = Color(0xFF8B8982); // Cinza
  static const Color darkNeutral = Color(0xFF373F47); // Cinza escuro

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
  static const double appBarHeight = 80.0;
  static const double drawerWidth = 280.0;
  static const Color drawerBackgroundLight = Color(0xFFecf0f1);
  static const Color drawerBackgroundDark = Color(0xFF2c3e50);
  static const double avatarSizeSmall = 22.0;
  static const double avatarSizeMedium = 40.0;
  static const double avatarSizeLarge = 60.0;

  // Tamanhos de ícones
  static const double iconSizeXL = 80.0;

  // Efeitos visuais
  static const double appBarBlur = 8.0;
  static const double appBarOpacity = 0.85;
}
