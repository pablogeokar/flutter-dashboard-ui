import 'package:flutter/material.dart';
import '../../../theme/theme.dart';
import 'drawer_item.dart';

/// Widget para renderizar itens individuais da barra lateral de navegação
class DrawerListItem extends StatefulWidget {
  final DrawerItem item;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isSubItem;
  final bool isFooterItem;
  final bool isExpansionTitle; // Para indicar se está dentro de ExpansionTile
  final int? badgeCount; // Para indicadores numéricos
  final bool? hasAlert; // Para indicadores de alerta

  const DrawerListItem({
    super.key,
    required this.item,
    required this.isSelected,
    required this.onTap,
    this.isSubItem = false,
    this.isFooterItem = false,
    this.isExpansionTitle = false,
    this.badgeCount,
    this.hasAlert,
  });

  @override
  State<DrawerListItem> createState() => _DrawerListItemState();
}

class _DrawerListItemState extends State<DrawerListItem>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onHoverEnter() {
    setState(() => _isHovered = true);
    _animationController.forward();
  }

  void _onHoverExit() {
    setState(() => _isHovered = false);
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final bool hasSubItems = widget.item.subItems?.isNotEmpty ?? false;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = Theme.of(context).colorScheme.primary;

    Widget content = AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return MouseRegion(
          onEnter: (_) => _onHoverEnter(),
          onExit: (_) => _onHoverExit(),
          // Cursor pointer para itens clicáveis (incluindo títulos de ExpansionTile)
          cursor: (hasSubItems && !widget.isExpansionTitle)
              ? SystemMouseCursors.basic
              : SystemMouseCursors.click,
          child: Stack(
            children: [
              // Indicador de item ativo (linha vertical de 4px na borda esquerda)
              if (widget.isSelected && !widget.isSubItem)
                Positioned(
                  left: 0,
                  top: 4,
                  bottom: 4,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 4,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),

              // Container principal do item
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: EdgeInsets.symmetric(
                  vertical: 1, // Espaçamento mínimo entre itens
                  horizontal: widget.isSubItem ? AppTheme.spacingS : 0,
                ),
                decoration: BoxDecoration(
                  color: _getBackgroundColor(isDarkMode, primaryColor),
                  borderRadius: BorderRadius.circular(AppTheme.borderRadiusM),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: widget.isExpansionTitle
                      ? // Para títulos de ExpansionTile, não usar InkWell (deixar o ExpansionTile controlar)
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: widget.isSelected && !widget.isSubItem
                                ? AppTheme.spacingM +
                                      8 // Espaço extra para o indicador
                                : AppTheme.spacingM,
                            vertical:
                                AppTheme.spacingS, // Padding vertical compacto
                          ),
                          child: _buildItemContent(isDarkMode, primaryColor),
                        )
                      : InkWell(
                          // Para itens normais, usar InkWell
                          onTap: hasSubItems ? null : widget.onTap,
                          borderRadius: BorderRadius.circular(
                            AppTheme.borderRadiusM,
                          ),
                          mouseCursor: hasSubItems
                              ? SystemMouseCursors.basic
                              : SystemMouseCursors.click,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: widget.isSelected && !widget.isSubItem
                                  ? AppTheme.spacingM +
                                        8 // Espaço extra para o indicador
                                  : AppTheme.spacingM,
                              vertical: AppTheme
                                  .spacingS, // Padding vertical compacto
                            ),
                            child: _buildItemContent(isDarkMode, primaryColor),
                          ),
                        ),
                ),
              ),
            ],
          ),
        );
      },
    );

    if (widget.isSubItem) {
      return Padding(
        padding: EdgeInsets.only(left: AppTheme.spacingL),
        child: content,
      );
    }

    return content;
  }

  Color _getBackgroundColor(bool isDarkMode, Color primaryColor) {
    if (widget.isSelected) {
      return primaryColor.withValues(alpha: isDarkMode ? 0.12 : 0.08);
    } else if (_isHovered) {
      return isDarkMode ? AppTheme.hoverDark : AppTheme.hoverLight;
    }
    return Colors.transparent;
  }

  Widget _buildItemContent(bool isDarkMode, Color primaryColor) {
    final bool hasSubItems = widget.item.subItems?.isNotEmpty ?? false;

    return Row(
      children: [
        // Container do ícone com animação - design mais elegante
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: _getIconBackgroundColor(isDarkMode, primaryColor),
            borderRadius: BorderRadius.circular(6), // Cantos menos arredondados
          ),
          child: Icon(
            // Usar ícone preenchido quando selecionado
            widget.isSelected && _hasFilledVariant(widget.item.icon)
                ? _getFilledIcon(widget.item.icon)
                : widget.item.icon,
            size: 16,
            color: _getIconColor(isDarkMode, primaryColor),
          ),
        ),

        SizedBox(width: AppTheme.spacingM),

        // Texto do item com tipografia aprimorada
        Expanded(
          child: Text(
            widget.item.title,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: widget.isSelected ? FontWeight.w600 : FontWeight.w500,
              color: _getTextColor(isDarkMode, primaryColor),
              height: 1.3,
              fontSize: 14, // Tamanho consistente
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),

        // Indicadores e badges
        ..._buildIndicators(isDarkMode, primaryColor),

        // Seta para itens com subitens (apenas se não for título de ExpansionTile)
        if (hasSubItems && !widget.isExpansionTitle) ...[
          SizedBox(width: AppTheme.spacingS),
          AnimatedRotation(
            turns: 0, // Pode ser usado para rotacionar a seta quando expandido
            duration: const Duration(milliseconds: 200),
            child: Icon(
              Icons.chevron_right_rounded,
              size: 16,
              color: _getTextColor(
                isDarkMode,
                primaryColor,
              ).withValues(alpha: 0.6),
            ),
          ),
        ],
      ],
    );
  }

  // Função para verificar se o ícone tem variante preenchida
  bool _hasFilledVariant(IconData icon) {
    final iconsWithFilledVariants = {
      Icons.dashboard_rounded,
      Icons.people_rounded,
      Icons.business_rounded,
      Icons.inventory_2_rounded,
      Icons.account_tree_rounded,
      Icons.gavel_rounded,
      Icons.calculate_rounded,
      Icons.description_rounded,
      Icons.assignment_rounded,
      Icons.event_rounded,
      Icons.analytics_rounded,
      Icons.balance_rounded,
      Icons.trending_up_rounded,
      Icons.account_balance_wallet_rounded,
      Icons.settings_rounded,
      Icons.help_outline_rounded,
    };
    return iconsWithFilledVariants.contains(icon);
  }

  // Função para obter o ícone preenchido
  IconData _getFilledIcon(IconData icon) {
    final iconMapping = {
      Icons.dashboard_rounded: Icons.dashboard,
      Icons.people_rounded: Icons.people,
      Icons.business_rounded: Icons.business,
      Icons.inventory_2_rounded: Icons.inventory_2,
      Icons.account_tree_rounded: Icons.account_tree,
      Icons.gavel_rounded: Icons.gavel,
      Icons.calculate_rounded: Icons.calculate,
      Icons.description_rounded: Icons.description,
      Icons.assignment_rounded: Icons.assignment,
      Icons.event_rounded: Icons.event,
      Icons.analytics_rounded: Icons.analytics,
      Icons.balance_rounded: Icons.balance,
      Icons.trending_up_rounded: Icons.trending_up,
      Icons.account_balance_wallet_rounded: Icons.account_balance_wallet,
      Icons.settings_rounded: Icons.settings,
      Icons.help_outline_rounded: Icons.help,
    };
    return iconMapping[icon] ?? icon;
  }

  Color _getIconBackgroundColor(bool isDarkMode, Color primaryColor) {
    if (widget.isSelected) {
      return primaryColor;
    } else if (_isHovered) {
      return primaryColor.withValues(alpha: isDarkMode ? 0.15 : 0.1);
    }
    return Colors.transparent;
  }

  Color _getIconColor(bool isDarkMode, Color primaryColor) {
    if (widget.isSelected) {
      return Colors.white;
    } else if (_isHovered) {
      return primaryColor;
    }
    return Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7);
  }

  Color _getTextColor(bool isDarkMode, Color primaryColor) {
    if (widget.isSelected) {
      return primaryColor;
    } else if (_isHovered) {
      return primaryColor;
    }
    return Theme.of(context).colorScheme.onSurface;
  }

  List<Widget> _buildIndicators(bool isDarkMode, Color primaryColor) {
    List<Widget> indicators = [];

    // Badge numérico
    if (widget.badgeCount != null && widget.badgeCount! > 0) {
      indicators.add(
        Container(
          margin: EdgeInsets.only(left: AppTheme.spacingS),
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: AppTheme.errorLight,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            widget.badgeCount! > 99 ? '99+' : widget.badgeCount.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
    }

    // Indicador de alerta
    if (widget.hasAlert == true) {
      indicators.add(
        Container(
          margin: EdgeInsets.only(left: AppTheme.spacingS),
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: AppTheme.warningLight,
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(
                color: AppTheme.warningLight.withValues(alpha: 0.3),
                blurRadius: 4,
                spreadRadius: 1,
              ),
            ],
          ),
        ),
      );
    }

    return indicators;
  }
}
