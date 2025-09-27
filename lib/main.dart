import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme/theme.dart';
import 'theme/theme_manager.dart';
import 'widgets/app_layout.dart';
import 'screens/em_construcao_screen.dart';
import 'screens/teste_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

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
          screen: EmConstrucaoPlaceholder(),
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

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeManager>(
      create: (context) => ThemeManager(),
      child: MaterialApp(
        title: 'Dashboard UI',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppTheme.primary, // Your primary color from theme file
            brightness: Brightness.light, // Light theme
          ),
          // Additional Material 3 styling
          navigationRailTheme: NavigationRailThemeData(
            backgroundColor: Theme.of(context).colorScheme.surface,
            indicatorColor: Theme.of(context).colorScheme.primaryContainer,
          ),
          drawerTheme: DrawerThemeData(
            backgroundColor:
                AppTheme.surfaceDark, // Força a cor de fundo do drawer
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppTheme.primary, // Your primary color from theme file
            brightness: Brightness.dark, // Dark theme
          ),
          // Additional Material 3 styling for dark theme
          navigationRailTheme: NavigationRailThemeData(
            backgroundColor: Theme.of(context).colorScheme.surface,
            indicatorColor: Theme.of(context).colorScheme.primaryContainer,
          ),
          drawerTheme: DrawerThemeData(
            backgroundColor:
                AppTheme.surfaceDark, // Força a cor de fundo do drawer
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
        themeMode: ThemeMode.system, // Deixar como sistema por padrão
        home: const LayoutWidget(
          itensPrincipais: itensPrincipais,
          itensInferiores: itensInferiores,
        ),
      ),
    );
  }
}
