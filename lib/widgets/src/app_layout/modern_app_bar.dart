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
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDarkMode
            ? AppTheme.drawerBackgroundDark.withValues(alpha: 0.95)
            : Colors.white.withValues(alpha: 0.95),
        border: Border(
          bottom: BorderSide(
            color: isDarkMode
                ? AppTheme.primaryDark.withValues(alpha: 0.1)
                : AppTheme.neutral200.withValues(alpha: 0.5),
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: isDarkMode
                ? Colors.black.withValues(alpha: 0.2)
                : Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: AppBar(
        elevation: 0,
        toolbarHeight: AppTheme.appBarHeight,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leading: isLargeScreen
            ? null
            : Builder(
                builder: (context) {
                  return Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isDarkMode
                          ? AppTheme.primaryDark.withValues(alpha: 0.1)
                          : AppTheme.neutral100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.menu_rounded,
                        color: isDarkMode
                            ? AppTheme.primaryDark
                            : Theme.of(context).colorScheme.primary,
                      ),
                      onPressed: () => Scaffold.of(context).openDrawer(),
                      iconSize: 22.0,
                    ),
                  );
                },
              ),
        title: isLargeScreen
            ? Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: isDarkMode
                            ? AppTheme.primaryDark.withValues(alpha: 0.1)
                            : Theme.of(
                                context,
                              ).colorScheme.primary.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isDarkMode
                              ? AppTheme.primaryDark.withValues(alpha: 0.2)
                              : Theme.of(
                                  context,
                                ).colorScheme.primary.withValues(alpha: 0.1),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.dashboard_rounded,
                            size: 18,
                            color: isDarkMode
                                ? AppTheme.primaryDark
                                : Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Dashboard Corporativo',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: isDarkMode
                                  ? AppTheme.primaryDark
                                  : Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : null,
        actions: [
          _PremiumSearchButton(),
          const SizedBox(width: 8),
          _AnimatedIconButton(
            icon: Icons.notifications_none_rounded,
            onPressed: () {},
            tooltip: 'Notificações',
            showBadge: true,
          ),
          const SizedBox(width: 8),
          Consumer<ThemeManager>(
            builder: (context, themeManager, child) {
              return _AnimatedIconButton(
                icon: themeManager.currentTheme == ThemeModeType.dark
                    ? Icons.light_mode_rounded
                    : Icons.dark_mode_rounded,
                onPressed: () {
                  themeManager.toggleTheme();
                },
                tooltip: 'Alternar Tema',
              );
            },
          ),
          const SizedBox(width: 12),
          const _PremiumAvatar(),
          const SizedBox(width: 16),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(AppTheme.appBarHeight);
}

/// Botão de ícone premium para a AppBar
class _AnimatedIconButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final String tooltip;
  final bool showBadge;

  const _AnimatedIconButton({
    required this.icon,
    required this.onPressed,
    required this.tooltip,
    this.showBadge = false,
  });

  @override
  State<_AnimatedIconButton> createState() => _AnimatedIconButtonState();
}

