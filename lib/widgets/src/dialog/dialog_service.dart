import 'package:flutter/material.dart';
import 'form_dialog.dart';

// ═══════════════════════════════════════════════════════════════════════════════════════════════
// DIALOG SERVICE - SERVIÇO GENÉRICO PARA DIALOGS REUTILIZÁVEIS
// ═══════════════════════════════════════════════════════════════════════════════════════════════
//
// Este arquivo contém apenas métodos genéricos para exibir dialogs, sem regras de negócio
// específicas. É completamente reutilizável em qualquer projeto Flutter.
//
// MÉTODOS DISPONÍVEIS:
// • showFormDialog() - Dialog genérico com formulário
// • showConfirmationDialog() - Dialog de confirmação simples
// • showSearchDialog() - Dialog de busca genérico
// • showInfoDialog() - Dialog informativo
//
// CARACTERÍSTICAS:
// • Sem regras de negócio específicas
// • Completamente reutilizável
// • Scroll automático
// • Animações suaves
// • Design responsivo
// • Acessibilidade completa
//
// EXEMPLO DE USO:
// ```dart
// await DialogService.showFormDialog(
//   context: context,
//   title: 'Meu Dialog',
//   subtitle: 'Descrição do que faz',
//   icon: Icons.edit,
//   form: _buildMyForm(),
//   onConfirm: () => _saveData(),
// );
// ```
// ═══════════════════════════════════════════════════════════════════════════════════════════════

/// **DialogService** - Serviço genérico para dialogs reutilizáveis
///
/// ## Propósito
/// Fornece métodos genéricos para exibir dialogs sem regras de negócio específicas,
/// permitindo reutilização completa em qualquer projeto Flutter.
///
/// ## Características
/// - **Genérico**: Sem regras de negócio específicas
/// - **Reutilizável**: Funciona em qualquer projeto
/// - **Flexível**: Altamente customizável
/// - **Consistente**: Padrão visual uniforme
///
/// ## Métodos Principais
/// - `showFormDialog()` - Dialog com formulário customizável
/// - `showConfirmationDialog()` - Confirmação simples
/// - `showSearchDialog()` - Busca genérica
/// - `showInfoDialog()` - Informação/alerta
class DialogService {
  // ═══════════════════════════════════════════════════════════════════════════════════════════════
  // MÉTODO PRINCIPAL - DIALOG DE FORMULÁRIO
  // ═══════════════════════════════════════════════════════════════════════════════════════════════

  /// **showFormDialog** - Exibe um dialog genérico com formulário
  ///
  /// ## Propósito
  /// Método base completamente genérico para criar dialogs com formulários.
  /// Não contém regras de negócio específicas, sendo reutilizável em qualquer projeto.
  ///
  /// ## Parâmetros
  /// - `context` - BuildContext obrigatório
  /// - `title` - Título principal do dialog
  /// - `subtitle` - Descrição opcional (recomendado)
  /// - `form` - Widget do formulário a ser exibido
  /// - `confirmText` - Texto do botão de confirmação (padrão: "Confirmar")
  /// - `cancelText` - Texto do botão de cancelamento (padrão: "Cancelar")
  /// - `onConfirm` - Callback executado ao confirmar
  /// - `onCancel` - Callback executado ao cancelar (opcional)
  /// - `showCancel` - Se deve mostrar botão cancelar (padrão: true)
  /// - `maxWidth` - Largura máxima do dialog (padrão: 600px)
  /// - `maxHeight` - Altura máxima do dialog (padrão: 700px)
  /// - `barrierDismissible` - Se pode fechar clicando fora (padrão: true)
  /// - `icon` - Ícone do header (opcional)
  ///
  /// ## Exemplo de Uso
  /// ```dart
  /// await DialogService.showFormDialog(
  ///   context: context,
  ///   title: 'Edit Item',
  ///   subtitle: 'Update the item information',
  ///   icon: Icons.edit,
  ///   maxWidth: 800,
  ///   form: Column(
  ///     children: [
  ///       TextField(decoration: InputDecoration(labelText: 'Name')),
  ///       SizedBox(height: 16),
  ///       Row(
  ///         children: [
  ///           Expanded(child: TextField(decoration: InputDecoration(labelText: 'Email'))),
  ///           SizedBox(width: 16),
  ///           Expanded(child: TextField(decoration: InputDecoration(labelText: 'Phone'))),
  ///         ],
  ///       ),
  ///     ],
  ///   ),
  ///   onConfirm: () => _saveItem(),
  /// );
  /// ```
  ///
  /// ## Retorno
  /// `Future<void>` que completa quando o dialog é fechado
  static Future<void> showFormDialog({
    required BuildContext context,
    required String title,
    String? subtitle,
    required Widget form,
    String confirmText = 'Confirmar',
    String cancelText = 'Cancelar',
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    bool showCancel = true,
    double? maxWidth,
    double? maxHeight,
    bool barrierDismissible = true,
    IconData? icon,
  }) {
    return showDialog<void>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return FormDialog(
          titulo: title,
          subtitulo: subtitle,
          formulario: form,
          textoConfirmacao: confirmText,
          textoCancelamento: cancelText,
          onConfirmar: onConfirm,
          onCancelar: onCancel,
          mostrarCancelamento: showCancel,
          larguraMaxima: maxWidth,
          alturaMaxima: maxHeight,
          barrierDismissible: barrierDismissible,
          icone: icon,
        );
      },
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════════════════════════
  // DIALOGS ESPECIALIZADOS GENÉRICOS
  // ═══════════════════════════════════════════════════════════════════════════════════════════════

