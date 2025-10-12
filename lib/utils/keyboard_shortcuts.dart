import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Gerenciador de atalhos de teclado para desktop Windows
class KeyboardShortcuts {
  // Método para obter os atalhos
  static Map<LogicalKeySet, Intent> getShortcuts() {
    return {
      // Atalho para alternar tema
      LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyT):
          const ToggleThemeIntent(),

      // Atalho para abrir a busca
      LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyK):
          const SearchIntent(),
    };
  }
}

// === INTENTS (Intenções) ===

class ToggleThemeIntent extends Intent {
  const ToggleThemeIntent();
}

class SearchIntent extends Intent {
  const SearchIntent();
}

// === ACTIONS (Ações) ===

class ToggleThemeAction extends Action<ToggleThemeIntent> {
  final VoidCallback onToggle;

  ToggleThemeAction({required this.onToggle});

  @override
  Object? invoke(ToggleThemeIntent intent) {
    onToggle();
    return null;
  }
}

class SearchAction extends Action<SearchIntent> {
  final VoidCallback onSearch;

  SearchAction({required this.onSearch});

  @override
  Object? invoke(SearchIntent intent) {
    onSearch();
    return null;
  }
}
