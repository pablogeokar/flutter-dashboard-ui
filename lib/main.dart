import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'config/sidebar_config.dart';
import 'theme/theme.dart';
import 'theme/theme_manager.dart';
import 'widgets/app_layout.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final lightTheme = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppTheme.primary,
        brightness: Brightness.light,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );

    final darkTheme = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppTheme.primary,
        brightness: Brightness.dark,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );

    return ChangeNotifierProvider<ThemeManager>(
      create: (context) => ThemeManager(),
      child: Consumer<ThemeManager>(
        builder: (context, themeManager, child) {
          return MaterialApp(
            title: 'Dashboard UI',
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: themeManager.currentTheme == ThemeModeType.dark
                ? ThemeMode.dark
                : ThemeMode.light,
            home: const LayoutWidget(
              itensPrincipais: SidebarConfig.itensPrincipais,
              itensInferiores: SidebarConfig.itensInferiores,
            ),
          );
        },
      ),
    );
  }
}
