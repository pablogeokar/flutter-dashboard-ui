import 'package:flutter/material.dart';
import 'form_dialog_service.dart';

/// Widget que chama um dialog quando é exibido
/// Útil para usar como screen em DrawerItem quando você quer abrir um dialog
class DialogTriggerWidget extends StatefulWidget {
  final String titulo;
  final String? subtitulo;
  final Widget formulario;
  final String textoConfirmacao;
  final String textoCancelamento;
  final VoidCallback? onConfirmar;
  final VoidCallback? onCancelar;
  final bool mostrarCancelamento;
  final double? larguraMaxima;
  final double? alturaMaxima;
  final bool barrierDismissible;
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
    // Chama o dialog automaticamente quando o widget é construído
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _mostrarDialog();
    });
  }

  void _mostrarDialog() {
    FormDialogService.mostrarFormulario(
      context: context,
      titulo: widget.titulo,
      subtitulo: widget.subtitulo,
      formulario: widget.formulario,
      textoConfirmacao: widget.textoConfirmacao,
      textoCancelamento: widget.textoCancelamento,
      onConfirmar: () {
        widget.onConfirmar?.call();
        // Volta para a tela anterior após confirmar
        Navigator.of(context).pop();
      },
      onCancelar: () {
        widget.onCancelar?.call();
        // Volta para a tela anterior após cancelar
        Navigator.of(context).pop();
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
    // Widget vazio pois o dialog é mostrado automaticamente
    return const SizedBox.shrink();
  }
}

/// Widgets pré-configurados para diferentes tipos de dialogs
class DialogTriggers {
  /// Dialog de cadastro de cliente
  static Widget cadastroCliente({
    VoidCallback? onConfirmar,
    VoidCallback? onCancelar,
  }) {
    return DialogTriggerWidget(
      titulo: 'Cadastro de Cliente',
      subtitulo: 'Preencha os dados do novo cliente',
      icone: Icons.person_add,
      larguraMaxima: 700,
      onConfirmar: onConfirmar,
      onCancelar: onCancelar,
      formulario: _buildFormularioCliente(),
    );
  }

  /// Dialog de cadastro de fornecedor
  static Widget cadastroFornecedor({
    VoidCallback? onConfirmar,
    VoidCallback? onCancelar,
  }) {
    return DialogTriggerWidget(
      titulo: 'Cadastro de Fornecedor',
      subtitulo: 'Preencha os dados do novo fornecedor',
      icone: Icons.business,
      larguraMaxima: 700,
      onConfirmar: onConfirmar,
      onCancelar: onCancelar,
      formulario: _buildFormularioFornecedor(),
    );
  }

  /// Dialog de configurações
  static Widget configuracoes({
    VoidCallback? onConfirmar,
    VoidCallback? onCancelar,
  }) {
    return DialogTriggerWidget(
      titulo: 'Configurações',
      subtitulo: 'Ajuste as configurações do sistema',
      icone: Icons.settings,
      larguraMaxima: 600,
      onConfirmar: onConfirmar,
      onCancelar: onCancelar,
      formulario: _buildFormularioConfiguracoes(),
    );
  }

  /// Dialog de busca
  static Widget busca({
    required String titulo,
    required Widget formularioBusca,
    VoidCallback? onConfirmar,
    VoidCallback? onCancelar,
  }) {
    return DialogTriggerWidget(
      titulo: titulo,
      subtitulo: 'Digite os critérios de busca',
      icone: Icons.search,
      larguraMaxima: 500,
      onConfirmar: onConfirmar,
      onCancelar: onCancelar,
      formulario: formularioBusca,
    );
  }

  // Formulários específicos (implementações de exemplo)

  static Widget _buildFormularioCliente() {
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

  static Widget _buildFormularioFornecedor() {
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

  static Widget _buildFormularioConfiguracoes() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Formulário de Configurações'),
        SizedBox(height: 16),
        Text('Este será o formulário de configurações do sistema.'),
        SizedBox(height: 16),
        Text('• Tema da aplicação'),
        Text('• Idioma'),
        Text('• Notificações'),
        Text('• Privacidade'),
        Text('• Backup'),
      ],
    );
  }
}
