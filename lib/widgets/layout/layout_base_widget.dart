import 'package:flutter/material.dart';
import 'drawer_item.dart';
import 'responsive_drawer.dart';

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
  List<String> get _titles => [
    ...widget.itensPrincipais.map((item) => item.title),
    ...widget.itensInferiores.map((item) => item.title),
  ];

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
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: 280,
          margin: const EdgeInsets.only(left: 8, top: 8, bottom: 8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 16,
                offset: const Offset(4, 0),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: ResponsiveDrawer(
              currentIndex: widget.currentIndex,
              onTap: widget.onNavigation,
              itensPrincipais: widget.itensPrincipais,
              itensInferiores: widget.itensInferiores,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 8, top: 8, bottom: 8),
            child: _buildMainContent(isLargeScreen: true),
          ),
        ),
      ],
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
        padding: const EdgeInsets.only(top: 8),
        child: _buildMainContent(isLargeScreen: false),
      ),
    );
  }

  PreferredSizeWidget _buildModernAppBar({required bool isLargeScreen}) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(80.0),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: SafeArea(
            child: AppBar(
              backgroundColor: Colors.transparent,
              automaticallyImplyLeading: !isLargeScreen,
              leading: isLargeScreen
                  ? null
                  : Builder(
                      builder: (context) {
                        return Container(
                          margin: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Theme.of(
                              context,
                            ).colorScheme.surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.menu),
                            onPressed: () => Scaffold.of(context).openDrawer(),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.transparent,
                              ),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                Theme.of(context).colorScheme.onSurface,
                              ),
                              iconSize: MaterialStateProperty.all<double>(24.0),
                            ),
                          ),
                        );
                      },
                    ),
              title: Text(
                _titles[widget.currentIndex],
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8.0),
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(99),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.notifications_outlined),
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.transparent,
                      ),
                      foregroundColor: MaterialStateProperty.all<Color>(
                        Theme.of(context).colorScheme.onSurface,
                      ),
                      iconSize: MaterialStateProperty.all<double>(24.0),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 16),
                  child: CircleAvatar(
                    radius: 22,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    child: Icon(
                      Icons.person_outline,
                      size: 26,
                      color: Theme.of(context).colorScheme.onPrimary,
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

  Widget _buildMainContent({required bool isLargeScreen}) {
    return Scaffold(
      appBar: isLargeScreen ? _buildModernAppBar(isLargeScreen: true) : null,
      backgroundColor: Theme.of(context)
          .colorScheme
          .surface, // Garantindo a cor de fundo consistente com o tema dark
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: EdgeInsets.all(isLargeScreen ? 16.0 : 8.0),
        padding: EdgeInsets.all(isLargeScreen ? 16.0 : 8.0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
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
      ),
    );
  }
}
