import 'package:flutter/material.dart';

class AppTheme {
  // Cores principais
  //static const Color primary = Color(0xFF4A90E2);
  static const Color primary = Color(0xFFcc8e35);
  static const Color primaryVariant = Color(0xFF357ABD);
  static const Color secondary = Color(0xFFC6C6C6);
  static const Color secondaryVariant = Color(0xFFA8A8A8);
  static const Color surfacePrimary = Color(0xFFFFFFFF);
  static const Color surfaceSecondary = Color(0xFFF5F7FA);
  static const Color surfaceTertiary = Color(0xFFE5E8ED);
  static const Color onSurfacePrimary = Color(0xFF1A1C1E);
  static const Color onSurfaceSecondary = Color(0xFF636567);
  static const Color onSurfaceTertiary = Color(0xFF9DA0A3);

  // Cores para estados de interação
  static const Color hover = Color(0x144A90E2); // 8% opacity
  static const Color focus = Color(0x1F4A90E2); // 12% opacity
  static const Color pressed = Color(0x2E4A90E2); // 18% opacity
  static const Color selected = Color(0x194A90E2); // 10% opacity
  static const Color disabled = Color(0xFFE0E0E0);

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
  static const double avatarSizeSmall = 22.0;
  static const double avatarSizeMedium = 40.0;
  static const double avatarSizeLarge = 60.0;

  // Tamanhos de ícones
  static const double iconSizeXL = 80.0;

  // Efeitos visuais
  static const double appBarBlur = 8.0;
  static const double appBarOpacity = 0.85;
}
