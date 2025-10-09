import 'package:flutter/material.dart';
import '../../../theme/animations.dart';

/// Widget de dialog reutilizável para exibir formulários
/// Pode ser chamado de qualquer lugar da aplicação
class FormDialog extends StatefulWidget {
  /// Título do dialog
  final String titulo;

  /// Subtítulo opcional
  final String? subtitulo;

  /// Widget do formulário a ser exibido
  final Widget formulario;

  /// Texto do botão de confirmação
  final String textoConfirmacao;

  /// Texto do botão de cancelamento
  final String textoCancelamento;

  /// Callback executado ao confirmar
  final VoidCallback? onConfirmar;

  /// Callback executado ao cancelar
  final VoidCallback? onCancelar;

  /// Se deve mostrar o botão de cancelamento
  final bool mostrarCancelamento;

  /// Largura máxima do dialog
  final double? larguraMaxima;

  /// Altura máxima do dialog
  final double? alturaMaxima;

  /// Se pode fechar clicando fora do dialog
  final bool barrierDismissible;

  /// Ícone do dialog
  final IconData? icone;

  const FormDialog({
    super.key,
    required this.titulo,
    this.subtitulo,
    required this.formulario,
    this.textoConfirmacao = 'Confirmar',
    this.textoCancelamento = 'Cancelar',
    this.onConfirmar,
    this.onCancelar,
    this.mostrarCancelamento = true,
    this.larguraMaxima,
    this.alturaMaxima,
    this.barrierDismissible = true,
    this.icone,
  });

  @override
  State<FormDialog> createState() => _FormDialogState();
}

class _FormDialogState extends State<FormDialog> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    // Configuração das animações
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: AppAnimations.easeOut),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: AppAnimations.easeOut),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(16),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return FadeTransition(
            opacity: _fadeAnimation,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: widget.larguraMaxima ?? 600,
                  maxHeight: widget.alturaMaxima ?? 700,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildHeader(),
                    Flexible(child: _buildContent()),
                    _buildFooter(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.05),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Row(
        children: [
          if (widget.icone != null) ...[
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(
                  context,
                ).colorScheme.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                widget.icone,
                color: Theme.of(context).colorScheme.primary,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.titulo,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                if (widget.subtitulo != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    widget.subtitulo!,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ],
            ),
          ),
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.close),
            style: IconButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.surface,
              foregroundColor: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Padding(padding: const EdgeInsets.all(24), child: widget.formulario);
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
        border: Border(
          top: BorderSide(
            color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (widget.mostrarCancelamento) ...[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                widget.onCancelar?.call();
              },
              child: Text(widget.textoCancelamento),
            ),
            const SizedBox(width: 12),
          ],
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              widget.onConfirmar?.call();
            },
            child: Text(widget.textoConfirmacao),
          ),
        ],
      ),
    );
  }
}
