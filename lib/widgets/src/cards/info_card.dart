import 'package:flutter/material.dart';
import '../../../theme/theme.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({
    super.key,
    required this.title,
    required this.value,
    required this.details,
    this.detailsPositive,
    required this.icon,
    required this.color,
  });

  final String title;
  final String value;
  final String details;
  final bool? detailsPositive;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.borderRadiusM),
      ),
      clipBehavior: Clip.antiAlias,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color, color.withOpacity(0.7)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              right: -15, // Ajustado posicionamento
              top: -15, // Ajustado posicionamento
              child: Opacity(
                opacity: 0.15, // Reduzido opacidade para menos distração
                child: Icon(
                  icon,
                  size: 70,
                  color: Colors.white,
                ), // Reduzido de 100 para 70
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(
                AppTheme.spacingS,
              ), // Reduzido de spacingM para spacingS
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    icon,
                    color: Colors.white,
                    size: 24,
                  ), // Reduzido de 30 para 24
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              color: Colors.white.withValues(alpha: 0.8),
                              fontWeight: FontWeight.w500,
                              fontSize: 13, // Reduzido tamanho da fonte
                            ),
                      ),
                      SizedBox(height: AppTheme.spacingXS),
                      Text(
                        value,
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: AppTheme.getResponsiveFontSize(
                                screenWidth,
                                18,
                              ), // Reduzido de 22 para 18
                            ),
                      ),
                      SizedBox(
                        height: AppTheme.spacingXS,
                      ), // Reduzido de spacingS para spacingXS
                      Row(
                        children: [
                          if (detailsPositive != null)
                            Icon(
                              detailsPositive!
                                  ? Icons.arrow_upward_rounded
                                  : Icons.arrow_downward_rounded,
                              size: 12, // Reduzido de 14 para 12
                              color: Colors.white.withValues(alpha: 0.8),
                            ),
                          if (detailsPositive != null)
                            const SizedBox(width: AppTheme.spacingXS),
                          Text(
                            details,
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  color: Colors.white.withValues(alpha: 0.9),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 11, // Reduzido tamanho da fonte
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
