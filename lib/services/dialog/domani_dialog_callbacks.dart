import 'package:flutter/material.dart';
import 'form_dialog_service.dart';

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
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Cliente cadastrado com sucesso!'),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
              duration: Duration(seconds: 3),
            ),
          );
        },
        onCancelar: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Cadastro de cliente cancelado!'),
              backgroundColor: Colors.orange,
              behavior: SnackBarBehavior.floating,
              duration: Duration(seconds: 2),
            ),
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
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Fornecedor cadastrado com sucesso!'),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
              duration: Duration(seconds: 3),
            ),
          );
        },
        onCancelar: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Cadastro de fornecedor cancelado!'),
              backgroundColor: Colors.orange,
              behavior: SnackBarBehavior.floating,
              duration: Duration(seconds: 2),
            ),
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
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Configurações salvas com sucesso!'),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
              duration: Duration(seconds: 3),
            ),
          );
        },
        onCancelar: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Alterações descartadas!'),
              backgroundColor: Colors.orange,
              behavior: SnackBarBehavior.floating,
              duration: Duration(seconds: 2),
            ),
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
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(mensagemSucesso ?? 'Busca realizada com sucesso!'),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
              duration: const Duration(seconds: 3),
            ),
          );
        },
        onCancelar: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(mensagemCancelamento ?? 'Busca cancelada!'),
              backgroundColor: Colors.orange,
              behavior: SnackBarBehavior.floating,
              duration: const Duration(seconds: 2),
            ),
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
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('$item excluído com sucesso!'),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
              duration: const Duration(seconds: 3),
            ),
          );
        },
        onCancelar: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Exclusão cancelada!'),
              backgroundColor: Colors.orange,
              behavior: SnackBarBehavior.floating,
              duration: Duration(seconds: 2),
            ),
          );
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
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(mensagemSucesso),
                      backgroundColor: Colors.green,
                      behavior: SnackBarBehavior.floating,
                      duration: const Duration(seconds: 3),
                    ),
                  );
                }
              }
            : null,
        onCancelar: onCancelar != null
            ? () {
                onCancelar();
                if (mensagemCancelamento != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(mensagemCancelamento),
                      backgroundColor: Colors.orange,
                      behavior: SnackBarBehavior.floating,
                      duration: const Duration(seconds: 2),
                    ),
                  );
                }
              }
            : mensagemCancelamento != null
            ? () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(mensagemCancelamento),
                    backgroundColor: Colors.orange,
                    behavior: SnackBarBehavior.floating,
                    duration: const Duration(seconds: 2),
                  ),
                );
              }
            : null,
      );
    };
  }
}
