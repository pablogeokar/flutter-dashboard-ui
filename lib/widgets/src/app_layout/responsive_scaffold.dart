import 'package:flutter/material.dart';
import 'drawer_item.dart';
import 'responsive_drawer.dart';
import 'modern_app_bar.dart';
import 'desktop_status_bar.dart';
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

    // Breakpoints otimizados para desktop Windows
    final isLargeScreen = screenWidth >= 1024; // Desktop padrão
    final isMediumScreen =
        screenWidth >= 768 && screenWidth < 1024; // Tablet/Desktop pequeno

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: isLargeScreen
          ? _buildLargeScreenLayout()
          : isMediumScreen
          ? _buildMediumScreenLayout()
          : _buildSmallScreenLayout(),
    );
  }

  Widget _buildLargeScreenLayout() {
    final screenWidth = MediaQuery.of(context).size.width;
    final responsiveDrawerWidth = AppTheme.getResponsiveDrawerWidth(
      screenWidth,
    );

    return Row(
      children: [
        SizedBox(
          width: responsiveDrawerWidth,
          child: ClipRect(child: _buildDrawer(isPermanent: true)),
        ),
        Expanded(
          child: Column(
            children: [
              // AppBar fixa no topo
              SizedBox(
                height: AppTheme.appBarHeight,
                child: ModernAppBar(isLargeScreen: true),
              ),
              // Conteúdo principal expandido
              Expanded(child: _buildMainContent(isLargeScreen: true)),
              // Barra de status para desktop
              const DesktopStatusBar(
                statusMessage: 'Aplicação carregada com sucesso',
                isConnected: true,
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Layout para telas médias (tablets/desktop pequeno)
  Widget _buildMediumScreenLayout() {
    final screenWidth = MediaQuery.of(context).size.width;
    final responsiveDrawerWidth =
        AppTheme.getResponsiveDrawerWidth(screenWidth) *
        0.9; // Ligeiramente mais estreito

    return Row(
      children: [
        SizedBox(
          width: responsiveDrawerWidth,
          child: ClipRect(child: _buildDrawer(isPermanent: true)),
        ),
        Expanded(
          child: Column(
            children: [
              SizedBox(
                height: AppTheme.appBarHeight,
                child: ModernAppBar(isLargeScreen: true),
              ),
              Expanded(
                child: _buildMainContent(isLargeScreen: false), // Padding menor
              ),
              // Barra de status também para telas médias
              const DesktopStatusBar(
                statusMessage: 'Modo compacto ativo',
                isConnected: true,
              ),
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
      drawer: _buildDrawer(isPermanent: false),
      body: Padding(
        padding: const EdgeInsets.only(top: AppTheme.appBarHeight),
        child: _buildMainContent(isLargeScreen: false),
      ),
    );
  }

  /// Constrói o drawer com configurações específicas para cada layout
  Widget _buildDrawer({required bool isPermanent}) {
    return ResponsiveDrawer(
      currentIndex: widget.currentIndex,
      onTap: isPermanent
          ? widget.onNavigation
          : (int index) {
              widget.onNavigation(index);
              if (context.mounted) {
                Navigator.pop(context);
              }
            },
      itensPrincipais: widget.itensPrincipais,
      itensInferiores: widget.itensInferiores,
      isPermanent: isPermanent,
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
        child: widget.screenBuilder(widget.currentIndex),
      ),
    );
  }
}
