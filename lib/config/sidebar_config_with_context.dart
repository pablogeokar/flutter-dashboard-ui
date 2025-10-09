import 'package:flutter/material.dart';
import '../screens/em_construcao_screen.dart';
import '../screens/teste_screen.dart';
import '../widgets/app_layout.dart';
import '../widgets/form_layout.dart';

/// Classe para organizar a configuração dos itens da barra de navegação
/// Esta versão usa callbacks para dialogs, evitando navegação desnecessária
class SidebarConfigWithContext {
  /// Cria a lista de itens principais do menu
  static List<DrawerItem> itensPrincipais(BuildContext context) => [
    DrawerItem(
      title: 'Painel Principal',
      icon: Icons.dashboard,
      screen: EmConstrucaoPlaceholder(),
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
          screen: EmConstrucaoPlaceholder(),
        ),
      ],
    ),
    DrawerItem(
      title: 'Análises',
      icon: Icons.analytics,
      screen: EmConstrucaoPlaceholder(),
    ),
    DrawerItem(
      title: 'Relatórios',
      icon: Icons.insert_drive_file,
      screen: EmConstrucaoPlaceholder(),
    ),
    DrawerItem(title: 'Projetos', icon: Icons.folder, screen: TesteScreen()),
    DrawerItem(
      title: 'Calendário',
      icon: Icons.calendar_today,
      screen: EmConstrucaoPlaceholder(),
    ),
  ];

  /// Cria a lista de itens inferiores (rodapé) do menu
  static List<DrawerItem> itensInferiores(BuildContext context) => [
    DrawerItem(
      title: 'Configurações',
      icon: Icons.settings,
      onDialogTap: DialogCallbacks.configuracoes(context),
    ),
    DrawerItem(
      title: 'Perfil',
      icon: Icons.person,
      screen: EmConstrucaoPlaceholder(),
    ),
  ];
}
