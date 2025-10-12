import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/theme/theme.dart';
import '/theme/theme_manager.dart';
import '/theme/animations.dart';

import 'command_palette.dart';

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
            : Colors.transparent,
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
                                ? const Color(
                                    0xFFF5F5F5,
                                  ) // Branco suave para legibilidade
                                : Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Domani Fiscal',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: isDarkMode
                                  ? const Color(
                                      0xFFF5F5F5,
                                    ) // Branco suave para legibilidade
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
          // Busca global inteligente
          if (isLargeScreen) ...[
            const _GlobalSearchField(),
            const SizedBox(width: AppTheme.spacingM),
          ],

          // Toggle de tema
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

          const SizedBox(width: AppTheme.spacingM),

          // Avatar simplificado
          _SimpleAvatar(),

          const SizedBox(width: AppTheme.spacingL),
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
          child: Center(
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
        ),
      ),
    );
  }
}

/// Avatar simplificado para a AppBar
class _SimpleAvatar extends StatefulWidget {
  @override
  State<_SimpleAvatar> createState() => _SimpleAvatarState();
}

class _SimpleAvatarState extends State<_SimpleAvatar> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return PopupMenuButton<String>(
      offset: const Offset(0, 50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.borderRadiusM),
      ),
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.all(AppTheme.spacingS),
          decoration: BoxDecoration(
            color: _isHovered
                ? isDarkMode
                      ? AppTheme.hoverDark.withValues(alpha: 0.3)
                      : AppTheme.hoverLight
                : Colors.transparent,
            borderRadius: BorderRadius.circular(AppTheme.borderRadiusM),
            border: _isHovered
                ? Border.all(
                    color: Theme.of(
                      context,
                    ).colorScheme.primary.withValues(alpha: 0.2),
                    width: 1,
                  )
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(
                        context,
                      ).colorScheme.primary.withValues(alpha: 0.2),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.person_rounded,
                  size: 18,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: AppTheme.spacingS),
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
      itemBuilder: (context) => [
        PopupMenuItem<String>(
          value: 'profile',
          child: Row(
            children: [
              Icon(
                Icons.person_outline_rounded,
                size: 18,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              SizedBox(width: AppTheme.spacingS),
              Text('Perfil'),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'settings',
          child: Row(
            children: [
              Icon(
                Icons.settings_outlined,
                size: 18,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              SizedBox(width: AppTheme.spacingS),
              Text('Configurações'),
            ],
          ),
        ),
        const PopupMenuDivider(),
        PopupMenuItem<String>(
          value: 'logout',
          child: Row(
            children: [
              Icon(Icons.logout_rounded, size: 18, color: AppTheme.errorLight),
              SizedBox(width: AppTheme.spacingS),
              Text('Sair', style: TextStyle(color: AppTheme.errorLight)),
            ],
          ),
        ),
      ],
      onSelected: (value) {
        switch (value) {
          case 'profile':
            // Implementar navegação para perfil
            break;
          case 'settings':
            // Implementar navegação para configurações
            break;
          case 'logout':
            // Implementar logout
            _showLogoutDialog();
            break;
        }
      },
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirmar Saída'),
        content: Text('Tem certeza que deseja sair do sistema?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              // Implementar lógica de logout
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.errorLight,
              foregroundColor: Colors.white,
            ),
            child: Text('Sair'),
          ),
        ],
      ),
    );
  }
}

void _showCommandPalette(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => const CommandPalette(),
  );
}

/// Campo de busca global que abre a paleta de comandos.
class _GlobalSearchField extends StatelessWidget {
  const _GlobalSearchField({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _showCommandPalette(context),
        child: Container(
          width: 240,
          height: 36,
          decoration: BoxDecoration(
            color: isDarkMode
                ? AppTheme.formFieldBackgroundDark
                : AppTheme.formFieldBackgroundLight,
            borderRadius: BorderRadius.circular(AppTheme.borderRadiusM),
            border: Border.all(
              color: isDarkMode
                  ? AppTheme.formFieldBorderDark
                  : AppTheme.formFieldBorderLight,
              width: 1,
            ),
          ),
          child: Row(
            children: [
              const SizedBox(width: 12),
              Icon(
                Icons.search_rounded,
                size: 18,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
              ),
              const SizedBox(width: 8),
              Text(
                'Buscar...',
                style: TextStyle(
                  fontSize: 13,
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                ),
              ),
              const Spacer(),
              Container(
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.symmetric(
                  horizontal: 6,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? AppTheme.neutral700.withOpacity(0.5)
                      : AppTheme.neutral200.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'Ctrl+K',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
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
