import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/theme/theme.dart';
import '/theme/theme_manager.dart';

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
        IconButton(
          icon: Icon(
            Provider.of<ThemeManager>(context, listen: false).currentTheme ==
                    ThemeModeType.dark
                ? Icons.light_mode_outlined
                : Icons.dark_mode_outlined,
          ),
          onPressed: () {
            Provider.of<ThemeManager>(context, listen: false).toggleTheme();
          },
          iconSize: 22.0,
          tooltip: 'Alternar Tema',
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
