import 'package:flutter/material.dart';
import '../../../services/dialog/form_dialog_service.dart';
import '../../form_layout.dart';

/// Botão que abre um FormDialog quando pressionado
/// Pode ser usado em qualquer lugar da aplicação
class FormDialogButton extends StatelessWidget {
  /// Texto do botão
  final String texto;

  /// Ícone do botão
  final IconData? icone;

  /// Variante do botão
  final ButtonVariant variant;

  /// Tamanho do botão
  final ButtonSize size;

  /// Se o botão está desabilitado
  final bool desabilitado;

  /// Título do dialog
  final String tituloDialog;

  /// Subtítulo do dialog
  final String? subtituloDialog;

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
  final IconData? iconeDialog;

  const FormDialogButton({
    super.key,
    required this.texto,
    this.icone,
    this.variant = ButtonVariant.primary,
    this.size = ButtonSize.medium,
    this.desabilitado = false,
    required this.tituloDialog,
    this.subtituloDialog,
    required this.formulario,
    this.textoConfirmacao = 'Confirmar',
    this.textoCancelamento = 'Cancelar',
    this.onConfirmar,
    this.onCancelar,
    this.mostrarCancelamento = true,
    this.larguraMaxima,
    this.alturaMaxima,
    this.barrierDismissible = true,
    this.iconeDialog,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      onPressed: desabilitado ? null : () => _abrirDialog(context),
      text: texto,
      icon: icone,
      variant: variant,
      size: size,
    );
  }

  void _abrirDialog(BuildContext context) {
    FormDialogService.mostrarFormulario(
      context: context,
      titulo: tituloDialog,
      subtitulo: subtituloDialog,
      formulario: formulario,
      textoConfirmacao: textoConfirmacao,
      textoCancelamento: textoCancelamento,
      onConfirmar: onConfirmar,
      onCancelar: onCancelar,
      mostrarCancelamento: mostrarCancelamento,
      larguraMaxima: larguraMaxima,
      alturaMaxima: alturaMaxima,
      barrierDismissible: barrierDismissible,
      icone: iconeDialog,
    );
  }
}
