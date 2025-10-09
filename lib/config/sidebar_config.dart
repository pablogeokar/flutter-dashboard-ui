import 'package:dashboard_ui/screens/exemplo_form_dialog_screen.dart';
import 'package:flutter/material.dart';
import '../screens/em_construcao_screen.dart';
import '../screens/teste_screen.dart';
import '../widgets/app_layout.dart';
import '../widgets/form_layout.dart';

// Classe para organizar a configuração dos itens da barra de navegação
class SidebarConfig {
  // Lista de itens principais do menu
  static List<DrawerItem> get itensPrincipais => [
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
          screen: ExemploFormDialogScreen(), // Tela com exemplos de FormDialog
        ),
        DrawerItem(
          title: 'Fornecedores',
          icon: Icons.business,
          screen: DialogTriggers.cadastroFornecedor(
            onConfirmar: () {
              // Lógica de confirmação do fornecedor
              print('Fornecedor cadastrado!');
            },
          ),
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
  static List<DrawerItem> get itensInferiores => [
    DrawerItem(
      title: 'Configurações',
      icon: Icons.settings,
      screen: DialogTriggers.configuracoes(
        onConfirmar: () {
          // Lógica de confirmação das configurações
          print('Configurações salvas!');
        },
      ),
    ),
    DrawerItem(
      title: 'Perfil',
      icon: Icons.person,
      screen: EmConstrucaoPlaceholder(),
    ),
  ];
}
