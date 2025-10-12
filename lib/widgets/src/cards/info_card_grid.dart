import 'package:flutter/material.dart';
import '../../../theme/theme.dart';

class InfoCardGrid extends StatelessWidget {
  const InfoCardGrid({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isLargeScreen = screenWidth >= AppTheme.breakpointLarge;

    if (isLargeScreen) {
      return GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 4,
        crossAxisSpacing: AppTheme.spacingL,
        mainAxisSpacing: AppTheme.spacingL,
        childAspectRatio: 2.2,
        children: children,
      );
    } else {
      return Wrap(
        spacing: AppTheme.spacingM,
        runSpacing: AppTheme.spacingM,
        children: children.map((card) {
          return Container(
            width: 280,
            height: 160,
            child: card,
          );
        }).toList(),
      );
    }
  }
}
