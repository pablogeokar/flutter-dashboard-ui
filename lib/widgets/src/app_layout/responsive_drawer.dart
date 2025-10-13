import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../theme/theme_manager.dart';
import '../../../theme/theme.dart';
import 'drawer_item.dart';
import 'drawer_list_item.dart';

class ResponsiveDrawer extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;
  final List<DrawerItem> itensPrincipais;
  final List<DrawerItem> itensInferiores;
  final bool isPermanent; // Novo parâmetro

  const ResponsiveDrawer({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.itensPrincipais,
    required this.itensInferiores,
    this.isPermanent = false, // Valor padrão
  });

  @override
  State<ResponsiveDrawer> createState() => _ResponsiveDrawerState();
}

class _ResponsiveDrawerState extends State<ResponsiveDrawer> {
  late final List<DrawerItem> _flatNavigableItems;

  @override
  void initState() {
    super.initState();
    _flatNavigableItems = _flattenItems();
  }

  List<DrawerItem> _flattenItems() {
    final List<DrawerItem> flatList = [];
    void processItems(List<DrawerItem> items) {
      for (final item in items) {
        if (item.subItems?.isNotEmpty ?? false) {
          processItems(item.subItems!);
        } else if (item.screen != null) {
          flatList.add(item);
        }
      }
    }

    processItems([...widget.itensPrincipais, ...widget.itensInferiores]);
    return flatList;
  }

