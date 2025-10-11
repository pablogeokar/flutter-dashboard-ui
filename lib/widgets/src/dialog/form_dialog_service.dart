import 'package:flutter/material.dart';
import 'form_dialog.dart';
import '../forms/form_components.dart';
import '../forms/form_row.dart';

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
        DomaniTextField(
          label: 'Nome Completo',
          hint: 'Digite o nome completo do cliente',
          prefixIcon: Icons.person_outline_rounded,
          required: true,
          helperText: 'Nome como deve aparecer nos documentos fiscais',
        ),
        SizedBox(height: 20),
        FormRowFlex.top(
          items: [
            FormRowItem(
              flex: 2,
              child: DomaniTextField(
                label: 'CPF/CNPJ',
                hint: '000.000.000-00',
                prefixIcon: Icons.badge_outlined,
                required: true,
                keyboardType: TextInputType.number,
              ),
            ),
            FormRowItem(
              flex: 1,
              child: DomaniDropdown<String>(
                label: 'Tipo',
                hint: 'Selecione',
                required: true,
                items: [
                  DropdownMenuItem(value: 'PF', child: Text('Pessoa Física')),
                  DropdownMenuItem(value: 'PJ', child: Text('Pessoa Jurídica')),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        FormRow.top(
          children: [
            DomaniTextField(
              label: 'Email',
              hint: 'cliente@exemplo.com',
              prefixIcon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
              helperText: 'Para envio de documentos fiscais',
            ),
            DomaniTextField(
              label: 'Telefone',
              hint: '(11) 99999-9999',
              prefixIcon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
              helperText: 'Contato principal do cliente',
            ),
          ],
        ),
        SizedBox(height: 20),
        DomaniTextField(
          label: 'Endereço',
          hint: 'Rua, número, complemento',
          prefixIcon: Icons.location_on_outlined,
          helperText: 'Endereço para entrega e cobrança',
        ),
        SizedBox(height: 20),
        FormRowFlex.top(
          items: [
            FormRowItem(
              flex: 1,
              child: DomaniTextField(
                label: 'CEP',
                hint: '00000-000',
                keyboardType: TextInputType.number,
              ),
            ),
            FormRowItem(
              flex: 2,
              child: DomaniTextField(label: 'Cidade', hint: 'Nome da cidade'),
            ),
            FormRowItem(
              flex: 1,
              child: DomaniDropdown<String>(
                label: 'UF',
                hint: 'SP',
                items: [
                  DropdownMenuItem(value: 'SP', child: Text('SP')),
                  DropdownMenuItem(value: 'RJ', child: Text('RJ')),
                  DropdownMenuItem(value: 'MG', child: Text('MG')),
                  // Adicionar outros estados conforme necessário
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// Constrói o formulário de cadastro de fornecedor
  static Widget _buildFormularioFornecedor() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DomaniTextField(
          label: 'Razão Social',
          hint: 'Nome da empresa conforme CNPJ',
          prefixIcon: Icons.business_outlined,
          required: true,
          helperText: 'Nome oficial da empresa para documentos fiscais',
        ),
        SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: DomaniTextField(
                label: 'CNPJ',
                hint: '00.000.000/0000-00',
                prefixIcon: Icons.badge_outlined,
                required: true,
                keyboardType: TextInputType.number,
                helperText: 'Documento principal da empresa',
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: DomaniTextField(
                label: 'Inscrição Estadual',
                hint: '000.000.000.000',
                keyboardType: TextInputType.number,
                helperText: 'Deixe em branco se isento',
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: DomaniTextField(
                label: 'Email',
                hint: 'contato@fornecedor.com',
                prefixIcon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                required: true,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: DomaniTextField(
                label: 'Telefone',
                hint: '(11) 3000-0000',
                prefixIcon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        DomaniDropdown<String>(
          label: 'Regime Tributário',
          hint: 'Selecione o regime',
          prefixIcon: Icons.gavel_outlined,
          required: true,
          items: [
            DropdownMenuItem(value: 'simples', child: Text('Simples Nacional')),
            DropdownMenuItem(
              value: 'presumido',
              child: Text('Lucro Presumido'),
            ),
            DropdownMenuItem(value: 'real', child: Text('Lucro Real')),
            DropdownMenuItem(value: 'mei', child: Text('MEI')),
          ],
          helperText: 'Regime tributário do fornecedor para cálculos fiscais',
        ),
        SizedBox(height: 20),
        DomaniTextField(
          label: 'Observações',
          hint: 'Informações adicionais sobre o fornecedor',
          maxLines: 3,
          helperText: 'Condições de pagamento, prazos de entrega, etc.',
        ),
      ],
    );
  }

  /// Constrói o formulário de configurações
  static Widget _buildFormularioConfiguracoes() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DomaniTextField(
          label: 'Nome da Empresa',
          hint: 'Domani Fiscal Ltda',
          prefixIcon: Icons.business_center_outlined,
          required: true,
          helperText: 'Nome que aparecerá nos relatórios e documentos',
        ),
        SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: DomaniTextField(
                label: 'Email de Contato',
                hint: 'contato@empresa.com',
                prefixIcon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                required: true,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: DomaniTextField(
                label: 'Telefone',
                hint: '(11) 3000-0000',
                prefixIcon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        DomaniDropdown<String>(
          label: 'Tema da Aplicação',
          hint: 'Selecione o tema',
          prefixIcon: Icons.palette_outlined,
          items: [
            DropdownMenuItem(value: 'light', child: Text('Claro')),
            DropdownMenuItem(value: 'dark', child: Text('Escuro')),
            DropdownMenuItem(value: 'auto', child: Text('Automático')),
          ],
          helperText: 'Tema visual da interface do sistema',
        ),
        SizedBox(height: 20),
        DomaniDropdown<String>(
          label: 'Regime Tributário',
          hint: 'Selecione o regime',
          prefixIcon: Icons.gavel_outlined,
          required: true,
          items: [
            DropdownMenuItem(value: 'simples', child: Text('Simples Nacional')),
            DropdownMenuItem(
              value: 'presumido',
              child: Text('Lucro Presumido'),
            ),
            DropdownMenuItem(value: 'real', child: Text('Lucro Real')),
            DropdownMenuItem(value: 'mei', child: Text('MEI')),
          ],
          helperText: 'Regime tributário da empresa para cálculos automáticos',
        ),
        SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: DomaniTextField(
                label: 'CNPJ',
                hint: '00.000.000/0000-00',
                prefixIcon: Icons.badge_outlined,
                keyboardType: TextInputType.number,
                required: true,
                helperText: 'CNPJ da empresa configurada',
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: DomaniTextField(
                label: 'Inscrição Estadual',
                hint: '000.000.000.000',
                keyboardType: TextInputType.number,
                helperText: 'Deixe em branco se isento',
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        DomaniTextField(
          label: 'Observações',
          hint: 'Configurações adicionais do sistema',
          maxLines: 3,
          helperText: 'Informações gerais sobre a configuração da empresa',
        ),
      ],
    );
  }
}
