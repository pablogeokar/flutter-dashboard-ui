import 'package:dashboard_ui/screens/em_construcao_screen.dart';
import 'package:dashboard_ui/screens/teste_screen.dart';
import 'package:dashboard_ui/widgets/layout/drawer_item.dart';
import 'package:flutter/material.dart';
import 'theme.dart';
import 'widgets/layout/layout_widget.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  static const List<DrawerItem> itensPrincipais = [
    DrawerItem(
      title: 'Painel Principal',
      icon: Icons.dashboard,
      index: 0,
      screen: EmConstrucaoPlaceholder(),
    ),
    DrawerItem(
      title: 'Análises',
      icon: Icons.analytics,
      index: 1,
      screen: EmConstrucaoPlaceholder(),
    ),
    DrawerItem(
      title: 'Relatórios',
      icon: Icons.insert_drive_file,
      index: 2,
      screen: EmConstrucaoPlaceholder(),
    ),
    DrawerItem(
      title: 'Projetos',
      icon: Icons.folder,
      index: 3,
      screen: TesteScreen(),
    ),
    DrawerItem(
      title: 'Calendário',
      icon: Icons.calendar_today,
      index: 4,
      screen: EmConstrucaoPlaceholder(),
    ),
  ];

  static const List<DrawerItem> itensInferiores = [
    DrawerItem(
      title: 'Configurações',
      icon: Icons.settings,
      index: 5,
      screen: EmConstrucaoPlaceholder(),
    ),
    DrawerItem(
      title: 'Perfil',
      icon: Icons.person,
      index: 6,
      screen: EmConstrucaoPlaceholder(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dashboard UI',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppTheme.primary, // Your primary color from theme file
          brightness: Brightness.dark, // Material 3 dark theme
        ),
        // Additional Material 3 styling
        navigationRailTheme: NavigationRailThemeData(
          backgroundColor: Theme.of(context).colorScheme.surface,
          indicatorColor: Theme.of(context).colorScheme.primaryContainer,
        ),
        drawerTheme: DrawerThemeData(
          backgroundColor: Theme.of(context).colorScheme.surface,
        ),
      ),
      home: const LayoutWidget(
        itensPrincipais: itensPrincipais,
        itensInferiores: itensInferiores,
      ),
    );
  }
}
