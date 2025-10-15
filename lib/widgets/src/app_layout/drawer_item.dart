import 'package:flutter/material.dart';

class DrawerItem {
  final String title;
  final IconData icon;
  final IconData? selectedIcon; // Novo: ícone para o estado selecionado
  final Widget? screen;
  final List<DrawerItem>? subItems;
  final VoidCallback? onDialogTap; // Novo: callback para abrir dialog

  const DrawerItem({
    required this.title,
    required this.icon,
    this.selectedIcon,
    this.screen,
    this.subItems,
    this.onDialogTap,
  }) : assert(
         screen != null || subItems != null || onDialogTap != null,
         'DrawerItem must have a screen, a list of subItems, or a dialog callback',
       );
}
