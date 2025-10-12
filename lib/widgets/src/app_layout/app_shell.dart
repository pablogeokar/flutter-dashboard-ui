import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'drawer_item.dart';
import 'responsive_scaffold.dart';
import 'breadcrumb.dart';
import '../../../utils/keyboard_shortcuts.dart';
import '../../../theme/theme_manager.dart';
import '../../../config/sidebar_config.dart';
import 'command_palette.dart';

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

  /// Gera os itens do breadcrumb baseado no item selecionado
  List<BreadcrumbItem> _getBreadcrumbItems() {
    final flatItems = _getFlatNavigableItems();

    if (_selectedIndex < 0 || _selectedIndex >= flatItems.length) {
      return [];
    }

    final currentItem = flatItems[_selectedIndex];
    final title = currentItem.title;

    // Mapear títulos para breadcrumbs específicos
    switch (title) {
      case 'Dashboard':
        return [
          BreadcrumbItem(
            label: 'Dashboard',
            icon: Icons.dashboard_rounded,
            isActive: true,
          ),
        ];

      case 'Clientes':
        return [
          BreadcrumbItem(
            label: 'Cadastros',
            icon: Icons.edit_document,
            onTap: () {
              // Navegar para seção de cadastros se existir
            },
          ),
          BreadcrumbItem(
            label: 'Clientes',
            icon: Icons.people_rounded,
            isActive: true,
          ),
        ];

      case 'Fornecedores':
        return [
          BreadcrumbItem(
            label: 'Cadastros',
            icon: Icons.edit_document,
            onTap: () {
              // Navegar para seção de cadastros se existir
            },
          ),
          BreadcrumbItem(
            label: 'Fornecedores',
            icon: Icons.business_rounded,
            isActive: true,
          ),
        ];

      case 'Produtos/Serviços':
        return [
          BreadcrumbItem(
            label: 'Cadastros',
            icon: Icons.edit_document,
            onTap: () {},
          ),
          BreadcrumbItem(
            label: 'Produtos/Serviços',
            icon: Icons.inventory_2_rounded,
            isActive: true,
          ),
        ];

      case 'Plano de Contas':
        return [
          BreadcrumbItem(
            label: 'Cadastros',
            icon: Icons.edit_document,
            onTap: () {},
          ),
          BreadcrumbItem(
            label: 'Plano de Contas',
            icon: Icons.account_tree_rounded,
            isActive: true,
          ),
        ];

      case 'Apuração ICMS':
        return [
          BreadcrumbItem(
            label: 'Fiscal',
            icon: Icons.gavel_rounded,
            onTap: () {},
          ),
          BreadcrumbItem(
            label: 'Apuração ICMS',
            icon: Icons.calculate_rounded,
            isActive: true,
          ),
        ];

      case 'SPED Fiscal':
        return [
          BreadcrumbItem(
            label: 'Fiscal',
            icon: Icons.gavel_rounded,
            onTap: () {},
          ),
          BreadcrumbItem(
            label: 'SPED Fiscal',
            icon: Icons.description_rounded,
            isActive: true,
          ),
        ];

      case 'Declarações':
        return [
          BreadcrumbItem(
            label: 'Fiscal',
            icon: Icons.gavel_rounded,
            onTap: () {},
          ),
          BreadcrumbItem(
            label: 'Declarações',
            icon: Icons.assignment_rounded,
            isActive: true,
          ),
        ];

      case 'Calendário Fiscal':
        return [
          BreadcrumbItem(
            label: 'Fiscal',
            icon: Icons.gavel_rounded,
            onTap: () {},
          ),
          BreadcrumbItem(
            label: 'Calendário Fiscal',
            icon: Icons.event_rounded,
            isActive: true,
          ),
        ];

      case 'Balancetes':
        return [
          BreadcrumbItem(
            label: 'Relatórios',
            icon: Icons.analytics_rounded,
            onTap: () {},
          ),
          BreadcrumbItem(
            label: 'Balancetes',
            icon: Icons.balance_rounded,
            isActive: true,
          ),
        ];

      case 'DRE':
        return [
          BreadcrumbItem(
            label: 'Relatórios',
            icon: Icons.analytics_rounded,
            onTap: () {},
          ),
          BreadcrumbItem(
            label: 'DRE',
            icon: Icons.trending_up_rounded,
            isActive: true,
          ),
        ];

      case 'Fluxo de Caixa':
        return [
          BreadcrumbItem(
            label: 'Relatórios',
            icon: Icons.analytics_rounded,
            onTap: () {},
          ),
          BreadcrumbItem(
            label: 'Fluxo de Caixa',
            icon: Icons.account_balance_wallet_rounded,
            isActive: true,
          ),
        ];

      default:
        return [BreadcrumbItem(label: title, isActive: true)];
    }
  }

  void _showCommandPalette(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const CommandPalette(),
    );
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
          SearchIntent: SearchAction(
            onSearch: () => _showCommandPalette(context),
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
            breadcrumbItems: _getBreadcrumbItems(),
          ),
        ),
      ),
    );
  }
}

/// Wrapper de segurança para capturar erros de renderização das telas
