import 'package:flutter/material.dart';
import '../../widgets/feedback.dart';
import 'form.dart';

/// DomaniDialogCallbacks - Callbacks específicos do projeto Domani Fiscal
///
/// Contém callbacks pré-configurados para os dialogs específicos do sistema
/// fiscal, usando o FormDialogService com formulários personalizados.
///
/// LOCALIZAÇÃO: lib/services/dialog/
/// RAZÃO: Callbacks específicos do projeto são SERVIÇOS, não widgets genéricos.
class DomaniDialogCallbacks {
  /// Callback para cadastro de cliente
  static VoidCallback cadastroCliente(BuildContext context) {
    return () {
      FormDialogService.mostrarCadastroCliente(
        context: context,
        onConfirmar: () {
          SnackBarService.showSuccess(
            context,
            message: 'Cliente cadastrado com sucesso!',
          );
        },
        onCancelar: () {
          SnackBarService.showWarning(
            context,
            message: 'Cadastro de cliente cancelado!',
          );
        },
      );
    };
  }

  /// Callback para cadastro de fornecedor
  static VoidCallback cadastroFornecedor(BuildContext context) {
    return () {
      FormDialogService.mostrarCadastroFornecedor(
        context: context,
        onConfirmar: () {
          SnackBarService.showSuccess(
            context,
            message: 'Fornecedor cadastrado com sucesso!',
          );
        },
        onCancelar: () {
          SnackBarService.showWarning(
            context,
            message: 'Cadastro de fornecedor cancelado!',
          );
        },
      );
    };
  }

  /// Callback para configurações do sistema
  static VoidCallback configuracoes(BuildContext context) {
    return () {
      FormDialogService.mostrarConfiguracoes(
        context: context,
        onConfirmar: () {
          SnackBarService.showSuccess(
            context,
            message: 'Configurações salvas com sucesso!',
          );
        },
        onCancelar: () {
          SnackBarService.showWarning(
            context,
            message: 'Alterações descartadas!',
          );
        },
      );
    };
  }

  /// Callback para busca genérica com formulário customizado
  static VoidCallback busca(
    BuildContext context, {
    required String titulo,
    required Widget formularioBusca,
    String? mensagemSucesso,
    String? mensagemCancelamento,
  }) {
    return () {
      FormDialogService.mostrarBusca(
        context: context,
        titulo: titulo,
        formularioBusca: formularioBusca,
        onConfirmar: () {
          SnackBarService.showSuccess(
            context,
            message: mensagemSucesso ?? 'Busca realizada com sucesso!',
          );
        },
        onCancelar: () {
          SnackBarService.showWarning(
            context,
            message: mensagemCancelamento ?? 'Busca cancelada!',
          );
        },
      );
    };
  }

  /// Callback para confirmação de exclusão
  static VoidCallback confirmarExclusao(
    BuildContext context, {
    required String item,
    required VoidCallback onConfirmar,
  }) {
    return () {
      FormDialogService.mostrarConfirmacao(
        context: context,
        titulo: 'Confirmar Exclusão',
        mensagem:
            'Deseja realmente excluir $item?\n\nEsta ação não pode ser desfeita.',
        textoConfirmacao: 'Excluir',
        textoCancelamento: 'Cancelar',
        icone: Icons.warning_amber_rounded,
        onConfirmar: () {
          onConfirmar();
          SnackBarService.showSuccess(
            context,
            message: '$item excluído com sucesso!',
          );
        },
        onCancelar: () {
          SnackBarService.showWarning(context, message: 'Exclusão cancelada!');
        },
      );
    };
  }

  /// Callback customizado para formulários específicos do projeto
  static VoidCallback customizado(
    BuildContext context, {
    required String titulo,
    String? subtitulo,
    required Widget formulario,
    String textoConfirmacao = 'Confirmar',
    String textoCancelamento = 'Cancelar',
    VoidCallback? onConfirmar,
    VoidCallback? onCancelar,
    String? mensagemSucesso,
    String? mensagemCancelamento,
    double? larguraMaxima,
    double? alturaMaxima,
    IconData? icone,
  }) {
    return () {
      FormDialogService.mostrarFormulario(
        context: context,
        titulo: titulo,
        subtitulo: subtitulo,
        formulario: formulario,
        textoConfirmacao: textoConfirmacao,
        textoCancelamento: textoCancelamento,
        larguraMaxima: larguraMaxima,
        alturaMaxima: alturaMaxima,
        icone: icone,
        onConfirmar: onConfirmar != null
            ? () {
                onConfirmar();
                if (mensagemSucesso != null) {
                  SnackBarService.showSuccess(
                    context,
                    message: mensagemSucesso,
                  );
                }
              }
            : null,
        onCancelar: onCancelar != null
            ? () {
                onCancelar();
                if (mensagemCancelamento != null) {
                  SnackBarService.showWarning(
                    context,
                    message: mensagemCancelamento,
                  );
                }
              }
            : mensagemCancelamento != null
            ? () {
                SnackBarService.showWarning(
                  context,
                  message: mensagemCancelamento,
                );
              }
            : null,
      );
    };
  }
}
