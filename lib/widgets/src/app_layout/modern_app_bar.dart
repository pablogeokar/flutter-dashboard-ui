import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/theme/theme.dart';
import '/theme/theme_manager.dart';
import '/theme/animations.dart';

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
        _AnimatedIconButton(
          icon: Icons.notifications_outlined,
          onPressed: () {},
          tooltip: 'Notificações',
        ),
        Consumer<ThemeManager>(
          builder: (context, themeManager, child) {
            return _AnimatedIconButton(
              icon: themeManager.currentTheme == ThemeModeType.dark
                  ? Icons.light_mode_outlined
                  : Icons.dark_mode_outlined,
              onPressed: () {
                themeManager.toggleTheme();
              },
              tooltip: 'Alternar Tema',
            );
          },
        ),
        const SizedBox(width: AppTheme.spacingS),
        const _AnimatedAvatar(),
        const SizedBox(width: AppTheme.spacingM),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(AppTheme.appBarHeight);
}

/// Botão de ícone animado para a AppBar
class _AnimatedIconButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final String tooltip;

  const _AnimatedIconButton({
    required this.icon,
    required this.onPressed,
    required this.tooltip,
  });

  @override
  State<_AnimatedIconButton> createState() => _AnimatedIconButtonState();
}

class _AnimatedIconButtonState extends State<_AnimatedIconButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: AppAnimations.fast,
        curve: AppAnimations.easeOut,
        transform: _isHovered
            ? Matrix4.diagonal3Values(1.1, 1.1, 1.0)
            : Matrix4.identity(),
        child: IconButton(
          icon: AnimatedRotation(
            duration: AppAnimations.normal,
            turns: _isHovered ? 0.05 : 0.0,
            child: Icon(widget.icon),
          ),
          onPressed: widget.onPressed,
          iconSize: 22.0,
          tooltip: widget.tooltip,
          style: IconButton.styleFrom(
            backgroundColor: _isHovered
                ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.1)
                : Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppTheme.borderRadiusS),
            ),
          ),
        ),
      ),
    );
  }
}

/// Avatar animado para a AppBar
class _AnimatedAvatar extends StatefulWidget {
  const _AnimatedAvatar();

  @override
  State<_AnimatedAvatar> createState() => _AnimatedAvatarState();
}

class _AnimatedAvatarState extends State<_AnimatedAvatar> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: AppAnimations.fast,
        curve: AppAnimations.easeOut,
        transform: _isHovered
            ? Matrix4.diagonal3Values(1.1, 1.1, 1.0)
            : Matrix4.identity(),
        child: AnimatedContainer(
          duration: AppAnimations.normal,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: Theme.of(
                        context,
                      ).colorScheme.primary.withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: CircleAvatar(
            radius: AppTheme.avatarSizeSmall,
            backgroundColor: _isHovered
                ? Theme.of(context).colorScheme.primaryContainer
                : Theme.of(context).colorScheme.surfaceContainerHighest,
            child: Icon(
              Icons.person_outline,
              size: 22.0,
              color: _isHovered
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
      ),
    );
  }
}
