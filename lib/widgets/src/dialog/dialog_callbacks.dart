import 'package:flutter/material.dart';
import 'form_dialog_service.dart';

/// Classe com callbacks pré-configurados para usar nos itens da drawer
class DialogCallbacks {
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
            ),
          );
        },
        onCancelar: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Cadastro de cliente cancelado!'),
              backgroundColor: Colors.orange,
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
            ),
          );
        },
        onCancelar: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Cadastro de fornecedor cancelado!'),
              backgroundColor: Colors.orange,
            ),
          );
        },
      );
    };
  }

  /// Callback para configurações
  static VoidCallback configuracoes(BuildContext context) {
    return () {
      FormDialogService.mostrarConfiguracoes(
        context: context,
        onConfirmar: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Configurações salvas com sucesso!'),
              backgroundColor: Colors.green,
            ),
          );
        },
        onCancelar: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Alterações descartadas!'),
              backgroundColor: Colors.orange,
            ),
          );
        },
      );
    };
  }

  /// Callback para busca
  static VoidCallback busca(
    BuildContext context, {
    required String titulo,
    required Widget formularioBusca,
  }) {
    return () {
      FormDialogService.mostrarBusca(
        context: context,
        titulo: titulo,
        formularioBusca: formularioBusca,
        onConfirmar: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Busca realizada com sucesso!'),
              backgroundColor: Colors.green,
            ),
          );
        },
        onCancelar: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Busca cancelada!'),
              backgroundColor: Colors.orange,
            ),
          );
        },
      );
    };
  }

  /// Callback customizado
  static VoidCallback customizado(
    BuildContext context, {
    required String titulo,
    String? subtitulo,
    required Widget formulario,
    String textoConfirmacao = 'Confirmar',
    String textoCancelamento = 'Cancelar',
    VoidCallback? onConfirmar,
    VoidCallback? onCancelar,
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
        onConfirmar: onConfirmar,
        onCancelar: onCancelar,
        larguraMaxima: larguraMaxima,
        alturaMaxima: alturaMaxima,
        icone: icone,
      );
    };
  }
}
