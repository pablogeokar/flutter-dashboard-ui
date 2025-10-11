import 'package:flutter/material.dart';
import 'dialog_service.dart';

// ═══════════════════════════════════════════════════════════════════════════════════════════════
// DIALOG CALLBACKS - CALLBACKS GENÉRICOS PARA DIALOGS REUTILIZÁVEIS
// ═══════════════════════════════════════════════════════════════════════════════════════════════
//
// Este arquivo contém apenas callbacks genéricos para dialogs, sem regras de negócio específicas.
// É completamente reutilizável em qualquer projeto Flutter.
//
// CALLBACKS DISPONÍVEIS:
// • showFormCallback() - Callback genérico para formulários
// • showConfirmationCallback() - Callback para confirmações
// • showSearchCallback() - Callback para buscas
// • showInfoCallback() - Callback para informações
//
// CARACTERÍSTICAS:
// • Sem regras de negócio específicas
// • Completamente reutilizável
// • Callbacks customizáveis
// • Mensagens de feedback opcionais
// • Integração com SnackBar
//
// EXEMPLO DE USO:
// ```dart
// DrawerItem(
//   title: 'Add Item',
//   onTap: DialogCallbacks.showFormCallback(
//     context: context,
//     title: 'Add New Item',
//     form: MyFormWidget(),
//     onConfirm: () => _saveItem(),
//   ),
// );
// ```
// ═══════════════════════════════════════════════════════════════════════════════════════════════

/// **DialogCallbacks** - Callbacks genéricos para dialogs reutilizáveis
///
/// ## Propósito
/// Fornece callbacks pré-configurados para usar em menus, botões e outros
/// componentes que precisam abrir dialogs, sem regras de negócio específicas.
///
/// ## Características
/// - **Genérico**: Sem regras de negócio específicas
/// - **Reutilizável**: Funciona em qualquer projeto
/// - **Flexível**: Altamente customizável
/// - **Consistente**: Padrão de feedback uniforme
///
/// ## Métodos Principais
/// - `showFormCallback()` - Callback para formulários
/// - `showConfirmationCallback()` - Callback para confirmações
/// - `showSearchCallback()` - Callback para buscas
/// - `showInfoCallback()` - Callback para informações
class DialogCallbacks {
  // ═══════════════════════════════════════════════════════════════════════════════════════════════
  // CALLBACK PRINCIPAL - FORMULÁRIO GENÉRICO
  // ═══════════════════════════════════════════════════════════════════════════════════════════════

  /// **showFormCallback** - Callback genérico para formulários
  ///
  /// ## Propósito
  /// Cria um callback que abre um dialog de formulário completamente genérico.
  /// Não contém regras de negócio específicas, sendo reutilizável em qualquer projeto.
  ///
  /// ## Parâmetros
  /// - `context` - BuildContext obrigatório
  /// - `title` - Título do dialog
  /// - `subtitle` - Descrição opcional (recomendado)
  /// - `form` - Widget do formulário a ser exibido
  /// - `confirmText` - Texto do botão de confirmação (padrão: "Confirm")
  /// - `cancelText` - Texto do botão de cancelamento (padrão: "Cancel")
  /// - `onConfirm` - Callback executado ao confirmar (opcional)
  /// - `onCancel` - Callback executado ao cancelar (opcional)
  /// - `successMessage` - Mensagem de sucesso (opcional)
  /// - `cancelMessage` - Mensagem de cancelamento (opcional)
  /// - `maxWidth` - Largura máxima do dialog
  /// - `maxHeight` - Altura máxima do dialog
  /// - `icon` - Ícone do header (opcional)
  ///
  /// ## Exemplo de Uso
  /// ```dart
  /// DrawerItem(
  ///   title: 'Add Customer',
  ///   onTap: DialogCallbacks.showFormCallback(
  ///     context: context,
  ///     title: 'New Customer',
  ///     subtitle: 'Enter customer information',
  ///     icon: Icons.person_add,
  ///     form: CustomerFormWidget(),
  ///     onConfirm: () => _saveCustomer(),
  ///     successMessage: 'Customer saved successfully!',
  ///   ),
  /// );
  /// ```
  ///
  /// ## Retorno
  /// `VoidCallback` pronto para usar em onTap, onPressed, etc.
  static VoidCallback showFormCallback({
    required BuildContext context,
    required String title,
    String? subtitle,
    required Widget form,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    String? successMessage,
    String? cancelMessage,
    double? maxWidth,
    double? maxHeight,
    IconData? icon,
  }) {
    return () {
      DialogService.showFormDialog(
        context: context,
        title: title,
        subtitle: subtitle,
        form: form,
        confirmText: confirmText,
        cancelText: cancelText,
        maxWidth: maxWidth,
        maxHeight: maxHeight,
        icon: icon,
        onConfirm: onConfirm != null
            ? () {
                onConfirm();
                if (successMessage != null) {
                  _showSuccessMessage(context, successMessage);
                }
              }
            : null,
        onCancel: onCancel != null
            ? () {
                onCancel();
                if (cancelMessage != null) {
                  _showCancelMessage(context, cancelMessage);
                }
              }
            : cancelMessage != null
            ? () => _showCancelMessage(context, cancelMessage)
            : null,
      );
    };
  }

