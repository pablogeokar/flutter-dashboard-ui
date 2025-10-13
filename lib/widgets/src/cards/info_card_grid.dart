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
        crossAxisSpacing:
            AppTheme.spacingM, // Reduzido de spacingL para spacingM
        mainAxisSpacing:
            AppTheme.spacingM, // Reduzido de spacingL para spacingM
        childAspectRatio: 2.4, // Aumentado para cards mais compactos
        children: children,
      );
    } else {
      return Wrap(
        spacing: AppTheme.spacingS, // Reduzido de spacingM para spacingS
        runSpacing: AppTheme.spacingS, // Reduzido de spacingM para spacingS
        children: children.map((card) {
          return SizedBox(
            width: 260,
            height: 140,
            child: card,
          ); // Reduzido tamanho: 280x160 -> 260x140
        }).toList(),
      );
    }
  }
}