class _AnimatedIconButtonState extends State<_AnimatedIconButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: AppAnimations.fast,
        curve: AppAnimations.easeOut,
        transform: _isHovered
            ? Matrix4.diagonal3Values(1.05, 1.05, 1.0)
            : Matrix4.identity(),
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: _isHovered
                ? isDarkMode
                      ? AppTheme.primaryDark.withValues(alpha: 0.15)
                      : Theme.of(
                          context,
                        ).colorScheme.primary.withValues(alpha: 0.08)
                : isDarkMode
                ? AppTheme.neutral800.withValues(alpha: 0.3)
                : AppTheme.neutral100,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: _isHovered
                  ? isDarkMode
                        ? AppTheme.primaryDark.withValues(alpha: 0.3)
                        : Theme.of(
                            context,
                          ).colorScheme.primary.withValues(alpha: 0.2)
                  : isDarkMode
                  ? AppTheme.neutral700.withValues(alpha: 0.3)
                  : AppTheme.neutral200.withValues(alpha: 0.5),
              width: 1,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: isDarkMode
                          ? AppTheme.primaryDark.withValues(alpha: 0.2)
                          : Theme.of(
                              context,
                            ).colorScheme.primary.withValues(alpha: 0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Stack(
            children: [
              Center(
                child: IconButton(
                  icon: Icon(
                    widget.icon,
                    color: _isHovered
                        ? isDarkMode
                              ? AppTheme.primaryDark
                              : Theme.of(context).colorScheme.primary
                        : Theme.of(
                            context,
                          ).colorScheme.onSurface.withValues(alpha: 0.8),
                  ),
                  onPressed: widget.onPressed,
                  iconSize: 20.0,
                  tooltip: widget.tooltip,
                  padding: EdgeInsets.zero,
                ),
              ),
              if (widget.showBadge)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: const Color(
                        0xFFEF4444,
                      ), // Vermelho para notificação
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFEF4444).withValues(alpha: 0.3),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Avatar premium para a AppBar
class _PremiumAvatar extends StatefulWidget {
  const _PremiumAvatar();

  @override
  State<_PremiumAvatar> createState() => _PremiumAvatarState();
}

class _PremiumAvatarState extends State<_PremiumAvatar> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: AppAnimations.fast,
        curve: AppAnimations.easeOut,
        transform: _isHovered
            ? Matrix4.diagonal3Values(1.05, 1.05, 1.0)
            : Matrix4.identity(),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: _isHovered
                ? isDarkMode
                      ? AppTheme.primaryDark.withValues(alpha: 0.15)
                      : Theme.of(
                          context,
                        ).colorScheme.primary.withValues(alpha: 0.08)
                : isDarkMode
                ? AppTheme.neutral800.withValues(alpha: 0.3)
                : AppTheme.neutral100,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _isHovered
                  ? isDarkMode
                        ? AppTheme.primaryDark.withValues(alpha: 0.3)
                        : Theme.of(
                            context,
                          ).colorScheme.primary.withValues(alpha: 0.2)
                  : isDarkMode
                  ? AppTheme.neutral700.withValues(alpha: 0.3)
                  : AppTheme.neutral200.withValues(alpha: 0.5),
              width: 1,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: isDarkMode
                          ? AppTheme.primaryDark.withValues(alpha: 0.2)
                          : Theme.of(
                              context,
                            ).colorScheme.primary.withValues(alpha: 0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? AppTheme.primaryDark
                      : Theme.of(context).colorScheme.primary,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: isDarkMode
                          ? AppTheme.primaryDark.withValues(alpha: 0.3)
                          : Theme.of(
                              context,
                            ).colorScheme.primary.withValues(alpha: 0.3),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.person_rounded,
                  size: 16,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Admin',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  Text(
                    'Corporativo',
                    style: TextStyle(
                      fontSize: 10,
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 4),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 16,
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Botão de busca premium
class _PremiumSearchButton extends StatefulWidget {
  @override
  State<_PremiumSearchButton> createState() => _PremiumSearchButtonState();
}

class _PremiumSearchButtonState extends State<_PremiumSearchButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: AppAnimations.fast,
        curve: AppAnimations.easeOut,
        transform: _isHovered
            ? Matrix4.diagonal3Values(1.02, 1.02, 1.0)
            : Matrix4.identity(),
        child: Container(
          width: 200,
          height: 36,
          decoration: BoxDecoration(
            color: isDarkMode
                ? AppTheme.neutral800.withValues(alpha: 0.5)
                : AppTheme.neutral50,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: _isHovered
                  ? isDarkMode
                        ? AppTheme.primaryDark.withValues(alpha: 0.3)
                        : Theme.of(
                            context,
                          ).colorScheme.primary.withValues(alpha: 0.2)
                  : isDarkMode
                  ? AppTheme.neutral700.withValues(alpha: 0.3)
                  : AppTheme.neutral200.withValues(alpha: 0.5),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              const SizedBox(width: 12),
              Icon(
                Icons.search_rounded,
                size: 18,
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.5),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Buscar...',
                  style: TextStyle(
                    fontSize: 13,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.5),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? AppTheme.neutral700.withValues(alpha: 0.5)
                      : AppTheme.neutral200.withValues(alpha: 0.7),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '⌘K',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
