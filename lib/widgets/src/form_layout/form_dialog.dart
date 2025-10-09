import 'package:flutter/material.dart';
import '../../../theme/theme.dart';
import '../../../theme/animations.dart';

/// Widget de dialog reutilizável para exibir formulários
/// Pode ser chamado de qualquer lugar da aplicação
class FormDialog extends StatefulWidget {
  /// Título do dialog
  final String titulo;

  /// Subtítulo/descrição do dialog
  final String? subtitulo;

  /// Widget de formulário a ser exibido
  final Widget formulario;

  /// Texto do botão de confirmação
  final String textoConfirmacao;

  /// Texto do botão de cancelamento
  final String textoCancelamento;

  /// Callback chamado quando o formulário é confirmado
  final VoidCallback? onConfirmar;

  /// Callback chamado quando o dialog é cancelado
  final VoidCallback? onCancelar;

  /// Se deve mostrar o botão de cancelamento
  final bool mostrarCancelamento;

  /// Largura máxima do dialog
  final double? larguraMaxima;

  /// Altura máxima do dialog
  final double? alturaMaxima;

  /// Se o dialog pode ser fechado clicando fora dele
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

  /// Método estático para mostrar o dialog
  static Future<T?> mostrar<T>({
    required BuildContext context,
    required String titulo,
    String? subtitulo,
    required Widget formulario,
    String textoConfirmacao = 'Confirmar',
    String textoCancelamento = 'Cancelar',
    VoidCallback? onConfirmar,
    VoidCallback? onCancelar,
    bool mostrarCancelamento = true,
    double? larguraMaxima,
    double? alturaMaxima,
    bool barrierDismissible = true,
    IconData? icone,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => FormDialog(
        titulo: titulo,
        subtitulo: subtitulo,
        formulario: formulario,
        textoConfirmacao: textoConfirmacao,
        textoCancelamento: textoCancelamento,
        onConfirmar: onConfirmar,
        onCancelar: onCancelar,
        mostrarCancelamento: mostrarCancelamento,
        larguraMaxima: larguraMaxima,
        alturaMaxima: alturaMaxima,
        barrierDismissible: barrierDismissible,
        icone: icone,
      ),
    );
  }

  @override
  State<FormDialog> createState() => _FormDialogState();
}

class _FormDialogState extends State<FormDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: AppAnimations.normal,
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: AppAnimations.easeOut,
      ),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: AppAnimations.easeOut,
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _fecharDialog() {
    _animationController.reverse().then((_) {
      if (mounted) {
        Navigator.of(context).pop();
      }
    });
  }

  void _confirmar() {
    widget.onConfirmar?.call();
    _fecharDialog();
  }

  void _cancelar() {
    widget.onCancelar?.call();
    _fecharDialog();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return FadeTransition(
          opacity: _fadeAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Dialog(
              backgroundColor: Colors.transparent,
              elevation: 0,
              child: Container(
                width: widget.larguraMaxima ?? 600,
                height: widget.alturaMaxima,
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.9,
                  maxHeight: MediaQuery.of(context).size.height * 0.9,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? AppTheme.drawerBackgroundDark
                      : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Theme.of(context).brightness == Brightness.dark
                      ? Border.all(
                          color: AppTheme.primaryDark.withValues(alpha: 0.15),
                          width: 1,
                        )
                      : null,
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.black.withValues(alpha: 0.4)
                          : Colors.black.withValues(alpha: 0.1),
                      blurRadius: 30,
                      offset: const Offset(0, 15),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Header do dialog
                    _buildHeader(),

                    // Conteúdo do formulário
                    Flexible(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: widget.formulario,
                        ),
                      ),
                    ),

                    // Rodapé com botões
                    _buildFooter(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? AppTheme.neutral800.withValues(alpha: 0.4)
            : AppTheme.neutral50,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).brightness == Brightness.dark
                ? AppTheme.primaryDark.withValues(alpha: 0.2)
                : AppTheme.neutral200,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          // Ícone do dialog
          if (widget.icone != null) ...[
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppTheme.primaryDark.withValues(alpha: 0.8)
                    : Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? AppTheme.primaryDark.withValues(alpha: 0.2)
                        : Theme.of(
                            context,
                          ).colorScheme.primary.withValues(alpha: 0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(widget.icone, color: Colors.white, size: 24),
            ),
            const SizedBox(width: 16),
          ],

          // Título e subtítulo
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.titulo,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                if (widget.subtitulo != null) ...[
                  const SizedBox(height: 6),
                  Text(
                    widget.subtitulo!,
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.75),
                    ),
                  ),
                ],
              ],
            ),
          ),

          // Botão de fechar
          GestureDetector(
            onTap: _fecharDialog,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppTheme.neutral700.withValues(alpha: 0.3)
                    : AppTheme.neutral200.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.close,
                size: 20,
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? AppTheme.neutral800.withValues(alpha: 0.2)
            : AppTheme.neutral50.withValues(alpha: 0.8),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        border: Border(
          top: BorderSide(
            color: Theme.of(context).brightness == Brightness.dark
                ? AppTheme.neutral700.withValues(alpha: 0.2)
                : AppTheme.neutral200.withValues(alpha: 0.5),
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (widget.mostrarCancelamento) ...[
            TextButton(
              onPressed: _cancelar,
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                widget.textoCancelamento,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.7),
                ),
              ),
            ),
            const SizedBox(width: 12),
          ],
          ElevatedButton(
            onPressed: _confirmar,
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).brightness == Brightness.dark
                  ? AppTheme.primaryDark
                  : Theme.of(context).colorScheme.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 2,
              shadowColor: Theme.of(context).brightness == Brightness.dark
                  ? AppTheme.primaryDark.withValues(alpha: 0.3)
                  : Theme.of(
                      context,
                    ).colorScheme.primary.withValues(alpha: 0.3),
            ),
            child: Text(
              widget.textoConfirmacao,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
