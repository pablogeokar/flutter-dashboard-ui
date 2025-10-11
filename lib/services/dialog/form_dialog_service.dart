import 'package:flutter/material.dart';
import '../../widgets/src/dialog/form_dialog.dart';
import '../../widgets/form.dart';
import '../../widgets/src/forms/layout/form_row.dart';
import '../../widgets/src/forms/validators/form_validators.dart';

/// FormDialogService - Servicos para dialogs de formulario padronizados
///
/// Centraliza a criacao de dialogs comuns do sistema, garantindo consistencia
/// visual e de UX em toda a aplicacao.
///
/// LOCALIZACAO: lib/services/dialog/
/// RAZAO: FormDialogService e um SERVICO, nao um widget.
class FormDialogService {
  /// Exibe um dialog de formulario generico
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

  /// Dialog para cadastro de cliente
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

  /// Dialog para cadastro de fornecedor
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

  /// Dialog para configuracoes do sistema
  static Future<void> mostrarConfiguracoes({
    required BuildContext context,
    VoidCallback? onConfirmar,
    VoidCallback? onCancelar,
  }) {
    return mostrarFormulario(
      context: context,
      titulo: 'Configuracoes',
      subtitulo: 'Ajuste as configuracoes do sistema',
      icone: Icons.settings,
      larguraMaxima: 600,
      onConfirmar: onConfirmar,
      onCancelar: onCancelar,
      formulario: _buildFormularioConfiguracoes(),
    );
  }

