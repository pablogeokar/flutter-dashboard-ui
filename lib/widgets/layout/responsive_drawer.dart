import 'package:flutter/material.dart';
import '../../theme.dart';

class ResponsiveDrawer extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const ResponsiveDrawer({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final List<DrawerItem> items = [
      const DrawerItem(
        title: 'Painel Principal',
        icon: Icons.dashboard,
        index: 0,
      ),
      const DrawerItem(title: 'Análises', icon: Icons.analytics, index: 1),
      const DrawerItem(
        title: 'Relatórios',
        icon: Icons.insert_drive_file,
        index: 2,
      ),
      const DrawerItem(title: 'Projetos', icon: Icons.folder, index: 3),
      const DrawerItem(
        title: 'Calendário',
        icon: Icons.calendar_today,
        index: 4,
      ),
    ];

    final List<DrawerItem> bottomItems = [
      const DrawerItem(title: 'Configurações', icon: Icons.settings, index: 5),
      const DrawerItem(title: 'Perfil', icon: Icons.person, index: 6),
    ];

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
                itemCount: items.length + 1, // +1 for the separator
                separatorBuilder: (context, index) {
                  if (index == items.length) {
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
                  if (index < items.length) {
                    final item = items[index];
                    return _buildDrawerItem(context, item);
                  } else {
                    // Render the bottom items
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Column(
                        children: bottomItems
                            .map((item) => _buildDrawerItem(context, item))
                            .toList(),
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
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'v1.0.0',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
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

  Widget _buildDrawerItem(BuildContext context, DrawerItem item) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2.0),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Icon(
          item.icon,
          color: currentIndex == item.index
              ? AppTheme
              .primary // Your primary color from theme file
              : Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        title: Text(
          item.title,
          style: TextStyle(
            fontWeight: currentIndex == item.index
                ? FontWeight.w600
                : FontWeight.normal,
            color: currentIndex == item.index
                ? AppTheme
                .primary // Your primary color from theme file
                : Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        selected: currentIndex == item.index,
        selectedTileColor: AppTheme.primary.withValues(alpha: 0.15), // Your primary color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: currentIndex == item.index
                ? AppTheme.primary.withValues(alpha: 0.5) // Your primary color
                : Colors.transparent,
            width: 0.5,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        onTap: () => onTap(item.index),
      ),
    );
  }
}

class DrawerItem {
  final String title;
  final IconData icon;
  final int index;

  const DrawerItem({
    required this.title,
    required this.icon,
    required this.index,
  });
}