import 'package:dashboard_ui/screens/form_test_screen.dart';
import 'package:flutter/material.dart';
import '../screens/em_construcao_screen.dart';
import '../screens/teste_screen.dart';
import '../widgets/app_layout.dart';

// Classe para organizar a configuração dos itens da barra de navegação
class SidebarConfig {
  // Lista de itens principais do menu
  static const List<DrawerItem> itensPrincipais = [
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
          screen: FormTestScreen(),
        ),
        DrawerItem(
          title: 'Fornecedores',
          icon: Icons.business,
          screen: EmConstrucaoPlaceholder(),
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

  // Lista de itens inferiores (rodapé) do menu
  static const List<DrawerItem> itensInferiores = [
    DrawerItem(
      title: 'Configurações',
      icon: Icons.settings,
      screen: EmConstrucaoPlaceholder(),
    ),
    DrawerItem(
      title: 'Perfil',
      icon: Icons.person,
      screen: EmConstrucaoPlaceholder(),
    ),
  ];
}
