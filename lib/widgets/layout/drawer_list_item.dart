import 'package:flutter/material.dart';
import '../../theme.dart';
import 'drawer_item.dart';

class DrawerListItem extends StatelessWidget {
  final DrawerItem item;
  final bool isSelected;
  final VoidCallback onTap;

  const DrawerListItem({
    super.key,
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppTheme.borderRadiusM),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          hoverColor: AppTheme.primary.withOpacity(0.08),
          borderRadius: BorderRadius.circular(AppTheme.borderRadiusM),
          child: Container(
            margin: const EdgeInsets.symmetric(
              vertical: AppTheme.spacingXS / 2,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.spacingM,
              vertical: AppTheme.spacingS,
            ),
            child: Row(
              children: [
                // The "pill" indicator
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: 4,
                  height: 28,
                  decoration: BoxDecoration(
                    color: isSelected ? AppTheme.primary : Colors.transparent,
                    borderRadius: BorderRadius.circular(AppTheme.borderRadiusS),
                  ),
                ),
                // Flexible content area
                Expanded(
                  child: Row(
                    children: [
                      const SizedBox(width: AppTheme.spacingM),
                      // Icon
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(
                            AppTheme.borderRadiusS / 2,
                          ),
                        ),
                        child: Icon(
                          item.icon,
                          size: 18,
                          color: isSelected
                              ? AppTheme.primary
                              : Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
                        ),
                      ),
                      const SizedBox(width: AppTheme.spacingM),
                      // Title
                      Expanded(
                        child: Text(
                          item.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: isSelected
                                    ? AppTheme.primary
                                    : Theme.of(context).colorScheme.onSurface,
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
  }
}
