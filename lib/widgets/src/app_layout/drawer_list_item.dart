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
      child: Container(
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
                    focusColor: Theme.of(
                      context,
                    ).colorScheme.primary.withValues(alpha: 0.15),
                    highlightColor: Theme.of(context).colorScheme.primary
                        .withValues(alpha: 0.2), // Mais visível
                    splashColor: Theme.of(context).colorScheme.primary
                        .withValues(alpha: 0.3), // Muito mais visível
                    borderRadius: BorderRadius.circular(AppTheme.borderRadiusM),
                    splashFactory:
                        InkRipple.splashFactory, // Ripple mais dramático
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
      if (widget.isSubItem) {
        // Estilo destacado para subitens selecionados
        decoration = BoxDecoration(
          color: primaryColor.withValues(alpha: 0.1),
          border: Border(left: BorderSide(color: primaryColor, width: 4)),
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(AppTheme.borderRadiusM),
            bottomRight: Radius.circular(AppTheme.borderRadiusM),
          ),
        );
      } else {
        // Estilo normal para itens principais selecionados
        decoration = BoxDecoration(
          color: primaryColor.withValues(alpha: 0.15),
          border: Border(left: BorderSide(color: primaryColor, width: 3)),
        );
      }
    } else if (_isHovered) {
      if (widget.isSubItem) {
        // Estilo atrativo para subitens no hover
        decoration = BoxDecoration(
          color: isDarkMode
              ? const Color(0xFF4B5563).withValues(alpha: 0.3)
              : const Color(0xFFF3F4F6).withValues(alpha: 0.7),
          border: Border(
            left: BorderSide(
              color: isDarkMode
                  ? const Color(0xFF9CA3AF)
                  : const Color(0xFF9CA3AF),
              width: 3,
            ),
          ),
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(AppTheme.borderRadiusS),
            bottomRight: Radius.circular(AppTheme.borderRadiusS),
          ),
        );
      } else {
        // Estilo normal para itens principais no hover
        decoration = BoxDecoration(
          color: isDarkMode
              ? const Color(0xFF4A5568).withValues(alpha: 0.6)
              : primaryColor.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(AppTheme.borderRadiusM),
        );
      }
    } else {
      if (widget.isSubItem) {
        // Estilo sutil mas visível para subitens normais
        decoration = BoxDecoration(
          color: Colors.transparent,
          border: Border(
            left: BorderSide(
              color: isDarkMode
                  ? const Color(0xFF6B7280).withValues(alpha: 0.4)
                  : const Color(0xFFD1D5DB).withValues(alpha: 0.7),
              width: 2,
            ),
          ),
        );
      } else {
        // Estilo normal para itens principais
        decoration = BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(AppTheme.borderRadiusM),
        );
      }
    }

    // Define a decoração do ícone baseada nos estados
    BoxDecoration iconDecoration;
    Color iconColor;
    FontWeight titleFontWeight = FontWeight.w500;
    Color titleColor = onSurfaceColor.withValues(
      alpha: widget.isFooterItem ? 0.8 : 0.95,
    );

    if (widget.isSelected) {
      if (widget.isSubItem) {
        // Estilo atrativo para subitens selecionados
        iconDecoration = BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(AppTheme.borderRadiusS),
          boxShadow: [
            BoxShadow(
              color: primaryColor.withValues(alpha: 0.3),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        );
        iconColor = Colors.white;
        titleFontWeight = FontWeight.w600;
        titleColor = isDarkMode
            ? const Color(0xFFF5F5F5) // Branco suave para subitens selecionados
            : primaryColor;
      } else {
        // Estilo normal para itens principais selecionados
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
      }
    } else if (_isHovered) {
      if (widget.isSubItem) {
        // Estilo atrativo para subitens no hover
        iconDecoration = BoxDecoration(
          color: isDarkMode
              ? const Color(0xFF6B7280).withValues(alpha: 0.6)
              : const Color(0xFF9CA3AF).withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(AppTheme.borderRadiusS),
        );
        iconColor = isDarkMode
            ? const Color(0xFFE5E7EB) // Cinza claro para ícone no hover
            : const Color(0xFF4B5563);
        titleFontWeight = FontWeight.w500;
        titleColor = isDarkMode
            ? const Color(0xFFE5E7EB) // Cinza claro para texto no hover
            : const Color(0xFF4B5563);
      } else {
        // Estilo normal para itens principais no hover
        iconDecoration = BoxDecoration(
          color: isDarkMode
              ? const Color(0xFF6B7280).withValues(alpha: 0.3)
              : primaryColor.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(AppTheme.borderRadiusS),
        );
        iconColor = isDarkMode
            ? const Color(0xFFE5E7EB) // Cinza claro para ícone no modo dark
            : primaryColor;
        titleFontWeight = FontWeight.w600;
        titleColor = isDarkMode
            ? const Color(0xFFE5E7EB) // Cinza claro para texto no modo dark
            : primaryColor;
      }
    } else {
      if (widget.isSubItem) {
        // Estilo visível e atrativo para subitens normais
        iconDecoration = BoxDecoration(
          color: isDarkMode
              ? const Color(0xFF4B5563).withValues(alpha: 0.4)
              : const Color(0xFFE5E7EB).withValues(alpha: 0.7),
          borderRadius: BorderRadius.circular(AppTheme.borderRadiusS),
        );
        iconColor = isDarkMode
            ? const Color(0xFFD1D5DB) // Cinza claro para ícones de subitens
            : const Color(0xFF6B7280);
        titleFontWeight = FontWeight.w500; // Peso normal para subitens
        titleColor = isDarkMode
            ? const Color(0xFFD1D5DB) // Cinza claro para texto de subitens
            : const Color(0xFF6B7280);
      } else {
        // Estilo normal para itens principais
        iconDecoration = BoxDecoration(
          color: onSurfaceColor.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(AppTheme.borderRadiusS),
        );
        iconColor = onSurfaceColor.withValues(
          alpha: widget.isFooterItem ? 0.7 : 0.85,
        );
      }
    }

    return Container(
      margin: EdgeInsets.symmetric(vertical: isSmallScreen ? 2 : 4),
      padding: EdgeInsets.symmetric(
        horizontal: AppTheme.getResponsiveSpacing(
          screenWidth,
          20,
        ), // 20px horizontal padronizado
        vertical: AppTheme.getResponsiveSpacing(
          screenWidth,
          16,
        ), // 16px vertical padronizado
      ),
      decoration: decoration,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Ícone simples
          Container(
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
          // Título simples
          Expanded(
            child: Text(
              widget.item.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: titleFontWeight,
                fontSize: isSmallScreen
                    ? AppTheme.getResponsiveFontSize(screenWidth, 13)
                    : AppTheme.getResponsiveFontSize(screenWidth, 14),
                color: titleColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
