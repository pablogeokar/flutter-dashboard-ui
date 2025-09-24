import 'package:dashboard_ui/screens/em_construcao_screen.dart';
import 'package:dashboard_ui/screens/teste_screen.dart';
import 'package:dashboard_ui/widgets/layout/layout_base_widget.dart';
import 'package:flutter/material.dart';

class LayoutWidget extends StatefulWidget {
  const LayoutWidget({super.key});

  @override
  State<LayoutWidget> createState() => _LayoutWidgetState();
}

class _LayoutWidgetState extends State<LayoutWidget> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return LayoutBaseWidget(
      screenBuilder: (int index) {
        switch (index) {
          case 0: // Painel Principal
            return const EmConstrucaoPlaceholder();
          case 1: // Análises
            return const EmConstrucaoPlaceholder();
          case 2: // Relatórios
            return const EmConstrucaoPlaceholder();
          case 3: // Projetos
            return const TesteScreen();
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
      currentIndex: _selectedIndex,
      onNavigation: (int index) {
        setState(() {
          _selectedIndex = index;
        });
      },
    );
  }
}
