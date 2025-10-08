import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/theme/theme_manager.dart';
import 'drawer_item.dart';
import 'drawer_list_item.dart';
import '/theme/theme.dart';

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

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final drawerColor = isDarkMode
        ? AppTheme.drawerBackgroundDark
        : AppTheme.cardBackgroundLight; // Usar cor de card para mais elegância

    // Cor de gradiente sutil para dar profundidade
    final gradientColor = isDarkMode
        ? AppTheme.drawerBackgroundDark.withValues(alpha: 0.95)
        : AppTheme.formFieldBackgroundLight; // Gradiente mais suave

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
          // Header moderno com logo do app
          Container(
            margin: const EdgeInsets.all(AppTheme.spacingM),
            padding: const EdgeInsets.all(AppTheme.spacingL),
            decoration: BoxDecoration(
              color: isDarkMode
                  ? AppTheme.formFieldBackgroundDark.withValues(alpha: 0.5)
                  : AppTheme.cardBackgroundLight,
              borderRadius: BorderRadius.circular(AppTheme.borderRadiusL),
              border: Border.all(
                color: isDarkMode
                    ? AppTheme.formFieldBorderDark.withValues(alpha: 0.3)
                    : AppTheme.formFieldBorderLight,
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: isDarkMode
                      ? Colors.black.withValues(alpha: 0.2)
                      : Colors.black.withValues(alpha: 0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child:
                // Logo do app - ocupando todo o espaço disponível
                Container(
                  height: 160, // Aumentado de 120 para 160
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: isDarkMode
                        ? AppTheme.formFieldBackgroundDark.withValues(
                            alpha: 0.3,
                          )
                        : AppTheme.formFieldBackgroundLight.withValues(
                            alpha: 0.5,
                          ),
                    borderRadius: BorderRadius.circular(AppTheme.borderRadiusM),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppTheme.borderRadiusM),
                    child: Image.asset(
                      Provider.of<ThemeManager>(context).currentTheme ==
                              ThemeModeType.dark
                          ? 'assets/logo_dark.png'
                          : 'assets/logo_light.png',
                      fit: BoxFit.contain,
                      width: double.infinity,
                      height: double.infinity,
                      errorBuilder: (context, error, stackTrace) {
                        // Fallback elegante caso a imagem não seja encontrada
                        return Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Theme.of(context).colorScheme.primary,
                                Theme.of(
                                  context,
                                ).colorScheme.primary.withValues(alpha: 0.8),
                              ],
                            ),
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
                                  size: 100, // Aumentado ainda mais para 100
                                  color: Colors.white,
                                ),
                                const SizedBox(height: AppTheme.spacingS),
                                Text(
                                  'Dashboard UI',
                                  style: TextStyle(
                                    fontSize: 22, // Aumentado para 22
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
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
          ),
          // Card de status/informações
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingM),
            child: Container(
              padding: const EdgeInsets.all(AppTheme.spacingM),
              decoration: BoxDecoration(
                color: isDarkMode
                    ? AppTheme.formFieldBackgroundDark.withValues(alpha: 0.5)
                    : AppTheme.formFieldBackgroundLight,
                borderRadius: BorderRadius.circular(AppTheme.borderRadiusM),
                border: Border.all(
                  color: isDarkMode
                      ? AppTheme.formFieldBorderDark.withValues(alpha: 0.3)
                      : AppTheme.formFieldBorderLight,
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  // Avatar do usuário
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(
                        AppTheme.borderRadiusS,
                      ),
                    ),
                    child: const Icon(
                      Icons.person_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: AppTheme.spacingM),
                  // Informações do usuário
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Bem-vindo!',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Usuário Admin',
                          style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurface.withValues(alpha: 0.6),
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
          const SizedBox(height: AppTheme.spacingL),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(
                horizontal: AppTheme.spacingM,
              ),
              children: _buildItemList(widget.itensPrincipais),
            ),
          ),
          // Separador elegante
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.spacingL,
              vertical: AppTheme.spacingM,
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
          Container(
            decoration: BoxDecoration(
              color: drawerColor,
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(AppTheme.borderRadiusXL),
              ),
              // Adiciona uma sombra sutil na parte superior para separar do conteúdo
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: isDarkMode ? 0.3 : 0.1),
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Column(
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
        width: AppTheme.drawerWidth,
        decoration: BoxDecoration(
          color: drawerColor,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(AppTheme.borderRadiusXL),
            bottomRight: Radius.circular(AppTheme.borderRadiusXL),
          ),
          boxShadow: [
            BoxShadow(
              color: isDarkMode
                  ? Colors.black.withValues(alpha: 0.3)
                  : Colors.black.withValues(alpha: 0.06),
              blurRadius: 12,
              offset: const Offset(4, 0),
            ),
          ],
          border: Border(
            right: BorderSide(
              color: isDarkMode
                  ? AppTheme.formFieldBorderDark.withValues(alpha: 0.3)
                  : AppTheme.formFieldBorderLight,
              width: 1,
            ),
          ),
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
    return items.map((item) {
      // Group item
      if (item.subItems?.isNotEmpty ?? false) {
        return _buildExpansionItem(item, isFooterList: isFooterList);
      }
      // Normal item
      else {
        return _buildSingleItem(item, isFooterItem: isFooterList);
      }
    }).toList();
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
        if (flatIndex != -1) {
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
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        key: PageStorageKey(item.title), // Persists expanded state
        initiallyExpanded: isGroupSelected,
        tilePadding: EdgeInsets.zero,
        title: DrawerListItem(
          item: item,
          isSelected: isGroupSelected,
          isFooterItem: isFooterList,
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
      margin: const EdgeInsets.all(AppTheme.spacingM),
      padding: const EdgeInsets.all(AppTheme.spacingM),
      decoration: BoxDecoration(
        color: isDarkMode
            ? AppTheme.formFieldBackgroundDark.withValues(alpha: 0.3)
            : AppTheme.formFieldBackgroundLight.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(AppTheme.borderRadiusM),
        border: Border.all(
          color: isDarkMode
              ? AppTheme.formFieldBorderDark.withValues(alpha: 0.3)
              : AppTheme.formFieldBorderLight,
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
                      color: Theme.of(
                        context,
                      ).colorScheme.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Icon(
                      Icons.info_outline,
                      size: 14,
                      color: Theme.of(context).colorScheme.primary,
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
            '© 2024 Dashboard UI',
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
