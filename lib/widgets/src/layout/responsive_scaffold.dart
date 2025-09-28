import 'package:flutter/material.dart';
import 'drawer_item.dart';
import 'responsive_drawer.dart';
import 'modern_app_bar.dart';
import '/theme/theme.dart';

/// O `ResponsiveScaffold` é um widget presentacional (ou "burro").
///
/// Sua única responsabilidade é construir a estrutura visual da página (o `Scaffold`)
/// de forma responsiva, decidindo entre um layout para telas grandes ou pequenas.
/// Ele não gerencia nenhum estado, apenas recebe os dados e os exibe.
class ResponsiveScaffold extends StatefulWidget {
  final Widget Function(int) screenBuilder;
  final int currentIndex;
  final Function(int) onNavigation;
  final List<DrawerItem> itensPrincipais;
  final List<DrawerItem> itensInferiores;

  const ResponsiveScaffold({
    super.key,
    required this.screenBuilder,
    required this.currentIndex,
    required this.onNavigation,
    required this.itensPrincipais,
    required this.itensInferiores,
  });

  @override
  State<ResponsiveScaffold> createState() => _ResponsiveScaffoldState();
}

class _ResponsiveScaffoldState extends State<ResponsiveScaffold> {
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
              const ModernAppBar(isLargeScreen: true),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSmallScreenLayout() {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const ModernAppBar(isLargeScreen: false),
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
