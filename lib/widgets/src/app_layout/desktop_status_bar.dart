import 'package:flutter/material.dart';
import '../../../theme/theme.dart';

/// Barra de status para aplicações desktop Windows
/// Exibe informações úteis como status da conexão, hora, etc.
class DesktopStatusBar extends StatelessWidget {
  final String? statusMessage;
  final bool isConnected;
  final VoidCallback? onStatusTap;

  const DesktopStatusBar({
    super.key,
    this.statusMessage,
    this.isConnected = true,
    this.onStatusTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        border: Border(
          top: BorderSide(
            color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          // Status da aplicação
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppTheme.spacingS,
              ),
              child: Row(
                children: [
                  // Indicador de conexão
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: isConnected
                          ? AppTheme.successLight
                          : AppTheme.errorLight,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: AppTheme.spacingS),
                  // Mensagem de status
                  Expanded(
                    child: Text(
                      statusMessage ??
                          (isConnected ? 'Conectado' : 'Desconectado'),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withValues(alpha: 0.7),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Informações do sistema
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingS),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Versão da aplicação
                Text(
                  'v1.0.0',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
                const SizedBox(width: AppTheme.spacingM),

                // Hora atual
                StreamBuilder<DateTime>(
                  stream: Stream.periodic(
                    const Duration(seconds: 1),
                    (_) => DateTime.now(),
                  ),
                  builder: (context, snapshot) {
                    final now = snapshot.data ?? DateTime.now();
                    return Text(
                      '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withValues(alpha: 0.8),
                        fontWeight: FontWeight.w500,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
