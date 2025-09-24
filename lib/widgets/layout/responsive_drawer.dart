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
    return Card(
      elevation: 2.0,
      margin: const EdgeInsets.all(0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Drawer(
        elevation: 0,
        child: Container(
          color: Theme.of(context).colorScheme.surfaceContainerLow,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildHeader(context),
              const SizedBox(height: 20),
              Expanded(
                child: _buildNavigation(context),
              ),
              _buildFooter(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(
                'assets/eikos.png',
                height: 40,
                fit: BoxFit.contain,
              ),
              const SizedBox(width: 12),
              Text(
                'Painel',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Divider(
            color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
            height: 1,
          ),
        ],
      ),
    );
  }

  Widget _buildNavigation(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: itensPrincipais.length + itensInferiores.length,
      separatorBuilder: (context, index) {
        if (index == itensPrincipais.length - 1) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Divider(
              color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
              indent: 16,
              endIndent: 16,
            ),
          );
        }
        return const SizedBox(height: 4);
      },
      itemBuilder: (context, index) {
        final item = (index < itensPrincipais.length)
            ? itensPrincipais[index]
            : itensInferiores[index - itensPrincipais.length];
        final itemIndex = index;

        return _buildDrawerItem(context, item, itemIndex);
      },
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.info_outline,
            size: 14,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
          ),
          const SizedBox(width: 8),
          Text(
            'v1.0.0',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context,
    DrawerItem item,
    int itemIndex,
  ) {
    final bool isSelected = currentIndex == itemIndex;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: isSelected ? AppTheme.primary.withOpacity(0.15) : null,
      ),
      child: ListTile(
        leading: Icon(
          item.icon,
          size: 22,
          color: isSelected
              ? AppTheme.primary
              : Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
        ),
        title: Text(
          item.title,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected
                    ? AppTheme.primary
                    : Theme.of(context).colorScheme.onSurface,
              ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        onTap: () => onTap(itemIndex),
      ),
    );
  }
}
