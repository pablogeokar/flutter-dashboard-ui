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
  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.02).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _elevationAnimation = Tween<double>(begin: 0.0, end: 2.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
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
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: MouseRegion(
            onEnter: (_) => _onHoverEnter(),
            onExit: (_) => _onHoverExit(),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: EdgeInsets.symmetric(
                vertical: AppTheme.spacingXS / 2,
                horizontal: widget.isSubItem ? AppTheme.spacingS : 0,
              ),
              decoration: BoxDecoration(
                color: _getBackgroundColor(isDarkMode, primaryColor),
                borderRadius: BorderRadius.circular(AppTheme.borderRadiusM),
                border: widget.isSelected
                    ? Border.all(
                        color: primaryColor.withValues(alpha: 0.3),
                        width: 1.5,
                      )
                    : _isHovered
                    ? Border.all(
                        color: primaryColor.withValues(alpha: 0.2),
                        width: 1,
                      )
                    : null,
                boxShadow: widget.isSelected || _isHovered
                    ? [
                        BoxShadow(
                          color: primaryColor.withValues(alpha: 0.1),
                          blurRadius: _elevationAnimation.value * 2,
                          offset: Offset(0, _elevationAnimation.value),
                        ),
                      ]
                    : null,
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: hasSubItems ? null : widget.onTap,
                  borderRadius: BorderRadius.circular(AppTheme.borderRadiusM),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppTheme.spacingM,
                      vertical: AppTheme.spacingM,
                    ),
                    child: _buildItemContent(isDarkMode, primaryColor),
                  ),
                ),
              ),
            ),
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
      return primaryColor.withValues(alpha: isDarkMode ? 0.15 : 0.1);
    } else if (_isHovered) {
      return isDarkMode
          ? AppTheme.hoverDark.withValues(alpha: 0.3)
          : AppTheme.hoverLight;
    }
    return Colors.transparent;
  }

  Widget _buildItemContent(bool isDarkMode, Color primaryColor) {
    final bool hasSubItems = widget.item.subItems?.isNotEmpty ?? false;

    return Row(
      children: [
        // Container do ícone com animação
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: _getIconBackgroundColor(isDarkMode, primaryColor),
            borderRadius: BorderRadius.circular(AppTheme.borderRadiusS),
          ),
          child: Icon(
            widget.item.icon,
            size: 18,
            color: _getIconColor(isDarkMode, primaryColor),
          ),
        ),

        SizedBox(width: AppTheme.spacingM),

        // Texto do item
        Expanded(
          child: Text(
            widget.item.title,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: widget.isSelected ? FontWeight.w600 : FontWeight.w500,
              color: _getTextColor(isDarkMode, primaryColor),
              height: 1.2,
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

  Color _getIconBackgroundColor(bool isDarkMode, Color primaryColor) {
    if (widget.isSelected) {
      return primaryColor;
    } else if (_isHovered) {
      return primaryColor.withValues(alpha: isDarkMode ? 0.2 : 0.1);
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
