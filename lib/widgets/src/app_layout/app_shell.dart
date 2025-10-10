import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'drawer_item.dart';
import 'responsive_scaffold.dart';
import '../../../utils/keyboard_shortcuts.dart';
import '../../../theme/theme_manager.dart';
import '../../../config/sidebar_config.dart';

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

  // Lista simples sem cache
  List<DrawerItem>? _flatNavigableItems;

  @override
  void initState() {
    super.initState();
    // Removido a inicialização aqui para evitar problemas com context
  }

  /// Constrói a lista plana de itens navegáveis (lazy initialization)
  List<DrawerItem> _getFlatNavigableItems() {
    if (_flatNavigableItems == null) {
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

      final itensPrincipais = SidebarConfig.getMainItems(context);
      final itensInferiores = SidebarConfig.getFooterItems(context);
      processItems([...itensPrincipais, ...itensInferiores]);
      _flatNavigableItems = flatList;
    }
    return _flatNavigableItems!;
  }

  /// Constrói a tela para o índice especificado
  Widget _buildScreen(int index) {
    final flatItems = _getFlatNavigableItems();

    if (index < 0 || index >= flatItems.length) {
      return const Center(child: Text('Tela não encontrada'));
    }

    return flatItems[index].screen ??
        const Center(child: Text('Tela não configurada'));
  }

  /// Navega para o índice especificado
  void _navigateToIndex(int index) {
    final flatItems = _getFlatNavigableItems();

    if (index >= 0 && index < flatItems.length && index != _selectedIndex) {
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
            itensPrincipais: SidebarConfig.getMainItems(context),
            itensInferiores: SidebarConfig.getFooterItems(context),
            screenBuilder: _buildScreen,
            currentIndex: _selectedIndex,
            onNavigation: _navigateToIndex,
          ),
        ),
      ),
    );
  }
}

/// Wrapper de segurança para capturar erros de renderização das telas
