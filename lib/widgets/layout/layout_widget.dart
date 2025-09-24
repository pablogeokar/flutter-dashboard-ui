import 'package:flutter/material.dart';
import 'drawer_item.dart';
import 'layout_base_widget.dart';

class LayoutWidget extends StatefulWidget {
  final List<DrawerItem> itensPrincipais;
  final List<DrawerItem> itensInferiores;

  const LayoutWidget({
    super.key,
    required this.itensPrincipais,
    required this.itensInferiores,
  });

  @override
  State<LayoutWidget> createState() => _LayoutWidgetState();
}

class _LayoutWidgetState extends State<LayoutWidget> {
  int _selectedIndex = 0;

  // Obter a lista de telas baseada nos DrawerItems
  List<Widget> get _telas => [
    ...widget.itensPrincipais.map((item) => item.screen),
    ...widget.itensInferiores.map((item) => item.screen),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBaseWidget(
      itensPrincipais: widget.itensPrincipais,
      itensInferiores: widget.itensInferiores,
      screenBuilder: (int index) {
        // Garantindo que o índice esteja dentro dos limites
        if (index < 0 || index >= _telas.length) {
          return const Placeholder();
        }
        return _telas[index];
      },
      currentIndex: _selectedIndex,
      onNavigation: (int index) {
        setState(() {
          _selectedIndex = index;
        });
      },
    );
  }
}
