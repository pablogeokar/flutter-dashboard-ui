import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'drawer_item.dart';
import 'responsive_scaffold.dart';
import '../../../utils/keyboard_shortcuts.dart';
import '../../../theme/theme_manager.dart';
import '../../../config/sidebar_config_with_context.dart';

/// O widget `AppShell` é o "invólucro" principal da aplicação.
///
/// Ele é responsável por gerenciar o estado da navegação (qual tela está
/// selecionada) e passar essa informação para o `ResponsiveScaffold` construir
/// a interface.
class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _selectedIndex = 0;

  // Cache otimizado para telas - inicializado uma vez
  late final List<DrawerItem> _flatNavigableItems;
  final Map<int, Widget> _screenCache = {};

  @override
  void initState() {
    super.initState();
    _flatNavigableItems = _buildFlatNavigableItems();
  }

  /// Constrói a lista plana de itens navegáveis uma única vez
  List<DrawerItem> _buildFlatNavigableItems() {
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

    final itensPrincipais = SidebarConfigWithContext.itensPrincipais(context);
    final itensInferiores = SidebarConfigWithContext.itensInferiores(context);
    processItems([...itensPrincipais, ...itensInferiores]);
    return flatList;
  }

  /// Constrói a tela para o índice especificado com cache otimizado
  Widget _buildScreen(int index) {
    if (index < 0 || index >= _flatNavigableItems.length) {
      return const Center(child: Text('Tela não encontrada'));
    }

    // Cache otimizado - cria apenas quando necessário
    return _screenCache.putIfAbsent(
      index,
      () => _flatNavigableItems[index].screen!,
    );
  }

  /// Navega para o índice especificado com animação suave
  void _navigateToIndex(int index) {
    if (index != _selectedIndex) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context, listen: false);

    return Shortcuts(
      shortcuts: KeyboardShortcuts.getShortcuts(),
      child: Actions(
        actions: {
          ToggleThemeIntent: ToggleThemeAction(
            onToggle: () => themeManager.toggleTheme(),
          ),
        },
        child: Focus(
          autofocus: true,
          child: ResponsiveScaffold(
            itensPrincipais: SidebarConfigWithContext.itensPrincipais(context),
            itensInferiores: SidebarConfigWithContext.itensInferiores(context),
            screenBuilder: _buildScreen,
            currentIndex: _selectedIndex,
            onNavigation: _navigateToIndex,
          ),
        ),
      ),
    );
  }
}
