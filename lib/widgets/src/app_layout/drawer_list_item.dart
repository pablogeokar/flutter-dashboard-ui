import 'package:flutter/material.dart';
import '../../../theme/theme.dart';
import '../../../theme/animations.dart';
import 'drawer_item.dart';

class DrawerListItem extends StatefulWidget {
  final DrawerItem item;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isSubItem;
  final bool isFooterItem;

  const DrawerListItem({
    super.key,
    required this.item,
    required this.isSelected,
    required this.onTap,
    this.isSubItem = false,
    this.isFooterItem = false,
  });

  @override
  State<DrawerListItem> createState() => _DrawerListItemState();
}

class _DrawerListItemState extends State<DrawerListItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    // Detecta se é um item com subitens (grupo)
    final bool hasSubItems = widget.item.subItems?.isNotEmpty ?? false;
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenHeight < 700; // Detecta telas pequenas

    Widget content = MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: AppAnimations.fast,
        curve: AppAnimations.easeOut,
        transform: _isHovered && !widget.isSelected
            ? Matrix4.diagonal3Values(1.02, 1.02, 1.0)
            : Matrix4.identity(),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppTheme.borderRadiusM),
          child: Material(
            color: Colors.transparent,
            child: hasSubItems
                ? Container(
                    // Para itens com subitens, não usamos InkWell pois o ExpansionTile gerencia o toque
                    child: _buildItemContent(),
                  )
                : InkWell(
                    onTap: widget.onTap,
                    hoverColor:
                        Colors.transparent, // Controlamos o hover manualmente
                    focusColor: Theme.of(context).colorScheme.primary
                        .withValues(alpha: widget.isFooterItem ? 0.08 : 0.12),
                    highlightColor: Theme.of(context).colorScheme.primary
                        .withValues(alpha: widget.isFooterItem ? 0.1 : 0.16),
                    splashColor: Theme.of(context).colorScheme.primary
                        .withValues(alpha: widget.isFooterItem ? 0.07 : 0.1),
                    borderRadius: BorderRadius.circular(AppTheme.borderRadiusM),
                    child: _buildItemContent(),
                  ),
          ),
        ),
      ),
    );

    if (widget.isSubItem) {
      return Padding(
        padding: EdgeInsets.only(
          left: isSmallScreen ? AppTheme.spacingS : AppTheme.spacingM,
        ),
        child: content,
      );
    }

    return content;
  }

  Widget _buildItemContent() {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final Color primaryColor = isDarkMode
        ? const Color(0xFF1565C0) // Cor específica para modo dark
        : Theme.of(context).colorScheme.primary;
    final Color onSurfaceColor = Theme.of(context).colorScheme.onSurface;
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;
    final isSmallScreen = screenHeight < 700; // Detecta telas pequenas

    // Sistema de responsividade inteligente
    final responsiveSpacing = AppTheme.getResponsiveSpacing(
      screenWidth,
      AppTheme.spacingM,
    );
    final responsiveSpacingS = AppTheme.getResponsiveSpacing(
      screenWidth,
      AppTheme.spacingS,
    );
    final responsiveSpacingXS = AppTheme.getResponsiveSpacing(
      screenWidth,
      AppTheme.spacingXS,
    );

    // Define a decoração baseada nos estados
    BoxDecoration decoration;
    if (widget.isSelected) {
      decoration = BoxDecoration(
        color: primaryColor.withValues(alpha: 0.15),
        border: Border(left: BorderSide(color: primaryColor, width: 3)),
      );
    } else if (_isHovered) {
      decoration = BoxDecoration(
        color: primaryColor.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(AppTheme.borderRadiusM),
      );
    } else {
      decoration = BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(AppTheme.borderRadiusM),
      );
    }

    // Define a decoração do ícone baseada nos estados
    BoxDecoration iconDecoration;
    Color iconColor;
    FontWeight titleFontWeight = FontWeight.w500;
    Color titleColor = onSurfaceColor.withValues(
      alpha: widget.isFooterItem ? 0.8 : 0.95,
    );

    if (widget.isSelected) {
      iconDecoration = BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(AppTheme.borderRadiusS),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withValues(alpha: 0.3),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      );
      iconColor = Colors.white;
      titleFontWeight = FontWeight.w700;
      titleColor = isDarkMode
          ? const Color(0xFFF5F5F5) // Tom de branco suave para modo dark
          : primaryColor;
    } else if (_isHovered) {
      iconDecoration = BoxDecoration(
        color: primaryColor.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppTheme.borderRadiusS),
      );
      iconColor = primaryColor;
      titleFontWeight = FontWeight.w600;
      titleColor = primaryColor;
    } else {
      iconDecoration = BoxDecoration(
        color: onSurfaceColor.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(AppTheme.borderRadiusS),
      );
      iconColor = onSurfaceColor.withValues(
        alpha: widget.isFooterItem ? 0.7 : 0.85,
      );
    }

    return AnimatedContainer(
      duration: AppAnimations.normal,
      curve: AppAnimations.easeInOut,
      margin: EdgeInsets.symmetric(
        vertical: isSmallScreen ? 2 : responsiveSpacingXS / 2,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: isSmallScreen ? responsiveSpacingS : responsiveSpacing,
        vertical: isSmallScreen ? responsiveSpacingXS : responsiveSpacingS,
      ),
      decoration: decoration,
      child: Row(
        children: [
          // Ícone
          AnimatedContainer(
            duration: AppAnimations.normal,
            curve: AppAnimations.easeOut,
            width: isSmallScreen
                ? AppTheme.getResponsiveIconSize(screenWidth, 28)
                : AppTheme.getResponsiveIconSize(screenWidth, 32),
            height: isSmallScreen
                ? AppTheme.getResponsiveIconSize(screenWidth, 28)
                : AppTheme.getResponsiveIconSize(screenWidth, 32),
            decoration: iconDecoration,
            child: Icon(
              widget.item.icon,
              size: isSmallScreen
                  ? AppTheme.getResponsiveIconSize(screenWidth, 16)
                  : AppTheme.getResponsiveIconSize(screenWidth, 18),
              color: iconColor,
            ),
          ),
          SizedBox(
            width: isSmallScreen ? responsiveSpacingS : responsiveSpacing,
          ),
          // Título
          Expanded(
            child: AnimatedDefaultTextStyle(
              duration: AppAnimations.fast,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: titleFontWeight,
                fontSize: isSmallScreen
                    ? AppTheme.getResponsiveFontSize(screenWidth, 13)
                    : AppTheme.getResponsiveFontSize(screenWidth, 14),
                color: titleColor,
              ),
              child: Text(
                widget.item.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