  /// Dialog de confirmacao simples
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
      formulario: const SizedBox.shrink(),
    );
  }

  /// Dialog para busca/pesquisa
  static Future<void> mostrarBusca({
    required BuildContext context,
    required String titulo,
    required Widget formularioBusca,
    String textoConfirmacao = 'Buscar',
    String textoCancelamento = 'Cancelar',
    VoidCallback? onConfirmar,
    VoidCallback? onCancelar,
  }) {
    return mostrarFormulario(
      context: context,
      titulo: titulo,
      subtitulo: 'Preencha os criterios de busca',
      icone: Icons.search,
      larguraMaxima: 600,
      onConfirmar: onConfirmar,
      onCancelar: onCancelar,
      textoConfirmacao: textoConfirmacao,
      textoCancelamento: textoCancelamento,
      formulario: formularioBusca,
    );
  }

  // Formulario de cadastro de cliente
  static Widget _buildFormularioCliente() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextInputField(
          labelText: 'Nome Completo',
          hintText: 'Digite o nome completo do cliente',
          validator: FormValidators.combine([
            FormValidators.required('Nome e obrigatorio'),
            FormValidators.minLength(
              2,
              'Nome deve ter pelo menos 2 caracteres',
            ),
          ]),
        ),
        const SizedBox(height: 20),
        FormRowFlex.top(
          items: [
            FormRowItem(
              flex: 2,
              child: TextInputField(
                labelText: 'CPF/CNPJ',
                hintText: '000.000.000-00',
                keyboardType: TextInputType.number,
                validator: FormValidators.combine([
                  FormValidators.required('CPF/CNPJ e obrigatorio'),
                  FormValidators.cpf('Digite um CPF valido'),
                ]),
              ),
            ),
            FormRowItem(
              flex: 1,
              child: SelectInputField<String>(
                labelText: 'Tipo',
                hintText: 'Selecione',
                onChanged: (value) {
                  // Callback para mudança de valor - Tipo selecionado
                },
                options: const [
                  SelectOption(value: 'PF', label: 'Pessoa Fisica'),
                  SelectOption(value: 'PJ', label: 'Pessoa Juridica'),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        FormRow.top(
          children: [
            TextInputField(
              labelText: 'Email',
              hintText: 'cliente@exemplo.com',
              keyboardType: TextInputType.emailAddress,
              validator: FormValidators.email('Digite um email valido'),
            ),
            TextInputField(
              labelText: 'Telefone',
              hintText: '(11) 99999-9999',
              keyboardType: TextInputType.phone,
              validator: FormValidators.telefone('Digite um telefone valido'),
            ),
          ],
        ),
        const SizedBox(height: 20),
        TextInputField(
          labelText: 'Endereco',
          hintText: 'Rua, numero, complemento',
        ),
        const SizedBox(height: 20),
        FormRowFlex.top(
          items: [
            FormRowItem(
              flex: 1,
              child: TextInputField(
                labelText: 'CEP',
                hintText: '00000-000',
                keyboardType: TextInputType.number,
                validator: FormValidators.cep('Digite um CEP valido'),
              ),
            ),
            FormRowItem(
              flex: 2,
              child: TextInputField(
                labelText: 'Cidade',
                hintText: 'Nome da cidade',
              ),
            ),
            FormRowItem(
              flex: 1,
              child: SelectInputField<String>(
                labelText: 'UF',
                hintText: 'SP',
                onChanged: (value) {
                  // Callback para mudança de valor - UF selecionada
                },
                options: const [
                  SelectOption(value: 'SP', label: 'SP'),
                  SelectOption(value: 'RJ', label: 'RJ'),
                  SelectOption(value: 'MG', label: 'MG'),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Formulario de cadastro de fornecedor
  static Widget _buildFormularioFornecedor() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextInputField(
          labelText: 'Razao Social',
          hintText: 'Nome da empresa conforme CNPJ',
          validator: FormValidators.required('Razao social e obrigatoria'),
        ),
        const SizedBox(height: 20),
        FormRow.top(
          children: [
            TextInputField(
              labelText: 'CNPJ',
              hintText: '00.000.000/0000-00',
              keyboardType: TextInputType.number,
              validator: FormValidators.required('CNPJ e obrigatorio'),
            ),
            TextInputField(
              labelText: 'Inscricao Estadual',
              hintText: '000.000.000.000',
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        const SizedBox(height: 20),
        FormRow.top(
          children: [
            TextInputField(
              labelText: 'Email',
              hintText: 'contato@fornecedor.com',
              keyboardType: TextInputType.emailAddress,
              validator: FormValidators.combine([
                FormValidators.required('Email e obrigatorio'),
                FormValidators.email('Digite um email valido'),
              ]),
            ),
            TextInputField(
              labelText: 'Telefone',
              hintText: '(11) 3000-0000',
              keyboardType: TextInputType.phone,
            ),
          ],
        ),
        const SizedBox(height: 20),
        SelectInputField<String>(
          labelText: 'Regime Tributario',
          hintText: 'Selecione o regime',
          onChanged: (value) {
            // Callback para mudança de valor - Regime tributario do fornecedor
          },
          options: const [
            SelectOption(value: 'simples', label: 'Simples Nacional'),
            SelectOption(value: 'presumido', label: 'Lucro Presumido'),
            SelectOption(value: 'real', label: 'Lucro Real'),
            SelectOption(value: 'mei', label: 'MEI'),
          ],
          validator: FormValidators.required('Regime tributario e obrigatorio'),
        ),
        const SizedBox(height: 20),
        TextInputField(
          labelText: 'Observacoes',
          hintText: 'Informacoes adicionais sobre o fornecedor',
        ),
      ],
    );
  }

  // Formulario de configuracoes
  static Widget _buildFormularioConfiguracoes() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextInputField(
          labelText: 'Nome da Empresa',
          hintText: 'Domani Fiscal Ltda',
          validator: FormValidators.required('Nome da empresa e obrigatorio'),
        ),
        const SizedBox(height: 20),
        FormRow.top(
          children: [
            TextInputField(
              labelText: 'Email de Contato',
              hintText: 'contato@empresa.com',
              keyboardType: TextInputType.emailAddress,
              validator: FormValidators.combine([
                FormValidators.required('Email e obrigatorio'),
                FormValidators.email('Digite um email valido'),
              ]),
            ),
            TextInputField(
              labelText: 'Telefone',
              hintText: '(11) 3000-0000',
              keyboardType: TextInputType.phone,
            ),
          ],
        ),
        const SizedBox(height: 20),
        SelectInputField<String>(
          labelText: 'Tema da Aplicacao',
          hintText: 'Selecione o tema',
          onChanged: (value) {
            // Callback para mudança de valor - Tema selecionado
          },
          options: const [
            SelectOption(value: 'light', label: 'Claro'),
            SelectOption(value: 'dark', label: 'Escuro'),
            SelectOption(value: 'auto', label: 'Automatico'),
          ],
        ),
        const SizedBox(height: 20),
        SelectInputField<String>(
          labelText: 'Regime Tributario',
          hintText: 'Selecione o regime',
          onChanged: (value) {
            // Callback para mudança de valor - Regime tributario da empresa
          },
          options: const [
            SelectOption(value: 'simples', label: 'Simples Nacional'),
            SelectOption(value: 'presumido', label: 'Lucro Presumido'),
            SelectOption(value: 'real', label: 'Lucro Real'),
            SelectOption(value: 'mei', label: 'MEI'),
          ],
          validator: FormValidators.required('Regime tributario e obrigatorio'),
        ),
        const SizedBox(height: 20),
        FormRow.top(
          children: [
            TextInputField(
              labelText: 'CNPJ',
              hintText: '00.000.000/0000-00',
              keyboardType: TextInputType.number,
              validator: FormValidators.required('CNPJ e obrigatorio'),
            ),
            TextInputField(
              labelText: 'Inscricao Estadual',
              hintText: '000.000.000.000',
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        const SizedBox(height: 20),
        TextInputField(
          labelText: 'Observacoes',
          hintText: 'Configuracoes adicionais do sistema',
        ),
      ],
    );
  }
}
