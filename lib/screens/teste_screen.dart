import 'package:flutter/material.dart';
import '../theme.dart';

class TesteScreen extends StatelessWidget {
  const TesteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.widgets,
            size: AppTheme.iconSizeXL,
            color: theme.colorScheme.primary,
          ),
          const SizedBox(height: AppTheme.spacingL),
          Text(
            'Tela de Teste',
            style: theme.textTheme.headlineSmall,
          ),
          const SizedBox(height: AppTheme.spacingM),
          Text(
            'Esta é uma tela de exemplo para testes',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.6),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
