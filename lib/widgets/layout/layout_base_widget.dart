import 'package:flutter/material.dart';
import 'responsive_drawer.dart';

class LayoutBaseWidget extends StatefulWidget {
  final Widget Function(int) screenBuilder;
  final int currentIndex;
  final Function(int) onNavigation;

  const LayoutBaseWidget({
    super.key,
    required this.screenBuilder,
    required this.currentIndex,
    required this.onNavigation,
  });

  @override
  State<LayoutBaseWidget> createState() => _LayoutBaseWidgetState();
}

class _LayoutBaseWidgetState extends State<LayoutBaseWidget> {
  static const List<String> _titles = [
    'Painel Principal',
    'Análises',
    'Relatórios',
    'Projetos',
    'Calendário',
    'Configurações',
    'Perfil',
  ];

  @override
  Widget build(BuildContext context) {
    // Determine screen type based on width
    final screenWidth = MediaQuery.of(context).size.width;
    final isLargeScreen = screenWidth >= 768;

    return LayoutBuilder(
      builder: (context, constraints) {
        if (isLargeScreen) {
          // For large screens, show sidebar and content side by side
          return Scaffold(
            body: Row(
              children: [
                // Sidebar that's always visible on large screens
                SizedBox(
                  width: 280,
                  child: ResponsiveDrawer(
                    currentIndex: widget.currentIndex,
                    onTap: widget.onNavigation,
                  ),
                ),
                // Main content area
                Expanded(child: _buildMainContent()),
              ],
            ),
          );
        } else {
          // For small screens, use traditional drawer
          return Scaffold(
            appBar: AppBar(
              leading: Builder(
                builder: (context) {
                  return IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  );
                },
              ),
              title: Text(_titles[widget.currentIndex]),
              surfaceTintColor: Colors.transparent,
              shadowColor: Colors.transparent,
              actions: [
                IconButton(
                  icon: const Icon(Icons.notifications),
                  onPressed: () {},
                ),
                const SizedBox(width: 8),
                Container(
                  margin: const EdgeInsets.only(right: 16),
                  child: const CircleAvatar(
                    radius: 18,
                    backgroundImage: AssetImage('assets/eikos.png'),
                  ),
                ),
              ],
            ),
            drawer: ResponsiveDrawer(
              currentIndex: widget.currentIndex,
              onTap: (int index) {
                widget.onNavigation(index);
                if (context.mounted) {
                  Navigator.pop(context);
                }
              },
            ),
            body: widget.screenBuilder(widget.currentIndex),
          );
        }
      },
    );
  }

  Widget _buildMainContent() {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Don't show back button
        title: Text(_titles[widget.currentIndex]),
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        actions: [
          IconButton(icon: const Icon(Icons.notifications), onPressed: () {}),
          const SizedBox(width: 8),
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: const CircleAvatar(
              radius: 18,
              backgroundImage: AssetImage('assets/eikos.png'),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.surface,
              Theme.of(
                context,
              ).colorScheme.surfaceContainerLowest.withValues(alpha: 0.3),
            ],
          ),
        ),
        child: widget.screenBuilder(widget.currentIndex),
      ),
    );
  }
}
