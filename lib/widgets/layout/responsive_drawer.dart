import 'package:flutter/material.dart';
import 'drawer_item.dart';
import 'drawer_list_item.dart'; // Import the new widget
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
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerLow,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(AppTheme.borderRadiusXL),
          bottomRight: Radius.circular(AppTheme.borderRadiusXL),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(5, 0),
          ),
        ],
      ),
      child: Drawer(
        elevation: 0,
        backgroundColor: Theme.of(
          context,
        ).colorScheme.surface, // Definindo a cor de fundo do drawer
        child: Container(
          color: Theme.of(
            context,
          ).colorScheme.surface, // Cor de fundo explícita para o container
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: AppTheme.appBarHeight), // Add space to align with AppBar
              const SizedBox(height: AppTheme.spacingL),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingM),
                  itemCount: itensPrincipais.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: AppTheme.spacingXS),
                  itemBuilder: (context, index) {
                    // Use the new widget
                    return DrawerListItem(
                      item: itensPrincipais[index],
                      isSelected: currentIndex == index,
                      onTap: () => onTap(index),
                    );
                  },
                ),
              ),
              ListView.separated(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingM),
                itemCount: itensInferiores.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: AppTheme.spacingXS),
                itemBuilder: (context, index) {
                  final itemIndex = itensPrincipais.length + index;
                  // Use the new widget
                  return DrawerListItem(
                    item: itensInferiores[index],
                    isSelected: currentIndex == itemIndex,
                    onTap: () => onTap(itemIndex),
                  );
                },
              ),
              const SizedBox(height: AppTheme.spacingL),
              _buildFooter(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingM),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(AppTheme.spacingXS),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(AppTheme.borderRadiusS),
            ),
            child: Icon(
              Icons.info_outline,
              size: 14,
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
          const SizedBox(width: AppTheme.spacingS),
          Text(
            'v1.0.0',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withOpacity(0.6),
                ),
          ),
        ],
      ),
    );
  }
  // _buildDrawerItem method is removed
}