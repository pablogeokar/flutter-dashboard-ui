import 'package:flutter/material.dart';
import '../../../theme/theme.dart';
import 'drawer_item.dart';

class DrawerListItem extends StatelessWidget {
  final DrawerItem item;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isSubItem;
  final bool isFooterItem; // Novo parâmetro para itens da parte inferior

  const DrawerListItem({
    super.key,
    required this.item,
    required this.isSelected,
    required this.onTap,
    this.isSubItem = false,
    this.isFooterItem = false,
  });

  @override
  Widget build(BuildContext context) {
    Widget content = ClipRRect(
      borderRadius: BorderRadius.circular(AppTheme.borderRadiusM),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          hoverColor: Theme.of(
            context,
          ).colorScheme.primary.withValues(alpha: isFooterItem ? 0.05 : 0.08),
          focusColor: Theme.of(
            context,
          ).colorScheme.primary.withValues(alpha: isFooterItem ? 0.08 : 0.12),
          highlightColor: Theme.of(
            context,
          ).colorScheme.primary.withValues(alpha: isFooterItem ? 0.1 : 0.16),
          splashColor: Theme.of(
            context,
          ).colorScheme.primary.withValues(alpha: isFooterItem ? 0.07 : 0.1),
          borderRadius: BorderRadius.circular(AppTheme.borderRadiusM),
          child: Container(
            margin: const EdgeInsets.symmetric(
              vertical: AppTheme.spacingXS / 2,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.spacingM,
              vertical: AppTheme.spacingS,
            ),
            decoration: BoxDecoration(
              color: isSelected
                  ? Theme.of(context).colorScheme.primaryContainer.withValues(
                      alpha: isFooterItem ? 0.15 : 0.2,
                    )
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(AppTheme.borderRadiusM),
              border: Border.all(
                color: isSelected
                    ? Theme.of(context).colorScheme.primary.withValues(
                        alpha: isFooterItem ? 0.5 : 0.7,
                      )
                    : Colors.transparent,
                width: 1,
              ),
            ),
            child: Row(
              children: [
                // Flexible content area
                Expanded(
                  child: Row(
                    children: [
                      // Icon
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Theme.of(context).colorScheme.primaryContainer
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(
                            AppTheme.borderRadiusS / 2,
                          ),
                        ),
                        child: Icon(
                          item.icon,
                          size: 18,
                          color: isSelected
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(
                                  context,
                                ).colorScheme.onSurface.withValues(
                                  alpha: isFooterItem ? 0.7 : 0.9,
                                ),
                        ),
                      ),
                      const SizedBox(width: AppTheme.spacingM),
                      // Title
                      Expanded(
                        child: Text(
                          item.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: isSelected
                                    ? Theme.of(context).colorScheme.primary
                                    : Theme.of(
                                        context,
                                      ).colorScheme.onSurface.withValues(
                                        alpha: isFooterItem ? 0.8 : 1.0,
                                      ),
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
    );

    if (isSubItem) {
      return Padding(
        padding: const EdgeInsets.only(left: AppTheme.spacingM),
        child: content,
      );
    }

    return content;
  }
}
