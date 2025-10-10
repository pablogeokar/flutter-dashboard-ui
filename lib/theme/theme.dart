import 'package:flutter/material.dart';

class AppTheme {
  // === PALETA DE CORES DOMANI FISCAL: Identidade Visual Própria ===

  // Cores Primárias (Azul Domani - Confiança e Profissionalismo)
  static const Color primaryLight = Color(
    0xFF2563EB,
  ); // Azul vibrante e moderno para modo claro
  static const Color primaryDark = Color(
    0xFF3B82F6,
  ); // Azul mais claro e acessível para modo dark

  // Cores Secundárias
  static const Color secondaryLight = Color(
    0xFF212529,
  ); // Cinza escuro para texto (mantido)
  static const Color secondaryDark = Color(
    0xFFdee2e6,
  ); // Cinza claro para textos no modo escuro (mantido)

  // Cores de Superfície (fundo principal da aplicação)
  static const Color surfaceLight = Color(
    0xFFF5F5F5,
  ); // Branco suave para conforto visual
  static const Color surfaceDark = Color(0xFF2C2C2C); // Cinza escuro e elegante

  // Cores de Fundo da Drawer (barra lateral)
  static const Color drawerBackgroundLight = Color(
    0xFFFFFFFF,
  ); // Branco puro para contraste sutil
  static const Color drawerBackgroundDark = Color(
    0xFF2A3441,
  ); // Tom mais suave, menos escuro que #2d3748

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

  // Campos de formulário - modo claro
  static const Color formFieldBackgroundLight =
      AppTheme.neutral50; // Cinza levíssimo para diferenciar
  static const Color formFieldBorderLight =
      AppTheme.neutral300; // Borda mais escura para visibilidade
  static const Color formFieldHoverLight = AppTheme.neutral100;
  static const Color formFieldFocusLight = Color(
    0xFFf0f7ff,
  ); // Foco azul muito claro (mantido)

  // Campos de formulário - modo escuro (Harmonizados com a cor primária)
  static const Color formFieldBackgroundDark = Color(
    0xFF2A3A4B,
  ); // Fundo azul-acinzentado escuro
  static const Color formFieldBorderDark = Color(
    0xFF4A6C8B,
  ); // Borda sutil no tom da cor primária
  static const Color formFieldHoverDark = Color(
    0xFF33465F,
  ); // Fundo um pouco mais claro no hover
  static const Color formFieldFocusDark = Color(
    0xFF33465F,
  ); // Fundo igual ao hover, destaque vem da borda

  // === CORES PARA CARDS E CONTAINERS ===

  // Cards e containers - modo claro
  static const Color cardBackgroundLight =
      AppTheme.neutral50; // Cinza levíssimo para diferenciar
  static const Color cardBorderLight =
      AppTheme.neutral300; // Borda mais escura para visibilidade
  static const Color cardShadowLight = Color(0x08000000); // Sombra muito sutil

  // Cards e containers - modo escuro
  static const Color cardBackgroundDark = Color(
    0xFF3A3A3A,
  ); // Cinza claro para cards
  static const Color cardBorderDark = AppTheme.neutral700; // Borda cinza neutra
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

  // === SISTEMA DE RESPONSIVIDADE INTELIGENTE ===

  // Breakpoints para diferentes tamanhos de tela
  static const double breakpointSmall = 1366.0; // Laptops pequenos (13-14")
  static const double breakpointMedium = 1600.0; // Laptops médios (15-16")
  static const double breakpointLarge = 1920.0; // Monitores grandes (21-24")
  static const double breakpointXLarge =
      2560.0; // Monitores muito grandes (27"+)

  // Larguras responsivas da drawer
  static const double drawerWidthSmall = 240.0; // Telas pequenas
  static const double drawerWidthMedium = 260.0; // Telas médias
  static const double drawerWidthLarge = 280.0; // Telas grandes
  static const double drawerWidthXLarge = 300.0; // Telas muito grandes

  // Função para obter largura responsiva da drawer
  static double getResponsiveDrawerWidth(double screenWidth) {
    if (screenWidth < breakpointSmall) {
      return drawerWidthSmall;
    } else if (screenWidth < breakpointMedium) {
      return drawerWidthMedium;
    } else if (screenWidth < breakpointLarge) {
      return drawerWidthLarge;
    } else {
      return drawerWidthXLarge;
    }
  }

  // Função para obter tamanho de fonte responsivo
  static double getResponsiveFontSize(double screenWidth, double baseFontSize) {
    if (screenWidth < breakpointSmall) {
      return baseFontSize * 0.85; // 15% menor em telas pequenas
    } else if (screenWidth < breakpointMedium) {
      return baseFontSize * 0.92; // 8% menor em telas médias
    } else if (screenWidth < breakpointLarge) {
      return baseFontSize; // Tamanho base em telas grandes
    } else {
      return baseFontSize * 1.08; // 8% maior em telas muito grandes
    }
  }

  // Função para obter espaçamento responsivo
  static double getResponsiveSpacing(double screenWidth, double baseSpacing) {
    if (screenWidth < breakpointSmall) {
      return baseSpacing * 0.8; // 20% menor em telas pequenas
    } else if (screenWidth < breakpointMedium) {
      return baseSpacing * 0.9; // 10% menor em telas médias
    } else if (screenWidth < breakpointLarge) {
      return baseSpacing; // Espaçamento base em telas grandes
    } else {
      return baseSpacing * 1.1; // 10% maior em telas muito grandes
    }
  }

  // Função para obter tamanho de ícone responsivo
  static double getResponsiveIconSize(double screenWidth, double baseIconSize) {
    if (screenWidth < breakpointSmall) {
      return baseIconSize * 0.9; // 10% menor em telas pequenas
    } else if (screenWidth < breakpointMedium) {
      return baseIconSize * 0.95; // 5% menor em telas médias
    } else if (screenWidth < breakpointLarge) {
      return baseIconSize; // Tamanho base em telas grandes
    } else {
      return baseIconSize * 1.05; // 5% maior em telas muito grandes
    }
  }

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

  // Definição da escala de texto com hierarquia clara
  static const TextTheme textTheme = TextTheme(
    headlineLarge: TextStyle(
      fontSize: 32.0,
      fontWeight: FontWeight.w800,
    ), // Extra bold para títulos principais
    headlineMedium: TextStyle(
      fontSize: 28.0,
      fontWeight: FontWeight.w700,
    ), // Bold para subtítulos
    headlineSmall: TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.w600,
    ), // Semi-bold para seções
    titleLarge: TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.w600,
    ), // Semi-bold para títulos de cards
    titleMedium: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
    ), // Medium para labels importantes
    titleSmall: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
    ), // Medium para labels menores
    bodyLarge: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
    ), // Regular para texto principal (aumentado)
    bodyMedium: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w400,
    ), // Regular para texto secundário
    bodySmall: TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.w400,
    ), // Regular para texto pequeno
    labelLarge: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
    ), // Medium para labels
    labelMedium: TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.w400,
    ), // Regular para labels menores
    labelSmall: TextStyle(
      fontSize: 10.0,
      fontWeight: FontWeight.w400,
    ), // Regular para micro-labels
  );
}
