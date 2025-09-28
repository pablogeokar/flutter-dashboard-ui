import 'package:flutter/material.dart';
import 'drawer_item.dart';
import 'responsive_scaffold.dart';

/// O widget `AppShell` é o "invólucro" principal da aplicação.
///
/// Ele é responsável por gerenciar o estado da navegação (qual tela está
/// selecionada) e passar essa informação para o `ResponsiveScaffold` construir
/// a interface.
class AppShell extends StatefulWidget {
  final List<DrawerItem> itensPrincipais;
  final List<DrawerItem> itensInferiores;

  const AppShell({
    super.key,
    required this.itensPrincipais,
    required this.itensInferiores,
  });

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
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

  // Cache for screen instances to preserve their state.
  final Map<int, Widget> _screenCache = {};

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaffold(
      itensPrincipais: widget.itensPrincipais,
      itensInferiores: widget.itensInferiores,
      screenBuilder: (int index) {
        if (index < 0 || index >= _flatNavigableItems.length) {
          return const Placeholder(); // Should not happen
        }
        // Retrieve from cache or create and add to cache
        return _screenCache.putIfAbsent(
            index, () => _flatNavigableItems[index].screen!);
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
