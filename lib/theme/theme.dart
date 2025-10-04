import 'package:flutter/material.dart';

class AppTheme {
  // === PALETA DE CORES V3: Sistema Semântico e Profissional ===

  // Cores Primárias (usadas como semente para o ColorScheme)
  static const Color primaryLight = Color(0xFF3a99e8); // Azul vibrante da logo
  static const Color primaryDark = Color(
    0xFF5aa6f2,
  ); // Azul mais claro para modo escuro

  // Cores Secundárias
  static const Color secondaryLight = Color(0xFF212529); // Cinza escuro da logo
  static const Color secondaryDark = Color(
    0xFFdee2e6,
  ); // Cinza claro para textos no modo escuro

  // Cores de Superfície (fundo principal da aplicação) - Inspiradas na referência
  static const Color surfaceLight = Color(
    0xFFf5f5f0,
  ); // Bege suave como na referência
  static const Color surfaceDark = Color(0xFF1a1a1a);

  // Cores de Fundo da Drawer (barra lateral)
  static const Color drawerBackgroundLight = Color(
    0xFFfefefe,
  ); // Branco muito suave
  static const Color drawerBackgroundDark = Color(0xFF212529);

  // === CORES SEMÂNTICAS ===

  // Estados de Sucesso
  static const Color successLight = Color(0xFF10b981); // Verde esmeralda
  static const Color successDark = Color(0xFF34d399);
  static const Color successSurfaceLight = Color(0xFFecfdf5);
  static const Color successSurfaceDark = Color(0xFF064e3b);

  // Estados de Erro
  static const Color errorLight = Color(0xFFef4444); // Vermelho moderno
  static const Color errorDark = Color(0xFFf87171);
  static const Color errorSurfaceLight = Color(0xFFfef2f2);
  static const Color errorSurfaceDark = Color(0xFF7f1d1d);

  // Estados de Aviso
  static const Color warningLight = Color(0xFFf59e0b); // Âmbar
  static const Color warningDark = Color(0xFFfbbf24);
  static const Color warningSurfaceLight = Color(0xFffffbeb);
  static const Color warningSurfaceDark = Color(0xFF78350f);

  // Estados de Informação
  static const Color infoLight = Color(0xFF3b82f6); // Azul informativo
  static const Color infoDark = Color(0xFF60a5fa);
  static const Color infoSurfaceLight = Color(0xFFeff6ff);
  static const Color infoSurfaceDark = Color(0xFF1e3a8a);

  // === CORES NEUTRAS EXPANDIDAS ===
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

  // Cores Neutras (mantidas para compatibilidade)
  static const Color neutral1 = neutral500; // Cinza médio
  static const Color neutral2 = neutral700; // Cinza escuro

  // === CORES INTERATIVAS ===

  // Estados de Hover
  static const Color hoverLight = Color(0xFFf1f5f9);
  static const Color hoverDark = Color(0xFF334155);

  // Estados de Foco
  static const Color focusLight = Color(0xFF3b82f6);
  static const Color focusDark = Color(0xFF60a5fa);

  // Estados Ativos
  static const Color activeLight = Color(0xFF1e40af);
  static const Color activeDark = Color(0xFF3b82f6);

  // === CORES ESPECÍFICAS PARA FORMULÁRIOS ===

  // Campos de formulário - modo claro (inspirados na referência)
  static const Color formFieldBackgroundLight = Color(
    0xFFfbfbf8,
  ); // Bege muito claro
  static const Color formFieldBorderLight = Color(
    0xFFe8e8e3,
  ); // Borda bege suave
  static const Color formFieldHoverLight = Color(
    0xFFf8f8f5,
  ); // Hover bege sutil
  static const Color formFieldFocusLight = Color(
    0xFFf0f7ff,
  ); // Foco azul muito claro

  // Campos de formulário - modo escuro (mais harmoniosos)
  static const Color formFieldBackgroundDark = Color(
    0xFF1e293b,
  ); // Cinza azulado escuro
  static const Color formFieldBorderDark = Color(
    0xFF334155,
  ); // Borda mais clara
  static const Color formFieldHoverDark = Color(0xFF293548); // Hover sutil
  static const Color formFieldFocusDark = Color(0xFF1e3a5f); // Foco azul escuro

  // === CORES PARA CARDS E CONTAINERS (Inspiradas na referência) ===

  // Cards e containers - modo claro
  static const Color cardBackgroundLight = Color(
    0xFFffffff,
  ); // Branco puro para cards
  static const Color cardBorderLight = Color(0xFFe8e8e3); // Borda sutil
  static const Color cardShadowLight = Color(0x08000000); // Sombra muito sutil

  // Cards e containers - modo escuro
  static const Color cardBackgroundDark = Color(
    0xFF1f2937,
  ); // Cinza escuro para cards
  static const Color cardBorderDark = Color(0xFF374151); // Borda escura
  static const Color cardShadowDark = Color(0x20000000); // Sombra mais intensa

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

  // === CONFIGURAÇÕES ESPECÍFICAS PARA WINDOWS DESKTOP ===

  // Tamanhos de janela recomendados
  static const double minWindowWidth = 800.0;
  static const double minWindowHeight = 600.0;
  static const double defaultWindowWidth = 1200.0;
  static const double defaultWindowHeight = 800.0;

  // Configurações de scroll para desktop
  static const double desktopScrollSpeed = 120.0;

  // Configurações de densidade para desktop
  static const VisualDensity desktopDensity = VisualDensity.comfortable;

  // Configurações de cursor para desktop (removidas - usar diretamente do Flutter)

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
