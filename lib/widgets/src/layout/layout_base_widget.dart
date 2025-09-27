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
    return Scaffold(
      appBar: _buildModernAppBar(isLargeScreen: true),
      body: Row(
        children: [
          ResponsiveDrawer(
            currentIndex: widget.currentIndex,
            onTap: widget.onNavigation,
            itensPrincipais: widget.itensPrincipais,
            itensInferiores: widget.itensInferiores,
          ),
          Expanded(child: _buildMainContent(isLargeScreen: true)),
        ],
      ),
    );
  }

  Widget _buildSmallScreenLayout() {
    return Scaffold(
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
      body: Container(
        padding: const EdgeInsets.only(top: AppTheme.spacingS),
        child: _buildMainContent(isLargeScreen: false),
      ),
    );
  }

  PreferredSizeWidget _buildModernAppBar({required bool isLargeScreen}) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(80.0),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: EdgeInsets.fromLTRB(
          AppTheme.spacingM,
          AppTheme.spacingM,
          AppTheme.spacingM,
          0,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerLow.withValues(
            alpha: AppTheme.appBarOpacity,
          ),
          borderRadius: BorderRadius.circular(AppTheme.borderRadiusM),
          boxShadow: [
            BoxShadow(
              color: Theme.of(
                context,
              ).colorScheme.primary.withValues(alpha: 0.1),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
            BoxShadow(
              color: Theme.of(
                context,
              ).colorScheme.secondary.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppTheme.borderRadiusM),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: AppTheme.appBarBlur,
              sigmaY: AppTheme.appBarBlur,
            ),
            child: SafeArea(
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0, // Ensure no default shadow
                automaticallyImplyLeading: !isLargeScreen,
                leading: isLargeScreen
                    ? null
                    : Builder(
                        builder: (context) {
                          return Container(
                            margin: const EdgeInsets.all(AppTheme.spacingS),
                            decoration: BoxDecoration(
                              color: Theme.of(
                                context,
                              ).colorScheme.surfaceContainerHighest,
                              borderRadius: BorderRadius.circular(
                                AppTheme.borderRadiusM,
                              ),
                            ),
                            child: IconButton(
                              icon: const Icon(Icons.menu),
                              onPressed: () =>
                                  Scaffold.of(context).openDrawer(),
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all<Color>(
                                  Colors.transparent,
                                ),
                                foregroundColor: WidgetStateProperty.all<Color>(
                                  Theme.of(context).colorScheme.onSurface,
                                ),
                                iconSize: WidgetStateProperty.all<double>(24.0),
                              ),
                            ),
                          );
                        },
                      ),
                // The title is now the logo
                title: Container(
                  padding: const EdgeInsets.all(AppTheme.spacingS),
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).colorScheme.primary,
                      BlendMode.srcIn,
                    ),
                    child: Image.asset('assets/eikos.png', height: 55),
                  ),
                ),
                actions: [
                  // Search bar and spacer are removed
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: AppTheme.spacingS,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).colorScheme.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(99),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.notifications_outlined),
                      onPressed: () {},
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all<Color>(
                          Colors.transparent,
                        ),
                        foregroundColor: WidgetStateProperty.all<Color>(
                          Theme.of(context).colorScheme.onSurface,
                        ),
                        iconSize: WidgetStateProperty.all<double>(24.0),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: AppTheme.spacingS,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(
                        99, // Valor especial para formato circular, não substituído por constante
                      ), // Valor especial para formato circular, não substituído por constante
                    ),
                    child: IconButton(
                      icon: Icon(
                        Provider.of<ThemeManager>(
                                  context,
                                  listen: false,
                                ).currentTheme ==
                                ThemeModeType.dark
                            ? Icons.light_mode
                            : Icons.dark_mode,
                      ),
                      onPressed: () {
                        Provider.of<ThemeManager>(
                          context,
                          listen: false,
                        ).toggleTheme();
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all<Color>(
                          Colors.transparent,
                        ),
                        foregroundColor: WidgetStateProperty.all<Color>(
                          Theme.of(context).colorScheme.onSurface,
                        ),
                        iconSize: WidgetStateProperty.all<double>(24.0),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: AppTheme.spacingM),
                    child: CircleAvatar(
                      radius: AppTheme.avatarSizeSmall,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      child: const Icon(
                        Icons.person_outline,
                        size: 26,
                        color: Colors
                            .white, // Explicitly white for better contrast on new primary
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
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
