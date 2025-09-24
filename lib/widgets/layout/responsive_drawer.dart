import 'package:flutter/material.dart';
import 'drawer_item.dart';
import '../../theme.dart';

class ResponsiveDrawer extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final List<DrawerItem> itensPrincipais;
  final List<DrawerItem> itensInferiores;

  const ResponsiveDrawer({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.itensPrincipais,
    required this.itensInferiores,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Theme.of(
          context,
        ).colorScheme.surface, // Dark background for drawer
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Enhanced header with logo
            Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Theme.of(
                  context,
                ).colorScheme.surface, // Match sidebar background
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Logo area - using image instead of CircleAvatar for rectangular logo
                  Container(
                    height: 60,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Image.asset(
                      'assets/eikos.png',
                      fit: BoxFit.contain,
                      // Remove color property to show logo in original colors
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    height: 1,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Painel Administrativo',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.only(left: 16, right: 16),
                itemCount: itensPrincipais.length + 1, // +1 for the separator
                separatorBuilder: (context, index) {
                  if (index == itensPrincipais.length) {
                    // Add a separator before the bottom items
                    return Container(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Divider(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                    );
                  }
                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                    child: Divider(
                      color: Theme.of(
                        context,
                      ).colorScheme.outline.withValues(alpha: 0.3),
                    ),
                  );
                },
                itemBuilder: (context, index) {
                  if (index < itensPrincipais.length) {
                    final item = itensPrincipais[index];
                    return _buildDrawerItem(context, item, index);
                  } else {
                    // Render the bottom items
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Column(
                        children: itensInferiores.asMap().entries.map((entry) {
                          final index = entry.key;
                          final item = entry.value;
                          return _buildDrawerItem(
                            context,
                            item,
                            itensPrincipais.length + index,
                          );
                        }).toList(),
                      ),
                    );
                  }
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    size: 16,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'v1.0.0',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context,
    DrawerItem item,
    int itemIndex,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2.0),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Icon(
          item.icon,
          color: currentIndex == itemIndex
              ? AppTheme
                    .primary // Your primary color from theme file
              : Theme.of(context).colorScheme.onSurface,
        ),
        title: Text(
          item.title,
          style: TextStyle(
            fontWeight: currentIndex == itemIndex
                ? FontWeight.w600
                : FontWeight.normal,
            color: currentIndex == itemIndex
                ? AppTheme
                      .primary // Your primary color from theme file
                : Theme.of(context).colorScheme.onSurface,
          ),
        ),
        selected: currentIndex == itemIndex,
        selectedTileColor: AppTheme.primary.withValues(
          alpha: 0.15,
        ), // Your primary color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: currentIndex == itemIndex
                ? AppTheme.primary.withValues(alpha: 0.5) // Your primary color
                : Colors.transparent,
            width: 0.5,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        onTap: () => onTap(itemIndex),
      ),
    );
  }
}
