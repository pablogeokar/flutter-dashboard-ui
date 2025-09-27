import 'package:flutter/material.dart';

class DrawerItem {
  final String title;
  final IconData icon;
  final Widget? screen;
  final List<DrawerItem>? subItems;

  const DrawerItem({
    required this.title,
    required this.icon,
    this.screen,
    this.subItems,
  }) : assert(screen != null || subItems != null, 'DrawerItem must have a screen or a list of subItems');
}
