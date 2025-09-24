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
        SizedBox(
          width: 280,
          child: ResponsiveDrawer(
            currentIndex: widget.currentIndex,
            onTap: widget.onNavigation,
            itensPrincipais: widget.itensPrincipais,
            itensInferiores: widget.itensInferiores,
          ),
        ),
        Expanded(child: _buildMainContent(isLargeScreen: true)),
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
      body: _buildMainContent(isLargeScreen: false),
    );
  }

  PreferredSizeWidget _buildModernAppBar({required bool isLargeScreen}) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(80.0),
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Card(
          elevation: 2.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          clipBehavior: Clip.antiAlias,
          child: AppBar(
            backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
            automaticallyImplyLeading: !isLargeScreen,
            leading: isLargeScreen
                ? null
                : Builder(
                    builder: (context) {
                      return IconButton(
                        icon: const Icon(Icons.menu),
                        onPressed: () => Scaffold.of(context).openDrawer(),
                      );
                    },
                  ),
            title: Text(
              _titles[widget.currentIndex],
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications_none_outlined),
                onPressed: () {},
              ),
              const SizedBox(width: 8),
              Container(
                margin: const EdgeInsets.only(right: 16),
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: Icon(
                    Icons.person_outline,
                    size: 22,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMainContent({required bool isLargeScreen}) {
    return Scaffold(
      appBar: isLargeScreen ? _buildModernAppBar(isLargeScreen: true) : null,
      backgroundColor: Colors.transparent,
      body: Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(15),
        ),
        child: widget.screenBuilder(widget.currentIndex),
      ),
    );
  }
}
