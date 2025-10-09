import 'package:flutter/material.dart';
import 'form_dialog.dart';

/// Serviço para facilitar a exibição de dialogs de formulário
/// Fornece métodos estáticos para diferentes tipos de formulários
class FormDialogService {
  /// Mostra um dialog de formulário genérico
  static Future<T?> mostrarFormulario<T>({
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
    return FormDialog.mostrar<T>(
      context: context,
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
  }

  /// Mostra um dialog de cadastro de cliente
  static Future<T?> mostrarCadastroCliente<T>({
    required BuildContext context,
    VoidCallback? onConfirmar,
    VoidCallback? onCancelar,
  }) {
    return mostrarFormulario<T>(
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

  /// Mostra um dialog de cadastro de fornecedor
  static Future<T?> mostrarCadastroFornecedor<T>({
    required BuildContext context,
    VoidCallback? onConfirmar,
    VoidCallback? onCancelar,
  }) {
    return mostrarFormulario<T>(
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

  /// Mostra um dialog de cadastro de produto
  static Future<T?> mostrarCadastroProduto<T>({
    required BuildContext context,
    VoidCallback? onConfirmar,
    VoidCallback? onCancelar,
  }) {
    return mostrarFormulario<T>(
      context: context,
      titulo: 'Cadastro de Produto',
      subtitulo: 'Preencha os dados do novo produto',
      icone: Icons.inventory,
      larguraMaxima: 800,
      onConfirmar: onConfirmar,
      onCancelar: onCancelar,
      formulario: _buildFormularioProduto(),
    );
  }

  /// Mostra um dialog de configurações
  static Future<T?> mostrarConfiguracoes<T>({
    required BuildContext context,
    VoidCallback? onConfirmar,
    VoidCallback? onCancelar,
  }) {
    return mostrarFormulario<T>(
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

  /// Mostra um dialog de busca/filtro
  static Future<T?> mostrarBusca<T>({
    required BuildContext context,
    required String titulo,
    required Widget formularioBusca,
    VoidCallback? onConfirmar,
    VoidCallback? onCancelar,
  }) {
    return mostrarFormulario<T>(
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

  /// Mostra um dialog de confirmação com formulário
  static Future<T?> mostrarConfirmacao<T>({
    required BuildContext context,
    required String titulo,
    required String mensagem,
    required Widget formulario,
    String textoConfirmacao = 'Confirmar',
    String textoCancelamento = 'Cancelar',
    VoidCallback? onConfirmar,
    VoidCallback? onCancelar,
    IconData? icone,
  }) {
    return mostrarFormulario<T>(
      context: context,
      titulo: titulo,
      subtitulo: mensagem,
      icone: icone ?? Icons.help_outline,
      larguraMaxima: 500,
      textoConfirmacao: textoConfirmacao,
      textoCancelamento: textoCancelamento,
      onConfirmar: onConfirmar,
      onCancelar: onCancelar,
      formulario: formulario,
    );
  }

  // Formulários específicos (implementações de exemplo)

  static Widget _buildFormularioCliente() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Implementar formulário de cliente aqui
        Text('Formulário de Cliente - Em desenvolvimento'),
        SizedBox(height: 16),
        Text('Este será o formulário completo de cadastro de cliente.'),
      ],
    );
  }

  static Widget _buildFormularioFornecedor() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Implementar formulário de fornecedor aqui
        Text('Formulário de Fornecedor - Em desenvolvimento'),
        SizedBox(height: 16),
        Text('Este será o formulário completo de cadastro de fornecedor.'),
      ],
    );
  }

  static Widget _buildFormularioProduto() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Implementar formulário de produto aqui
        Text('Formulário de Produto - Em desenvolvimento'),
        SizedBox(height: 16),
        Text('Este será o formulário completo de cadastro de produto.'),
      ],
    );
  }

  static Widget _buildFormularioConfiguracoes() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Implementar formulário de configurações aqui
        Text('Formulário de Configurações - Em desenvolvimento'),
        SizedBox(height: 16),
        Text('Este será o formulário de configurações do sistema.'),
      ],
    );
  }
}
