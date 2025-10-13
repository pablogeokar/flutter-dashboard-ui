import 'package:flutter/material.dart';
import '../../../theme/theme.dart';
import 'drawer_item.dart';

/// Widget ultra-compacto para renderizar itens da barra lateral de navegação
class DrawerListItem extends StatefulWidget {
  final DrawerItem item;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isSubItem;
  final bool isFooterItem;
  final bool isExpansionTitle;
  final int? badgeCount;
  final bool? hasAlert;

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

class _DrawerListItemState extends State<DrawerListItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final bool hasSubItems = widget.item.subItems?.isNotEmpty ?? false;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = Theme.of(context).colorScheme.primary;

    Widget content = MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: (hasSubItems && !widget.isExpansionTitle)
          ? SystemMouseCursors.basic
          : SystemMouseCursors.click,
      child: Stack(
        children: [
          // Indicador de item ativo (linha vertical)
          if (widget.isSelected && !widget.isSubItem)
            Positioned(
              left: 0,
              top: 2,
              bottom: 2,
              child: Container(
                width: 3,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(1.5),
                ),
              ),
            ),

          // Container principal ultra-compacto
          Container(
            margin: const EdgeInsets.symmetric(
              vertical: 0,
            ), // Zero margin vertical
            decoration: BoxDecoration(
              color: _getBackgroundColor(isDarkMode, primaryColor),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Material(
              color: Colors.transparent,
              child: widget.isExpansionTitle
                  ? _buildContent(isDarkMode, primaryColor, hasSubItems)
                  : InkWell(
                      onTap: hasSubItems ? null : widget.onTap,
                      borderRadius: BorderRadius.circular(8),
                      mouseCursor: hasSubItems
                          ? SystemMouseCursors.basic
                          : SystemMouseCursors.click,
                      child: _buildContent(
                        isDarkMode,
                        primaryColor,
                        hasSubItems,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );

    if (widget.isSubItem) {
      return Padding(
        padding: const EdgeInsets.only(
          left: 12,
        ), // Indentação mínima para subitens
        child: content,
      );
    }

    return content;
  }

  Widget _buildContent(bool isDarkMode, Color primaryColor, bool hasSubItems) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: widget.isSelected && !widget.isSubItem
            ? 10
            : 6, // Padding mínimo
        vertical: 6, // Padding vertical ultra-compacto
      ),
      child: Row(
        children: [
          // Ícone compacto
          Container(
            width: 24, // Ícone ainda menor
            height: 24,
            decoration: BoxDecoration(
              color: _getIconBackgroundColor(isDarkMode, primaryColor),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Icon(
              widget.isSelected && _hasFilledVariant(widget.item.icon)
                  ? _getFilledIcon(widget.item.icon)
                  : widget.item.icon,
              size: 14, // Ícone menor
              color: _getIconColor(isDarkMode, primaryColor),
            ),
          ),

          const SizedBox(width: 8), // Espaçamento mínimo
          // Texto compacto
          Expanded(
            child: Text(
              widget.item.title,
              style: TextStyle(
                fontWeight: widget.isSelected
                    ? FontWeight.w600
                    : FontWeight.w400,
                color: _getTextColor(isDarkMode, primaryColor),
                fontSize: 12.5, // Fonte ainda menor
                height: 1.1, // Line-height ultra-compacto
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          // Indicadores
          ..._buildIndicators(isDarkMode, primaryColor),

          // Seta para subitens
          if (hasSubItems && !widget.isExpansionTitle) ...[
            const SizedBox(width: 4),
            Icon(
              Icons.chevron_right_rounded,
              size: 14,
              color: _getTextColor(
                isDarkMode,
                primaryColor,
              ).withValues(alpha: 0.6),
            ),
          ],
        ],
      ),
    );
  }

  Color _getBackgroundColor(bool isDarkMode, Color primaryColor) {
    if (widget.isSelected) {
      return primaryColor.withValues(alpha: isDarkMode ? 0.12 : 0.08);
    } else if (_isHovered) {
      return isDarkMode ? AppTheme.hoverDark : AppTheme.hoverLight;
    }
    return Colors.transparent;
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

  List<Widget> _buildIndicators(bool isDarkMode, Color primaryColor) {
    List<Widget> indicators = [];

    // Badge numérico compacto
    if (widget.badgeCount != null && widget.badgeCount! > 0) {
      indicators.add(
        Container(
          margin: const EdgeInsets.only(left: 4),
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
          decoration: BoxDecoration(
            color: AppTheme.errorLight,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            widget.badgeCount! > 99 ? '99+' : widget.badgeCount.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 9,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
    }

    // Indicador de alerta compacto
    if (widget.hasAlert == true) {
      indicators.add(
        Container(
          margin: const EdgeInsets.only(left: 4),
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            color: AppTheme.warningLight,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
      );
    }

    return indicators;
  }
}
