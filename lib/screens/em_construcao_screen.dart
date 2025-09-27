import 'package:flutter/material.dart';
import '../theme/theme.dart';

class EmConstrucaoPlaceholder extends StatelessWidget {
  const EmConstrucaoPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(
          AppTheme.spacingL * 2,
        ), // 32 é o dobro de spacingL (16)
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.construction,
              size: 80,
              color: Theme.of(context).colorScheme.primary,
            ),
            SizedBox(height: AppTheme.spacingL), // 24 é 1.5 vezes spacingM (16)
            Text(
              'Em Construção',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ), // Aumentando o tamanho da fonte
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppTheme.spacingM),
            Text(
              'Esta funcionalidade está sendo desenvolvida e estará disponível em breve.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: AppTheme.spacingL * 2,
            ), // 32 é o dobro de spacingL (16)
            Container(
              padding: EdgeInsets.all(AppTheme.spacingM),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(AppTheme.borderRadiusM),
                border: Border.all(
                  color: Theme.of(context).colorScheme.outlineVariant,
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.help_outline,
                    color: Theme.of(context).colorScheme.primary,
                    size: 20,
                  ),
                  SizedBox(width: AppTheme.spacingS),
                  Text(
                    'Volte mais tarde para ver a experiência completa',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
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
