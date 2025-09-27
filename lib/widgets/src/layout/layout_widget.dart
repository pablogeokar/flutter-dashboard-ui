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

  // Flattens the drawer items into a single list of navigable items.
  List<DrawerItem> get _flatNavigableItems {
    final List<DrawerItem> flatList = [];

    void processItems(List<DrawerItem> items) {
      for (final item in items) {
        if (item.subItems?.isNotEmpty ?? false) {
          processItems(item.subItems!);
        } else if (item.screen != null) {
          flatList.add(item);
        }
      }
    }

    processItems([...widget.itensPrincipais, ...widget.itensInferiores]);
    return flatList;
  }

  // Get the list of screens from the flattened list of items.
  List<Widget> get _telas =>
      _flatNavigableItems.map((item) => item.screen!).toList();

  @override
  Widget build(BuildContext context) {
    return LayoutBaseWidget(
      itensPrincipais: widget.itensPrincipais,
      itensInferiores: widget.itensInferiores,
      screenBuilder: (int index) {
        if (index < 0 || index >= _telas.length) {
          return const Placeholder(); // Should not happen
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