  /// Calcula altura responsiva da logo baseada na largura e altura da tela
  double _getResponsiveLogoHeight(double screenWidth, double screenHeight) {
    // Altura base da logo - AUMENTADA para mais destaque
    double baseHeight = 160.0;

    // Ajuste baseado na largura da tela
    if (screenWidth < AppTheme.breakpointSmall) {
      baseHeight = 140.0; // Telas pequenas: altura maior que antes
    } else if (screenWidth < AppTheme.breakpointMedium) {
      baseHeight = 150.0; // Telas médias: altura maior
    } else if (screenWidth < AppTheme.breakpointLarge) {
      baseHeight = 160.0; // Telas grandes: altura aumentada
    } else {
      baseHeight = 170.0; // Telas muito grandes: altura ainda maior
    }

    // Ajuste mais conservador para telas baixas
    if (screenHeight < 700) {
      baseHeight = baseHeight * 0.9; // Reduz apenas 10% em telas muito baixas
    } else if (screenHeight < 800) {
      baseHeight = baseHeight * 0.97; // Reduz apenas 3% em telas baixas
    }

    return baseHeight;
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;

    // Sistema de responsividade inteligente
    final responsiveDrawerWidth = AppTheme.getResponsiveDrawerWidth(
      screenWidth,
    );
    final responsiveSpacing = AppTheme.getResponsiveSpacing(
      screenWidth,
      AppTheme.spacingM,
    );
    final responsiveSpacingS = AppTheme.getResponsiveSpacing(
      screenWidth,
      AppTheme.spacingS,
    );
    final responsiveSpacingL = AppTheme.getResponsiveSpacing(
      screenWidth,
      AppTheme.spacingL,
    );

    final isSmallScreen =
        screenHeight < 700; // Detecta telas pequenas em altura

    final drawerColor = isDarkMode
        ? AppTheme
              .drawerBackgroundDark // #191919
        : AppTheme.drawerBackgroundLight; // #FFFFFF

    // Cor de gradiente sutil para dar profundidade
    final gradientColor = isDarkMode
        ? AppTheme.drawerBackgroundDark.withValues(alpha: 0.95)
        : AppTheme
              .drawerBackgroundLight; // Sem gradiente no claro para manter limpo

    final Widget drawerContent = Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [drawerColor, gradientColor],
          stops: const [0.0, 1.0],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Logo do sistema - apenas a imagem
          Padding(
            padding: EdgeInsets.all(
              isSmallScreen ? responsiveSpacingS : responsiveSpacing,
            ),
            child: SizedBox(
              height: _getResponsiveLogoHeight(screenWidth, screenHeight),
              child: Image.asset(
                Provider.of<ThemeManager>(context).currentTheme ==
                        ThemeModeType.dark
                    ? 'assets/logo_dark.png'
                    : 'assets/logo_light.png',
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  // Fallback simples caso a imagem não seja encontrada
                  return Container(
                    height: _getResponsiveLogoHeight(screenWidth, screenHeight),
                    decoration: BoxDecoration(
                      color: isDarkMode
                          ? AppTheme.neutral700
                          : Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(
                        AppTheme.borderRadiusM,
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.dashboard_rounded,
                            size: 64,
                            color: isDarkMode
                                ? AppTheme.neutral200
                                : Colors.white,
                          ),
                          const SizedBox(height: AppTheme.spacingS),
                          Text(
                            'Domani Fiscal',
                            style: TextStyle(
                              fontSize: AppTheme.getResponsiveFontSize(
                                screenWidth,
                                18,
                              ),
                              fontWeight: FontWeight.bold,
                              color: isDarkMode
                                  ? AppTheme.neutral200
                                  : Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          // Card de status/informações
          Padding(
            padding: EdgeInsets.symmetric(horizontal: responsiveSpacing),
            child: Container(
              padding: EdgeInsets.all(
                AppTheme.spacingS,
              ), // Reduzido de responsiveSpacing para spacingS
              decoration: BoxDecoration(
                color: isDarkMode
                    ? AppTheme.cardBackgroundDark.withValues(alpha: 0.5)
                    : AppTheme.neutral200, // Mais contraste no modo light
                borderRadius: BorderRadius.circular(AppTheme.borderRadiusM),
                border: Border.all(
                  color: isDarkMode
                      ? AppTheme.cardBorderDark.withValues(alpha: 0.3)
                      : AppTheme
                            .neutral400, // Borda mais escura para melhor contraste
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  // Avatar do usuário
                  Container(
                    width: AppTheme.getResponsiveIconSize(screenWidth, 40),
                    height: AppTheme.getResponsiveIconSize(screenWidth, 40),
                    decoration: BoxDecoration(
                      color: isDarkMode
                          ? AppTheme.neutral600
                          : Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(
                        AppTheme.borderRadiusS,
                      ),
                    ),
                    child: Icon(
                      Icons.person_rounded,
                      color: isDarkMode ? AppTheme.neutral100 : Colors.white,
                      size: AppTheme.getResponsiveIconSize(screenWidth, 20),
                    ),
                  ),
                  SizedBox(width: AppTheme.spacingS), // Reduzido espaçamento
                  // Informações do usuário
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Olá, Admin!',
                          style: TextStyle(
                            fontSize: AppTheme.getResponsiveFontSize(
                              screenWidth,
                              14, // Reduzido de 15 para 14
                            ),
                            fontWeight:
                                FontWeight.w600, // Reduzido de w700 para w600
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 2), // Reduzido de 4 para 2
                        Text(
                          'Domani Fiscal',
                          style: TextStyle(
                            fontSize: AppTheme.getResponsiveFontSize(
                              screenWidth,
                              12, // Reduzido de 13 para 12
                            ),
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Indicador de status
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: AppTheme.successLight,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: AppTheme.spacingS, // Espaçamento ainda mais compacto
          ),
          // Área principal expansível com itens principais
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: isSmallScreen
                    ? responsiveSpacingS
                    : responsiveSpacing,
              ),
              child: Column(children: _buildItemList(widget.itensPrincipais)),
            ),
          ),
          // Separador elegante
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: responsiveSpacingL,
              vertical: AppTheme.spacingXS, // Espaçamento ainda mais reduzido
            ),
            child: Container(
              height: 1,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Theme.of(
                      context,
                    ).colorScheme.outline.withValues(alpha: 0.3),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          // Footer fixo na parte inferior
          Container(
            decoration: BoxDecoration(
              color: drawerColor,
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(AppTheme.borderRadiusXL),
              ),
              // Adiciona uma sombra sutil na parte superior para separar do conteúdo
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(
                    alpha: isDarkMode ? 0.2 : 0.05,
                  ),
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ..._buildItemList(widget.itensInferiores, isFooterList: true),
                _buildFooter(context),
              ],
            ),
          ),
        ],
      ),
    );

    if (widget.isPermanent) {
      return AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: responsiveDrawerWidth,
        decoration: BoxDecoration(
          color: drawerColor,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(AppTheme.borderRadiusXL),
            bottomRight: Radius.circular(AppTheme.borderRadiusXL),
          ),
          boxShadow: [
            BoxShadow(
              color: isDarkMode
                  ? Colors.black.withValues(alpha: 0.2)
                  : Colors.black.withValues(alpha: 0.04),
              blurRadius: 12,
              offset: const Offset(4, 0),
            ),
          ],
          border: isDarkMode
              ? Border(
                  right: BorderSide(
                    color: AppTheme.cardBorderDark.withValues(alpha: 0.3),
                    width: 1,
                  ),
                )
              : null, // Sem borda no modo claro
        ),
        child: drawerContent,
      );
    } else {
      return Drawer(
        elevation: 0,
        backgroundColor: drawerColor,
        child: drawerContent,
      );
    }
  }

  List<Widget> _buildItemList(
    List<DrawerItem> items, {
    bool isFooterList = false,
  }) {
    List<Widget> widgets = [];

    for (int i = 0; i < items.length; i++) {
      final item = items[i];

      // Adicionar o item
      if (item.subItems?.isNotEmpty ?? false) {
        widgets.add(_buildExpansionItem(item, isFooterList: isFooterList));
      } else {
        widgets.add(_buildSingleItem(item, isFooterItem: isFooterList));
      }

      // Adicionar divisor entre grupos (exceto no último item)
      if (!isFooterList && i < items.length - 1) {
        widgets.add(_buildGroupDivider());
      }
    }

    return widgets;
  }

  // Divisor sutil entre grupos de itens
  Widget _buildGroupDivider() {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: AppTheme.spacingXS, // Ainda mais reduzido para compactar
        horizontal: AppTheme.spacingM,
      ),
      height: 1,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.transparent,
            Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
            Colors.transparent,
          ],
        ),
      ),
    );
  }

  Widget _buildSingleItem(
    DrawerItem item, {
    bool isSubItem = false,
    bool isFooterItem = false,
  }) {
    final flatIndex = _flatNavigableItems.indexWhere(
      (e) => e.title == item.title,
    );

    return DrawerListItem(
      item: item,
      isSubItem: isSubItem,
      isSelected: widget.currentIndex == flatIndex,
      isFooterItem: isFooterItem,
      onTap: () {
        // Se tem callback de dialog, executa o dialog
        if (item.onDialogTap != null) {
          item.onDialogTap!();
        }
        // Caso contrário, navega normalmente
        else if (flatIndex != -1) {
          widget.onTap(flatIndex);
        }
      },
    );
  }

  Widget _buildExpansionItem(DrawerItem item, {bool isFooterList = false}) {
    // Check if any sub-item is currently selected
    final bool isGroupSelected = item.subItems!.any((subItem) {
      final flatIndex = _flatNavigableItems.indexWhere(
        (e) => e.title == subItem.title,
      );
      return widget.currentIndex == flatIndex;
    });

    return Theme(
      data: Theme.of(context).copyWith(
        dividerColor: Colors.transparent,
        // Customizar a cor da seta do ExpansionTile
        colorScheme: Theme.of(context).colorScheme.copyWith(
          onSurface: Theme.of(
            context,
          ).colorScheme.onSurface.withValues(alpha: 0.6),
        ),
      ),
      child: ExpansionTile(
        key: PageStorageKey(item.title), // Persists expanded state
        initiallyExpanded: isGroupSelected,
        tilePadding: EdgeInsets.zero,
        maintainState: true, // Mantém o estado de expansão
        childrenPadding: EdgeInsets.zero, // Remove padding extra dos filhos
        // Customizar a seta do ExpansionTile
        iconColor: Theme.of(context).colorScheme.primary,
        collapsedIconColor: Theme.of(
          context,
        ).colorScheme.onSurface.withValues(alpha: 0.6),
        title: DrawerListItem(
          item: item,
          isSelected: isGroupSelected,
          isFooterItem: isFooterList,
          isExpansionTitle:
              true, // Nova propriedade para indicar que não deve mostrar seta
          onTap: () {}, // The tile itself handles expansion
        ),
        children: item.subItems!
            .map(
              (subItem) => _buildSingleItem(
                subItem,
                isSubItem: true,
                isFooterItem: isFooterList,
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.all(AppTheme.spacingS), // Reduzido margin
      padding: const EdgeInsets.all(AppTheme.spacingS), // Reduzido padding
      decoration: BoxDecoration(
        color: isDarkMode
            ? AppTheme.cardBackgroundDark.withValues(alpha: 0.5)
            : AppTheme.neutral100,
        borderRadius: BorderRadius.circular(AppTheme.borderRadiusM),
        border: Border.all(
          color: isDarkMode
              ? AppTheme.cardBorderDark.withValues(alpha: 0.3)
              : AppTheme.neutral300,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          // Informações da versão
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: isDarkMode
                          ? AppTheme.neutral700.withValues(alpha: 0.6)
                          : Theme.of(
                              context,
                            ).colorScheme.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Icon(
                      Icons.info_outline,
                      size: 14,
                      color: isDarkMode
                          ? AppTheme.neutral300
                          : Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(width: AppTheme.spacingS),
                  Text(
                    'Versão 1.0.0',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.8),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              // Status de conexão
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacingS,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppTheme.successLight.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: AppTheme.successLight,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Online',
                      style: TextStyle(
                        fontSize: 10,
                        color: AppTheme.successLight,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacingS),
          // Informações adicionais
          Text(
            '© 2025 Domani Fiscal',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.5),
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
