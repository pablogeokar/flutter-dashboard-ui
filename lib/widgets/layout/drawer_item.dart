import 'package:flutter/material.dart';

class DrawerItem {
  final String title;
  final IconData icon;
  final Widget screen;

  const DrawerItem({
    required this.title,
    required this.icon,
    required this.screen,
  });
}
