import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Importar o arquivo de tema para acessar as cores
import 'theme.dart';

enum ThemeModeType { light, dark }

class ThemeManager extends ChangeNotifier {
  ThemeModeType _currentTheme = ThemeModeType.light;
  ThemeModeType get currentTheme => _currentTheme;

  // Carrega a preferência do usuário ao inicializar
  ThemeManager() {
    _loadThemePreference();
  }

  // Altera o tema e salva a preferência
  void toggleTheme() {
    _currentTheme = _currentTheme == ThemeModeType.light
        ? ThemeModeType.dark
        : ThemeModeType.light;
    notifyListeners();
    _saveThemePreference();
  }

  // Define o tema explicitamente
  void setTheme(ThemeModeType theme) {
    _currentTheme = theme;
    notifyListeners();
    _saveThemePreference();
  }

  // Retorna o tema atual como ThemeData
  ThemeData getThemeData(BuildContext context) {
    if (_currentTheme == ThemeModeType.light) {
      return ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppTheme.primary,
          surface: AppTheme.surfacePrimary,
          surfaceContainerLow: AppTheme.surfaceSecondary,
        ),
      );
    } else {
      return ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppTheme.primary,
          surface: AppTheme.surfaceDark,
          surfaceContainerLow: AppTheme.surfaceFooter,
        ),
      );
    }
  }

  // Salva a preferência do usuário
  Future<void> _saveThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme_mode', _currentTheme.toString());
  }

  // Carrega a preferência do usuário
  Future<void> _loadThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    final themeString = prefs.getString('theme_mode') ?? 'ThemeModeType.light';

    _currentTheme = themeString == 'ThemeModeType.dark'
        ? ThemeModeType.dark
        : ThemeModeType.light;
    notifyListeners();
  }
}
