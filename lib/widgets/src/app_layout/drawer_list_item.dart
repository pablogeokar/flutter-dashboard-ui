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
        padding: const EdgeInsets.only(left: AppTheme.spacingM),
        child: content,
      );
    }

    return content;
  }

  Widget _buildItemContent() {
    return AnimatedContainer(
      duration: AppAnimations.normal,
      curve: AppAnimations.easeInOut,
      margin: const EdgeInsets.symmetric(vertical: AppTheme.spacingXS / 2),
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacingM,
        vertical: AppTheme.spacingS,
      ),
      decoration: BoxDecoration(
        color: widget.isSelected
            ? Theme.of(context).colorScheme.primary.withValues(
                alpha: Theme.of(context).brightness == Brightness.dark
                    ? 0.15
                    : 0.08,
              )
            : _isHovered
            ? Theme.of(context).colorScheme.primary.withValues(
                alpha: Theme.of(context).brightness == Brightness.dark
                    ? (widget.isFooterItem ? 0.08 : 0.12)
                    : (widget.isFooterItem ? 0.04 : 0.06),
              )
            : null,
        // Só aplica borderRadius quando não há borda lateral
        borderRadius: widget.isSelected
            ? null
            : BorderRadius.circular(AppTheme.borderRadiusM),
        border: widget.isSelected
            ? Border(
                left: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                  width: 3,
                ),
                top: BorderSide.none,
                right: BorderSide.none,
                bottom: BorderSide.none,
              )
            : null, // Remove a borda transparente que causa conflito
        boxShadow: widget.isSelected
            ? [
                BoxShadow(
                  color: Theme.of(
                    context,
                  ).colorScheme.primary.withValues(alpha: 0.15),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                  spreadRadius: 0,
                ),
                BoxShadow(
                  color: Theme.of(
                    context,
                  ).colorScheme.primary.withValues(alpha: 0.08),
                  blurRadius: 4,
                  offset: const Offset(2, 0),
                  spreadRadius: 0,
                ),
              ]
            : _isHovered
            ? [
                BoxShadow(
                  color: Theme.of(
                    context,
                  ).colorScheme.primary.withValues(alpha: 0.08),
                  blurRadius: 4,
                  offset: const Offset(0, 1),
                  spreadRadius: 0,
                ),
              ]
            : null,
      ),
      child: Row(
        children: [
          // Flexible content area
          Expanded(
            child: Row(
              children: [
                // Icon com animação e destaque
                AnimatedContainer(
                  duration: AppAnimations.normal,
                  curve: AppAnimations.easeOut,
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: widget.isSelected
                        ? Theme.of(context).colorScheme.primary
                        : _isHovered
                        ? Theme.of(context).brightness == Brightness.dark
                              ? Theme.of(
                                  context,
                                ).colorScheme.primary.withValues(alpha: 0.3)
                              : Theme.of(
                                  context,
                                ).colorScheme.primary.withValues(alpha: 0.12)
                        : Theme.of(context).brightness == Brightness.dark
                        ? Theme.of(
                            context,
                          ).colorScheme.onSurface.withValues(alpha: 0.08)
                        : Theme.of(
                            context,
                          ).colorScheme.onSurface.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(AppTheme.borderRadiusS),
                    boxShadow: widget.isSelected
                        ? [
                            BoxShadow(
                              color: Theme.of(
                                context,
                              ).colorScheme.primary.withValues(alpha: 0.3),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ]
                        : null,
                  ),
                  child: AnimatedRotation(
                    duration: AppAnimations.fast,
                    turns: _isHovered ? 0.02 : 0.0,
                    child: Icon(
                      widget.item.icon,
                      size: 18,
                      color: widget.isSelected
                          ? Colors.white
                          : _isHovered
                          ? Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Theme.of(context).colorScheme.primary
                          : Theme.of(context).brightness == Brightness.dark
                          ? Theme.of(context).colorScheme.onSurface.withValues(
                              alpha: widget.isFooterItem ? 0.8 : 0.95,
                            )
                          : Theme.of(context).colorScheme.onSurface.withValues(
                              alpha: widget.isFooterItem ? 0.7 : 0.85,
                            ),
                    ),
                  ),
                ),
                const SizedBox(width: AppTheme.spacingM),
                // Title com animação e melhor destaque
                Expanded(
                  child: AnimatedDefaultTextStyle(
                    duration: AppAnimations.fast,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: widget.isSelected
                          ? FontWeight.w700
                          : _isHovered
                          ? FontWeight.w600
                          : FontWeight.w500,
                      fontSize: widget.isSelected ? 15 : 14,
                      letterSpacing: widget.isSelected ? 0.2 : 0.0,
                      color: widget.isSelected
                          ? Theme.of(context).colorScheme.primary
                          : _isHovered
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.onSurface.withValues(
                              alpha: widget.isFooterItem ? 0.8 : 0.95,
                            ),
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
          ),
        ],
      ),
    );
  }
}
