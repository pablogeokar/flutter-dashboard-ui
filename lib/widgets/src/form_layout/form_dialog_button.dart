import 'package:flutter/material.dart';
import 'form_dialog_service.dart';
import 'custom_button.dart';

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

  /// Título do dialog
  final String tituloDialog;

  /// Subtítulo do dialog
  final String? subtituloDialog;

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
  final IconData? iconeDialog;

  /// Se o botão está desabilitado
  final bool desabilitado;

  const FormDialogButton({
    super.key,
    required this.texto,
    this.icone,
    this.variant = ButtonVariant.primary,
    this.size = ButtonSize.medium,
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
    this.desabilitado = false,
  });

  /// Construtor para botão de cadastro de cliente
  const FormDialogButton.cadastroCliente({
    super.key,
    this.texto = 'Cadastrar Cliente',
    this.icone = Icons.person_add,
    this.variant = ButtonVariant.primary,
    this.size = ButtonSize.medium,
    this.tituloDialog = 'Cadastro de Cliente',
    this.subtituloDialog = 'Preencha os dados do novo cliente',
    this.iconeDialog = Icons.person_add,
    this.larguraMaxima = 700,
    this.onConfirmar,
    this.onCancelar,
    this.desabilitado = false,
  }) : formulario = const _FormularioCliente(),
       textoConfirmacao = 'Cadastrar',
       textoCancelamento = 'Cancelar',
       mostrarCancelamento = true,
       alturaMaxima = null,
       barrierDismissible = true;

  /// Construtor para botão de cadastro de fornecedor
  const FormDialogButton.cadastroFornecedor({
    super.key,
    this.texto = 'Cadastrar Fornecedor',
    this.icone = Icons.business,
    this.variant = ButtonVariant.secondary,
    this.size = ButtonSize.medium,
    this.tituloDialog = 'Cadastro de Fornecedor',
    this.subtituloDialog = 'Preencha os dados do novo fornecedor',
    this.iconeDialog = Icons.business,
    this.larguraMaxima = 700,
    this.onConfirmar,
    this.onCancelar,
    this.desabilitado = false,
  }) : formulario = const _FormularioFornecedor(),
       textoConfirmacao = 'Cadastrar',
       textoCancelamento = 'Cancelar',
       mostrarCancelamento = true,
       alturaMaxima = null,
       barrierDismissible = true;

  /// Construtor para botão de busca
  const FormDialogButton.busca({
    super.key,
    this.texto = 'Buscar',
    this.icone = Icons.search,
    this.variant = ButtonVariant.outline,
    this.size = ButtonSize.medium,
    required this.tituloDialog,
    this.subtituloDialog = 'Digite os critérios de busca',
    this.iconeDialog = Icons.search,
    this.larguraMaxima = 500,
    this.onConfirmar,
    this.onCancelar,
    this.desabilitado = false,
  }) : formulario = const _FormularioBusca(),
       textoConfirmacao = 'Buscar',
       textoCancelamento = 'Cancelar',
       mostrarCancelamento = true,
       alturaMaxima = null,
       barrierDismissible = true;

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

// Formulários específicos para os construtores

class _FormularioCliente extends StatelessWidget {
  const _FormularioCliente();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Formulário de Cliente'),
        SizedBox(height: 16),
        Text('Este será o formulário completo de cadastro de cliente.'),
        SizedBox(height: 16),
        Text('• Nome completo'),
        Text('• Email'),
        Text('• Telefone'),
        Text('• Endereço'),
        Text('• Data de nascimento'),
      ],
    );
  }
}

class _FormularioFornecedor extends StatelessWidget {
  const _FormularioFornecedor();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Formulário de Fornecedor'),
        SizedBox(height: 16),
        Text('Este será o formulário completo de cadastro de fornecedor.'),
        SizedBox(height: 16),
        Text('• Razão social'),
        Text('• CNPJ'),
        Text('• Email'),
        Text('• Telefone'),
        Text('• Endereço'),
      ],
    );
  }
}

class _FormularioBusca extends StatelessWidget {
  const _FormularioBusca();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Formulário de Busca'),
        SizedBox(height: 16),
        Text('Digite os critérios de busca:'),
        SizedBox(height: 16),
        Text('• Nome'),
        Text('• Status'),
        Text('• Data de cadastro'),
        Text('• Categoria'),
      ],
    );
  }
}
