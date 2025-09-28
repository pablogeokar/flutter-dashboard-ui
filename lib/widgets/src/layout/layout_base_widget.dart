import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:ui';
import 'drawer_item.dart';
import 'responsive_drawer.dart';
import '/theme/theme.dart';
import '/theme/theme_manager.dart';

class LayoutBaseWidget extends StatefulWidget {
  final Widget Function(int) screenBuilder;
  final int currentIndex;
  final Function(int) onNavigation;
  final List<DrawerItem> itensPrincipais;
  final List<DrawerItem> itensInferiores;

  const LayoutBaseWidget({
    super.key,
    required this.screenBuilder,
    required this.currentIndex,
    required this.onNavigation,
    required this.itensPrincipais,
    required this.itensInferiores,
  });

  @override
  State<LayoutBaseWidget> createState() => _LayoutBaseWidgetState();
}

class _LayoutBaseWidgetState extends State<LayoutBaseWidget> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isLargeScreen = screenWidth >= 768;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: isLargeScreen
          ? _buildLargeScreenLayout()
          : _buildSmallScreenLayout(),
    );
  }

  Widget _buildLargeScreenLayout() {
    return Row(
      children: [
        ResponsiveDrawer(
          currentIndex: widget.currentIndex,
          onTap: widget.onNavigation,
          itensPrincipais: widget.itensPrincipais,
          itensInferiores: widget.itensInferiores,
        ),
        Expanded(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: AppTheme.appBarHeight),
                child: _buildMainContent(isLargeScreen: true),
              ),
              _buildModernAppBar(isLargeScreen: true),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSmallScreenLayout() {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _buildModernAppBar(isLargeScreen: false),
      drawer: ResponsiveDrawer(
        currentIndex: widget.currentIndex,
        onTap: (int index) {
          widget.onNavigation(index);
          if (context.mounted) {
            Navigator.pop(context);
          }
        },
        itensPrincipais: widget.itensPrincipais,
        itensInferiores: widget.itensInferiores,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: AppTheme.appBarHeight),
        child: _buildMainContent(isLargeScreen: false),
      ),
    );
  }

  PreferredSizeWidget _buildModernAppBar({required bool isLargeScreen}) {
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
                  iconSize: 24.0, // Reverted to a more standard size
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
          child: Icon(
            Icons.person_outline,
            size: 22.0,
          ),
        ),
        const SizedBox(width: AppTheme.spacingM),
      ],
    );
  }

  Widget _buildMainContent({required bool isLargeScreen}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: EdgeInsets.all(
        isLargeScreen ? AppTheme.spacingM : AppTheme.spacingS,
      ),
      padding: EdgeInsets.all(
        isLargeScreen ? AppTheme.spacingM : AppTheme.spacingS,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppTheme.borderRadiusXL),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppTheme.borderRadiusXL),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) {
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0.05, 0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),
            );
          },
          child: KeyedSubtree(
            key: ValueKey<int>(widget.currentIndex),
            child: widget.screenBuilder(widget.currentIndex),
          ),
        ),
      ),
    );
  }
}
