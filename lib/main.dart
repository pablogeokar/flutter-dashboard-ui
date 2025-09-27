import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'config/sidebar_config.dart';
import 'theme/dark.dart';
import 'theme/light.dart';
import 'theme/theme_manager.dart';
import 'widgets/app_layout.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
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
