import 'package:flutter/material.dart';
import 'theme.dart';
import 'widgets/layout_base_widget.dart';
import 'screens/em_construcao_screen.dart';
import 'screens/teste_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

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
      home: const DashboardPage(),
    );
  }
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return LayoutBaseWidget(
      currentIndex: _selectedIndex,
      onNavigation: (int index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      screenBuilder: (int index) {
        switch (index) {
          case 0: // Painel Principal
            return const EmConstrucaoPlaceholder();
          case 1: // Análises
            return const EmConstrucaoPlaceholder();
          case 2: // Relatórios
            return const EmConstrucaoPlaceholder();
          case 3: // Projetos
            return const TesteScreen(); // Esta é a tela que você criou
          case 4: // Calendário
            return const EmConstrucaoPlaceholder();
          case 5: // Configurações
            return const EmConstrucaoPlaceholder();
          case 6: // Perfil
            return const EmConstrucaoPlaceholder();
          default:
            return const EmConstrucaoPlaceholder();
        }
      },
    );
  }
}
