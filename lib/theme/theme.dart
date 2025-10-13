import 'package:flutter/material.dart';

class AppTheme {
  // === PALETA DE CORES DOMANI FISCAL: Design Profissional Refinado ===

  // Cores Primárias (Azul Destaque Profissional)
  static const Color primaryLight = Color(
    0xFF007BFF,
  ); // Azul vibrante para modo claro (#007BFF)
  static const Color primaryDark = Color(
    0xFF5B9CF8,
  ); // Azul claro para contraste no modo dark (#5B9CF8)

  // Cores Secundárias (Texto)
  static const Color secondaryLight = Color(
    0xFF333333,
  ); // Texto principal modo claro
  static const Color secondaryDark = Color(
    0xFFE0E0E0,
  ); // Texto principal modo dark

  // Texto Secundário
  static const Color textSecondaryLight = Color(
    0xFF666666,
  ); // Texto secundário modo claro
  static const Color textSecondaryDark = Color(
    0xFFB0B0B0,
  ); // Texto secundário modo dark

  // Cores de Superfície (fundo principal da aplicação)
  static const Color surfaceLight = Color(
    0xFFE8EDF3,
  ); // Fundo principal modo claro (#E8EDF3) - Mais escuro para melhor contraste em monitores antigos
  static const Color surfaceDark = Color(
    0xFF121212,
  ); // Fundo principal modo dark (#121212)

  // Cores de Fundo da Drawer (barra lateral)
  static const Color drawerBackgroundLight = Color(
    0xFFDCE4EC,
  ); // Sidebar com mais contraste no modo light (#DCE4EC) - Mais escura para melhor contraste
  static const Color drawerBackgroundDark = Color(
    0xFF191919,
  ); // Sidebar dark refinada (#191919)

  // === CORES SEMÂNTICAS ===

  // Estados de Sucesso (Verde Aprovação Fiscal)
  static const Color successLight = Color(0xFF059669); // Verde aprovação
  static const Color successDark = Color(0xFF10b981);
  static const Color successSurfaceLight = Color(0xFFecfdf5);
  static const Color successSurfaceDark = Color(0xFF064e3b);

  // Estados de Erro (Vermelho Crítico Fiscal)
  static const Color errorLight = Color(0xFFDC2626); // Vermelho crítico
  static const Color errorDark = Color(0xFFef4444);
  static const Color errorSurfaceLight = Color(0xFFfef2f2);
  static const Color errorSurfaceDark = Color(0xFF7f1d1d);

  // Estados de Aviso (Laranja Atenção Fiscal)
  static const Color warningLight = Color(0xFFD97706); // Laranja atenção
  static const Color warningDark = Color(0xFFf59e0b);
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
  static const Color hoverLight = Color(0xFFF5F7FA); // Hover sutil no claro
  static const Color hoverDark = Color(0xFF2A2A2A); // Hover no dark

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
  static const Color cardBackgroundLight = Color(
    0xFFFFFFFF,
  ); // Fundo branco para cards no modo claro
  static const Color cardBorderLight = Colors.transparent; // Sem borda no claro
  static const Color cardShadowLight = Color(
    0x0A000000,
  ); // Sombra sutil (box-shadow: 0px 2px 4px rgba(0, 0, 0, 0.04))

  // Cards e containers - modo escuro
  static const Color cardBackgroundDark = Color(
    0xFF1E1E1E,
  ); // Fundo dos cards no modo dark (#1E1E1E)
  static const Color cardBorderDark = Color(
    0xFF2F2F2F,
  ); // Borda fina para separar do fundo (#2F2F2F)
  static const Color cardShadowDark = Color(0x00000000); // Sem sombra no dark

  // Bordas arredondadas padronizadas (valores de referência para uso nos widgets)
  static const double borderRadiusS = 8.0;
  static const double borderRadiusM = 12.0;
  static const double borderRadiusL = 16.0;
  static const double borderRadiusXL = 20.0;

  // === GRID SYSTEM 8PX - ESPAÇAMENTOS PADRONIZADOS ===
  static const double spacingXS = 4.0; // 0.5 * 8px
  static const double spacingS = 8.0; // 1 * 8px
  static const double spacingM = 16.0; // 2 * 8px
  static const double spacingL = 24.0; // 3 * 8px
  static const double spacingXL = 32.0; // 4 * 8px
  static const double spacingXXL = 40.0; // 5 * 8px
  static const double spacingXXXL = 48.0; // 6 * 8px
  static const double spacingHuge = 64.0; // 8 * 8px

  // Dimensões específicas para layout (valores de referência para uso nos widgets)
  static const double appBarHeight = 60.0;
  static const double drawerWidth = 300.0; // Largura padrão aumentada
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

  // Larguras responsivas da drawer (otimizadas para densidade fiscal)
  static const double drawerWidthSmall = 260.0; // Telas pequenas
  static const double drawerWidthMedium = 280.0; // Telas médias
  static const double drawerWidthLarge = 300.0; // Telas grandes
  static const double drawerWidthXLarge = 320.0; // Telas muito grandes

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

  // Tamanhos de ícones utilizados
  static const double iconSizeXL = 80.0;

  // === HIERARQUIA TIPOGRÁFICA PROFISSIONAL ===
  static const TextTheme textTheme = TextTheme(
    // H1 - Títulos principais
    headlineLarge: TextStyle(
      fontSize: 28.0,
      fontWeight: FontWeight.w700,
      height: 1.2,
    ),
    // H2 - Seções
    headlineMedium: TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.w600,
      height: 1.3,
    ),
    // H3 - Subseções
    headlineSmall: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      height: 1.4,
    ),
    // Títulos de cards
    titleLarge: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      height: 1.4,
    ),
    // Labels importantes
    titleMedium: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      height: 1.4,
    ),
    // Labels menores
    titleSmall: TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.w500,
      height: 1.3,
    ),
    // Body - Texto principal
    bodyLarge: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w400,
      height: 1.5,
    ),
    // Body - Texto secundário
    bodyMedium: TextStyle(
      fontSize: 13.0,
      fontWeight: FontWeight.w400,
      height: 1.5,
    ),
    // Caption - Metadados
    bodySmall: TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.w500,
      height: 1.4,
    ),
    // Labels
    labelLarge: TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.w500,
      height: 1.4,
    ),
    // Labels pequenos
    labelMedium: TextStyle(
      fontSize: 11.0,
      fontWeight: FontWeight.w500,
      height: 1.3,
    ),
    // Small - Labels micro
    labelSmall: TextStyle(
      fontSize: 10.0,
      fontWeight: FontWeight.w500,
      height: 1.3,
    ),
  );
}
