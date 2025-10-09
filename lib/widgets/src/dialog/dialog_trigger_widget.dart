import 'package:flutter/material.dart';
import 'form_dialog_service.dart';

/// Widget que automaticamente abre um FormDialog quando é exibido
/// Útil para usar em itens da drawer que devem abrir dialogs
class DialogTriggerWidget extends StatefulWidget {
  /// Título do dialog
  final String titulo;

  /// Subtítulo do dialog
  final String? subtitulo;

  /// Widget do formulário
  final Widget formulario;

  /// Texto do botão de confirmação
  final String textoConfirmacao;

  /// Texto do botão de cancelamento
  final String textoCancelamento;

  /// Callback de confirmação
  final VoidCallback? onConfirmar;

  /// Callback de cancelamento
  final VoidCallback? onCancelar;

  /// Se deve mostrar o botão de cancelamento
  final bool mostrarCancelamento;

  /// Largura máxima do dialog
  final double? larguraMaxima;

  /// Altura máxima do dialog
  final double? alturaMaxima;

  /// Se pode fechar clicando fora
  final bool barrierDismissible;

  /// Ícone do dialog
  final IconData? icone;

  const DialogTriggerWidget({
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
  State<DialogTriggerWidget> createState() => _DialogTriggerWidgetState();
}

class _DialogTriggerWidgetState extends State<DialogTriggerWidget> {
  @override
  void initState() {
    super.initState();
    // Abre o dialog automaticamente quando o widget é construído
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _abrirDialog();
    });
  }

  void _abrirDialog() {
    FormDialogService.mostrarFormulario(
      context: context,
      titulo: widget.titulo,
      subtitulo: widget.subtitulo,
      formulario: widget.formulario,
      textoConfirmacao: widget.textoConfirmacao,
      textoCancelamento: widget.textoCancelamento,
      onConfirmar: () {
        widget.onConfirmar?.call();
        Navigator.of(context).pop(); // Volta para a tela anterior
      },
      onCancelar: () {
        widget.onCancelar?.call();
        Navigator.of(context).pop(); // Volta para a tela anterior
      },
      mostrarCancelamento: widget.mostrarCancelamento,
      larguraMaxima: widget.larguraMaxima,
      alturaMaxima: widget.alturaMaxima,
      barrierDismissible: widget.barrierDismissible,
      icone: widget.icone,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Retorna um widget vazio, pois o dialog é aberto automaticamente
    return const SizedBox.shrink();
  }
}
