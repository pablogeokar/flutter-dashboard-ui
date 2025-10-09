import 'package:flutter/material.dart';
import 'form_dialog.dart';
import '../../form_layout.dart';

/// Serviço com métodos estáticos para exibir diferentes tipos de FormDialog
class FormDialogService {
  /// Exibe um dialog de formulário genérico
  static Future<void> mostrarFormulario({
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
    return showDialog<void>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return FormDialog(
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
        );
      },
    );
  }

  /// Exibe um dialog de cadastro de cliente
  static Future<void> mostrarCadastroCliente({
    required BuildContext context,
    VoidCallback? onConfirmar,
    VoidCallback? onCancelar,
  }) {
    return mostrarFormulario(
      context: context,
      titulo: 'Cadastro de Cliente',
      subtitulo: 'Preencha os dados do novo cliente',
      icone: Icons.person_add,
      larguraMaxima: 700,
      onConfirmar: onConfirmar,
      onCancelar: onCancelar,
      formulario: _buildFormularioCliente(),
    );
  }

  /// Exibe um dialog de cadastro de fornecedor
  static Future<void> mostrarCadastroFornecedor({
    required BuildContext context,
    VoidCallback? onConfirmar,
    VoidCallback? onCancelar,
  }) {
    return mostrarFormulario(
      context: context,
      titulo: 'Cadastro de Fornecedor',
      subtitulo: 'Preencha os dados do novo fornecedor',
      icone: Icons.business,
      larguraMaxima: 700,
      onConfirmar: onConfirmar,
      onCancelar: onCancelar,
      formulario: _buildFormularioFornecedor(),
    );
  }

  /// Exibe um dialog de configurações
  static Future<void> mostrarConfiguracoes({
    required BuildContext context,
    VoidCallback? onConfirmar,
    VoidCallback? onCancelar,
  }) {
    return mostrarFormulario(
      context: context,
      titulo: 'Configurações',
      subtitulo: 'Ajuste as configurações do sistema',
      icone: Icons.settings,
      larguraMaxima: 600,
      onConfirmar: onConfirmar,
      onCancelar: onCancelar,
      formulario: _buildFormularioConfiguracoes(),
    );
  }

  /// Exibe um dialog de busca
  static Future<void> mostrarBusca({
    required BuildContext context,
    required String titulo,
    required Widget formularioBusca,
    VoidCallback? onConfirmar,
    VoidCallback? onCancelar,
  }) {
    return mostrarFormulario(
      context: context,
      titulo: titulo,
      subtitulo: 'Digite os critérios de busca',
      icone: Icons.search,
      larguraMaxima: 500,
      onConfirmar: onConfirmar,
      onCancelar: onCancelar,
      formulario: formularioBusca,
    );
  }

  /// Exibe um dialog de confirmação
  static Future<void> mostrarConfirmacao({
    required BuildContext context,
    required String titulo,
    required String mensagem,
    String textoConfirmacao = 'Confirmar',
    String textoCancelamento = 'Cancelar',
    VoidCallback? onConfirmar,
    VoidCallback? onCancelar,
    IconData? icone,
  }) {
    return mostrarFormulario(
      context: context,
      titulo: titulo,
      subtitulo: mensagem,
      icone: icone ?? Icons.help_outline,
      larguraMaxima: 400,
      onConfirmar: onConfirmar,
      onCancelar: onCancelar,
      textoConfirmacao: textoConfirmacao,
      textoCancelamento: textoCancelamento,
      formulario:
          const SizedBox.shrink(), // Dialog de confirmação não precisa de formulário
    );
  }

  /// Constrói o formulário de cadastro de cliente
  static Widget _buildFormularioCliente() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextInputField(
          labelText: 'Nome Completo',
          hintText: 'Digite o nome completo do cliente',
        ),
        const SizedBox(height: 16),
        TextInputField(
          labelText: 'Email',
          hintText: 'Digite o email do cliente',
        ),
        const SizedBox(height: 16),
        TextInputField(
          labelText: 'Telefone',
          hintText: 'Digite o telefone do cliente',
        ),
        const SizedBox(height: 16),
        DateInputField(
          label: 'Data de Nascimento',
          initialValue: DateTime.now(),
        ),
      ],
    );
  }

  /// Constrói o formulário de cadastro de fornecedor
  static Widget _buildFormularioFornecedor() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextInputField(
          labelText: 'Razão Social',
          hintText: 'Digite a razão social da empresa',
        ),
        const SizedBox(height: 16),
        TextInputField(labelText: 'CNPJ', hintText: 'Digite o CNPJ da empresa'),
        const SizedBox(height: 16),
        TextInputField(
          labelText: 'Email',
          hintText: 'Digite o email da empresa',
        ),
        const SizedBox(height: 16),
        TextInputField(
          labelText: 'Telefone',
          hintText: 'Digite o telefone da empresa',
        ),
      ],
    );
  }

  /// Constrói o formulário de configurações
  static Widget _buildFormularioConfiguracoes() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextInputField(
          labelText: 'Nome da Empresa',
          hintText: 'Digite o nome da sua empresa',
        ),
        const SizedBox(height: 16),
        TextInputField(
          labelText: 'Email de Contato',
          hintText: 'Digite o email de contato',
        ),
        const SizedBox(height: 16),
        SelectInputField<String>(
          labelText: 'Tema da Aplicação',
          hintText: 'Selecione o tema',
          options: const [
            SelectOption(value: 'light', label: 'Claro'),
            SelectOption(value: 'dark', label: 'Escuro'),
            SelectOption(value: 'auto', label: 'Automático'),
          ],
          onChanged: (value) {},
        ),
      ],
    );
  }
}