  /// **showConfirmationDialog** - Dialog simples de confirmação
  ///
  /// ## Propósito
  /// Exibe um dialog de confirmação genérico para ações que precisam de
  /// confirmação do usuário (exclusões, alterações importantes, etc.).
  ///
  /// ## Características
  /// - Sem formulário (apenas mensagem)
  /// - Botões customizáveis
  /// - Ícone de alerta por padrão
  /// - Largura compacta (400px)
  ///
  /// ## Exemplo de Uso
  /// ```dart
  /// await DialogService.showConfirmationDialog(
  ///   context: context,
  ///   title: 'Confirm Deletion',
  ///   message: 'Are you sure you want to delete this item?',
  ///   confirmText: 'Delete',
  ///   icon: Icons.warning,
  ///   onConfirm: () => _deleteItem(),
  /// );
  /// ```
  static Future<void> showConfirmationDialog({
    required BuildContext context,
    required String title,
    required String message,
    String confirmText = 'Confirmar',
    String cancelText = 'Cancelar',
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    IconData? icon,
  }) {
    return showFormDialog(
      context: context,
      title: title,
      subtitle: message,
      icon: icon ?? Icons.help_outline,
      maxWidth: 400,
      onConfirm: onConfirm,
      onCancel: onCancel,
      confirmText: confirmText,
      cancelText: cancelText,
      form: const SizedBox.shrink(), // No form for confirmation dialog
    );
  }

  /// **showSearchDialog** - Dialog genérico para busca
  ///
  /// ## Propósito
  /// Exibe um dialog de busca customizável que pode ser usado para
  /// diferentes tipos de pesquisa em qualquer aplicação.
  ///
  /// ## Características
  /// - Formulário de busca customizável
  /// - Botão "Buscar" ao invés de "Confirmar"
  /// - Largura otimizada para campos de busca
  /// - Ícone de lupa no header
  ///
  /// ## Exemplo de Uso
  /// ```dart
  /// await DialogService.showSearchDialog(
  ///   context: context,
  ///   title: 'Search Items',
  ///   searchForm: Column(
  ///     children: [
  ///       TextField(decoration: InputDecoration(labelText: 'Name')),
  ///       SizedBox(height: 16),
  ///       Row(
  ///         children: [
  ///           Expanded(child: TextField(decoration: InputDecoration(labelText: 'Category'))),
  ///           SizedBox(width: 16),
  ///           Expanded(child: TextField(decoration: InputDecoration(labelText: 'Status'))),
  ///         ],
  ///       ),
  ///     ],
  ///   ),
  ///   onSearch: () => _performSearch(),
  /// );
  /// ```
  static Future<void> showSearchDialog({
    required BuildContext context,
    required String title,
    required Widget searchForm,
    VoidCallback? onSearch,
    VoidCallback? onCancel,
  }) {
    return showFormDialog(
      context: context,
      title: title,
      subtitle: 'Enter search criteria',
      icon: Icons.search,
      maxWidth: 500,
      onConfirm: onSearch,
      onCancel: onCancel,
      confirmText: 'Buscar',
      form: searchForm,
    );
  }

  /// **showInfoDialog** - Dialog informativo genérico
  ///
  /// ## Propósito
  /// Exibe informações, alertas ou mensagens para o usuário.
  ///
  /// ## Características
  /// - Apenas botão "OK"
  /// - Ícone customizável
  /// - Largura compacta
  /// - Ideal para notificações
  ///
  /// ## Exemplo de Uso
  /// ```dart
  /// await DialogService.showInfoDialog(
  ///   context: context,
  ///   title: 'Success',
  ///   message: 'Item saved successfully!',
  ///   icon: Icons.check_circle,
  /// );
  /// ```
  static Future<void> showInfoDialog({
    required BuildContext context,
    required String title,
    required String message,
    IconData? icon,
    VoidCallback? onOk,
  }) {
    return showFormDialog(
      context: context,
      title: title,
      subtitle: message,
      icon: icon ?? Icons.info_outline,
      maxWidth: 400,
      showCancel: false,
      confirmText: 'OK',
      onConfirm: onOk,
      form: const SizedBox.shrink(),
    );
  }
}
