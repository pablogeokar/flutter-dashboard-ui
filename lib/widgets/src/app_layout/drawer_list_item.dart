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
            child: InkWell(
              onTap: widget.onTap,
              hoverColor: Colors.transparent, // Controlamos o hover manualmente
              focusColor: Theme.of(context).colorScheme.primary.withValues(
                alpha: widget.isFooterItem ? 0.08 : 0.12,
              ),
              highlightColor: Theme.of(context).colorScheme.primary.withValues(
                alpha: widget.isFooterItem ? 0.1 : 0.16,
              ),
              splashColor: Theme.of(context).colorScheme.primary.withValues(
                alpha: widget.isFooterItem ? 0.07 : 0.1,
              ),
              borderRadius: BorderRadius.circular(AppTheme.borderRadiusM),
              child: AnimatedContainer(
                duration: AppAnimations.normal,
                curve: AppAnimations.easeInOut,
                margin: const EdgeInsets.symmetric(
                  vertical: AppTheme.spacingXS / 2,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacingM,
                  vertical: AppTheme.spacingS,
                ),
                decoration: BoxDecoration(
                  color: widget.isSelected
                      ? Theme.of(
                          context,
                        ).colorScheme.primary.withValues(alpha: 0.15)
                      : _isHovered
                      ? Theme.of(context).colorScheme.primary.withValues(
                          alpha: widget.isFooterItem ? 0.05 : 0.08,
                        )
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(AppTheme.borderRadiusM),
                  border: Border.all(
                    color: widget.isSelected
                        ? Theme.of(context).colorScheme.primary
                        : Colors.transparent,
                    width: 1,
                  ),
                  boxShadow: widget.isSelected || _isHovered
                      ? [
                          BoxShadow(
                            color: Theme.of(context).colorScheme.primary
                                .withValues(
                                  alpha: widget.isSelected ? 0.1 : 0.05,
                                ),
                            blurRadius: widget.isSelected ? 6 : 3,
                            offset: Offset(0, widget.isSelected ? 2 : 1),
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
                          // Icon com animação
                          AnimatedContainer(
                            duration: AppAnimations.normal,
                            curve: AppAnimations.easeOut,
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: widget.isSelected
                                  ? Theme.of(
                                      context,
                                    ).colorScheme.primaryContainer
                                  : _isHovered
                                  ? Theme.of(
                                      context,
                                    ).colorScheme.primary.withValues(alpha: 0.1)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(
                                AppTheme.borderRadiusS / 2,
                              ),
                            ),
                            child: AnimatedRotation(
                              duration: AppAnimations.fast,
                              turns: _isHovered ? 0.02 : 0.0,
                              child: Icon(
                                widget.item.icon,
                                size: 18,
                                color: widget.isSelected
                                    ? Theme.of(context).colorScheme.primary
                                    : _isHovered
                                    ? Theme.of(context).colorScheme.primary
                                    : Theme.of(
                                        context,
                                      ).colorScheme.onSurface.withValues(
                                        alpha: widget.isFooterItem ? 0.7 : 0.9,
                                      ),
                              ),
                            ),
                          ),
                          const SizedBox(width: AppTheme.spacingM),
                          // Title com animação
                          Expanded(
                            child: AnimatedDefaultTextStyle(
                              duration: AppAnimations.fast,
                              style: Theme.of(context).textTheme.bodyLarge!
                                  .copyWith(
                                    fontWeight: widget.isSelected
                                        ? FontWeight.bold
                                        : _isHovered
                                        ? FontWeight.w600
                                        : FontWeight.normal,
                                    color: widget.isSelected
                                        ? Theme.of(context).colorScheme.primary
                                        : _isHovered
                                        ? Theme.of(context).colorScheme.primary
                                        : Theme.of(
                                            context,
                                          ).colorScheme.onSurface.withValues(
                                            alpha: widget.isFooterItem
                                                ? 0.8
                                                : 1.0,
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
              ),
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
}