  // ═══════════════════════════════════════════════════════════════════════════════════════════════
  // CALLBACKS ESPECIALIZADOS GENÉRICOS
  // ═══════════════════════════════════════════════════════════════════════════════════════════════

  /// **showConfirmationCallback** - Callback para confirmações
  ///
  /// ## Propósito
  /// Cria um callback que abre um dialog de confirmação genérico para ações
  /// que precisam de confirmação do usuário.
  ///
  /// ## Exemplo de Uso
  /// ```dart
  /// IconButton(
  ///   icon: Icon(Icons.delete),
  ///   onPressed: DialogCallbacks.showConfirmationCallback(
  ///     context: context,
  ///     title: 'Delete Item',
  ///     message: 'Are you sure you want to delete this item?',
  ///     confirmText: 'Delete',
  ///     onConfirm: () => _deleteItem(),
  ///     successMessage: 'Item deleted successfully!',
  ///   ),
  /// );
  /// ```
  static VoidCallback showConfirmationCallback({
    required BuildContext context,
    required String title,
    required String message,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    String? successMessage,
    String? cancelMessage,
    IconData? icon,
  }) {
    return () {
      DialogService.showConfirmationDialog(
        context: context,
        title: title,
        message: message,
        confirmText: confirmText,
        cancelText: cancelText,
        icon: icon,
        onConfirm: onConfirm != null
            ? () {
                onConfirm();
                if (successMessage != null) {
                  _showSuccessMessage(context, successMessage);
                }
              }
            : null,
        onCancel: onCancel != null
            ? () {
                onCancel();
                if (cancelMessage != null) {
                  _showCancelMessage(context, cancelMessage);
                }
              }
            : cancelMessage != null
            ? () => _showCancelMessage(context, cancelMessage)
            : null,
      );
    };
  }

  /// **showSearchCallback** - Callback para buscas
  ///
  /// ## Propósito
  /// Cria um callback que abre um dialog de busca genérico.
  ///
  /// ## Exemplo de Uso
  /// ```dart
  /// FloatingActionButton(
  ///   onPressed: DialogCallbacks.showSearchCallback(
  ///     context: context,
  ///     title: 'Search Items',
  ///     searchForm: SearchFormWidget(),
  ///     onSearch: () => _performSearch(),
  ///     successMessage: 'Search completed!',
  ///   ),
  ///   child: Icon(Icons.search),
  /// );
  /// ```
  static VoidCallback showSearchCallback({
    required BuildContext context,
    required String title,
    required Widget searchForm,
    VoidCallback? onSearch,
    VoidCallback? onCancel,
    String? successMessage,
    String? cancelMessage,
  }) {
    return () {
      DialogService.showSearchDialog(
        context: context,
        title: title,
        searchForm: searchForm,
        onSearch: onSearch != null
            ? () {
                onSearch();
                if (successMessage != null) {
                  _showSuccessMessage(context, successMessage);
                }
              }
            : null,
        onCancel: onCancel != null
            ? () {
                onCancel();
                if (cancelMessage != null) {
                  _showCancelMessage(context, cancelMessage);
                }
              }
            : cancelMessage != null
            ? () => _showCancelMessage(context, cancelMessage)
            : null,
      );
    };
  }

  /// **showInfoCallback** - Callback para informações
  ///
  /// ## Propósito
  /// Cria um callback que abre um dialog informativo genérico.
  ///
  /// ## Exemplo de Uso
  /// ```dart
  /// ListTile(
  ///   title: Text('Help'),
  ///   onTap: DialogCallbacks.showInfoCallback(
  ///     context: context,
  ///     title: 'Help',
  ///     message: 'This is how you use this feature...',
  ///     icon: Icons.help,
  ///   ),
  /// );
  /// ```
  static VoidCallback showInfoCallback({
    required BuildContext context,
    required String title,
    required String message,
    IconData? icon,
    VoidCallback? onOk,
  }) {
    return () {
      DialogService.showInfoDialog(
        context: context,
        title: title,
        message: message,
        icon: icon,
        onOk: onOk,
      );
    };
  }

  // ═══════════════════════════════════════════════════════════════════════════════════════════════
  // MÉTODOS PRIVADOS DE APOIO
  // ═══════════════════════════════════════════════════════════════════════════════════════════════

  /// Exibe mensagem de sucesso genérica
  static void _showSuccessMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  /// Exibe mensagem de cancelamento genérica
  static void _showCancelMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.redAccent,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
