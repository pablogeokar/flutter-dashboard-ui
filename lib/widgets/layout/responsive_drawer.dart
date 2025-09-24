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
            color: Colors.black.withValues(alpha: 0.1),
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
              _buildHeader(context),
              SizedBox(height: AppTheme.spacingL),
              Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(horizontal: AppTheme.spacingM),
                  itemCount: itensPrincipais.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 4),
                  itemBuilder: (context, index) {
                    return _buildDrawerItem(
                      context,
                      itensPrincipais[index],
                      index,
                    );
                  },
                ),
              ),
              const Spacer(),
              ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: AppTheme.spacingM),
                itemCount: itensInferiores.length,
                separatorBuilder: (context, index) => const SizedBox(height: 4),
                itemBuilder: (context, index) {
                  final itemIndex = itensPrincipais.length + index;
                  return _buildDrawerItem(
                    context,
                    itensInferiores[index],
                    itemIndex,
                  );
                },
              ),
              SizedBox(height: AppTheme.spacingL),
              _buildFooter(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        AppTheme.spacingM,
        AppTheme.spacingL * 2.5,
        AppTheme.spacingM,
        AppTheme.spacingM,
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Image.asset('assets/eikos.png', height: 60, fit: BoxFit.contain),
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppTheme.spacingM),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(
              AppTheme.spacingS / 2,
            ), // 6 é metade de spacingS (8)
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(AppTheme.borderRadiusS),
            ),
            child: Icon(
              Icons.info_outline,
              size: 14,
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
          SizedBox(width: AppTheme.spacingS),
          Text(
            'v1.0.0',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.6),
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

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: EdgeInsets.symmetric(
        vertical: AppTheme.spacingXS / 2,
      ), // 2 é metade de spacingXS (4)
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppTheme.borderRadiusM),
        color: isSelected
            ? AppTheme.primary.withValues(alpha: 0.15)
            : Colors.transparent,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppTheme.borderRadiusM),
          onTap: () => onTap(itemIndex),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppTheme.spacingM,
              vertical: AppTheme.spacingS,
            ),
            child: Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: isSelected ? AppTheme.primary : Colors.transparent,
                    borderRadius: BorderRadius.circular(
                      AppTheme.borderRadiusS / 2,
                    ), // 6 é metade de borderRadiusS (12)
                  ),
                  child: Icon(
                    item.icon,
                    size: 18,
                    color: isSelected
                        ? Theme.of(context).colorScheme.onPrimary
                        : Theme.of(
                            context,
                          ).colorScheme.onSurface.withValues(alpha: 0.8),
                  ),
                ),
                SizedBox(
                  width: AppTheme.spacingM,
                ), // 12 está entre spacingS (8) e spacingM (16)
                Expanded(
                  child: Text(
                    item.title,
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
        ),
      ),
    );
  }
}
