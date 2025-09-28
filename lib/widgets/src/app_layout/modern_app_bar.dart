import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/theme/theme.dart';
import '/theme/theme_manager.dart';

/// A `AppBar` customizada e transparente da aplicação.
///
/// Implementa `PreferredSizeWidget` para garantir que ela tenha a altura
/// correta definida em `AppTheme.appBarHeight`.
class ModernAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isLargeScreen;

  const ModernAppBar({super.key, required this.isLargeScreen});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      toolbarHeight: AppTheme.appBarHeight,
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: !isLargeScreen,
      leading: isLargeScreen
          ? null
          : Builder(
              builder: (context) {
                return IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                  iconSize: 24.0,
                );
              },
            ),
      title: null,
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_outlined),
          onPressed: () {},
          iconSize: 22.0,
          tooltip: 'Notificações',
        ),
        Consumer<ThemeManager>(
          builder: (context, themeManager, child) {
            return IconButton(
              icon: Icon(
                themeManager.currentTheme == ThemeModeType.dark
                    ? Icons.light_mode_outlined
                    : Icons.dark_mode_outlined,
              ),
              onPressed: () {
                themeManager.toggleTheme();
              },
              iconSize: 22.0,
              tooltip: 'Alternar Tema',
            );
          },
        ),
        const SizedBox(width: AppTheme.spacingS),
        const CircleAvatar(
          radius: AppTheme.avatarSizeSmall,
          child: Icon(Icons.person_outline, size: 22.0),
        ),
        const SizedBox(width: AppTheme.spacingM),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(AppTheme.appBarHeight);
}
