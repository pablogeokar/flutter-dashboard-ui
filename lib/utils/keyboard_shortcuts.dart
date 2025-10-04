import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Gerenciador de atalhos de teclado para desktop Windows
class KeyboardShortcuts {
  // Método para obter os atalhos
  static Map<LogicalKeySet, Intent> getShortcuts() {
    return {
      // Navegação básica
      LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyT):
          const ToggleThemeIntent(),
    };
  }
}

// === INTENTS (Intenções) ===

class ToggleThemeIntent extends Intent {
  const ToggleThemeIntent();
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
