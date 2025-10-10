import 'package:dashboard_ui/widgets/src/app_layout/app_shell.dart';
import 'package:flutter/material.dart';
export 'src/app_layout/drawer_item.dart';
export 'src/app_layout/desktop_status_bar.dart';

/// Widget principal da aplicação após inicialização
class AppLayout extends StatelessWidget {
  const AppLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppShell();
  }
}
