import 'package:flutter/material.dart';
import '../screens/em_construcao_screen.dart';
import '../screens/teste_screen.dart';

import '../widgets/app_layout.dart';
import '../widgets/dialog.dart';

/// Configuração dos itens da barra de navegação lateral
class SidebarConfig {
  /// Cria a lista de itens principais do menu
  static List<DrawerItem> getMainItems(BuildContext context) => [
    DrawerItem(
      title: 'Painel Principal',
      icon: Icons.dashboard,
      screen: const EmConstrucaoPlaceholder(),
    ),
    DrawerItem(
      title: 'Cadastros',
      icon: Icons.edit_document,
      subItems: [
        DrawerItem(
          title: 'Clientes',
          icon: Icons.people,
          onDialogTap: DialogCallbacks.cadastroCliente(context),
        ),
        DrawerItem(
          title: 'Fornecedores',
          icon: Icons.business,
          onDialogTap: DialogCallbacks.cadastroFornecedor(context),
        ),
        DrawerItem(
          title: 'Produtos',
          icon: Icons.inventory,
          screen: const EmConstrucaoPlaceholder(),
        ),
      ],
    ),
    DrawerItem(
      title: 'Análises',
      icon: Icons.analytics,
      screen: const EmConstrucaoPlaceholder(),
    ),
    DrawerItem(
      title: 'Relatórios',
      icon: Icons.insert_drive_file,
      screen: const EmConstrucaoPlaceholder(),
    ),
    DrawerItem(
      title: 'Projetos',
      icon: Icons.folder,
      screen: const TesteScreen(),
    ),
    DrawerItem(
      title: 'Calendário',
      icon: Icons.calendar_today,
      screen: const EmConstrucaoPlaceholder(),
    ),
  ];

  /// Cria a lista de itens inferiores (rodapé) do menu
  static List<DrawerItem> getFooterItems(BuildContext context) => [
    DrawerItem(
      title: 'Configurações',
      icon: Icons.settings,
      onDialogTap: DialogCallbacks.configuracoes(context),
    ),
  ];
}
