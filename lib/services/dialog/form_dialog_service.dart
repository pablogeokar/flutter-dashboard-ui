import 'package:flutter/material.dart';
import '../../widgets/src/dialog/form_dialog.dart';
import '../../widgets/src/forms/form_components.dart';

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
        DomaniTextField(
          label: 'Nome Completo',
          hint: 'Digite o nome completo do cliente',
          prefixIcon: Icons.person_outline_rounded,
          required: true,
          helperText: 'Nome como deve aparecer nos documentos fiscais',
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
              child: DomaniTextField(
                label: 'CPF/CNPJ',
                hint: '000.000.000-00',
                prefixIcon: Icons.badge_outlined,
                required: true,
                keyboardType: TextInputType.number,
                inputFormatters: [FormFormatters.cpf()],
                validator: FormValidators.combine([
                  FormValidators.required('CPF/CNPJ e obrigatorio'),
                  FormValidators.cpf('Digite um CPF valido'),
                ]),
              ),
            ),
            FormRowItem(
              flex: 1,
              child: DomaniDropdown<String>(
                label: 'Tipo',
                hint: 'Selecione',
                required: true,
                onChanged: (value) {
                  // Callback para mudança de valor - Tipo selecionado
                },
                items: const [
                  DropdownMenuItem(value: 'PF', child: Text('Pessoa Fisica')),
                  DropdownMenuItem(value: 'PJ', child: Text('Pessoa Juridica')),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        FormRow.top(
          children: [
            DomaniTextField(
              label: 'Email',
              hint: 'cliente@exemplo.com',
              prefixIcon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
              helperText: 'Para envio de documentos fiscais',
              validator: FormValidators.email('Digite um email valido'),
            ),
            DomaniTextField(
              label: 'Telefone',
              hint: '(11) 99999-9999',
              prefixIcon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
              helperText: 'Contato principal do cliente',
              inputFormatters: [FormFormatters.telefone()],
              validator: FormValidators.telefone('Digite um telefone valido'),
            ),
          ],
        ),
        const SizedBox(height: 20),
        DomaniTextField(
          label: 'Endereco',
          hint: 'Rua, numero, complemento',
          prefixIcon: Icons.location_on_outlined,
          helperText: 'Endereco para entrega e cobranca',
        ),
        const SizedBox(height: 20),
        FormRowFlex.top(
          items: [
            FormRowItem(
              flex: 1,
              child: DomaniTextField(
                label: 'CEP',
                hint: '00000-000',
                keyboardType: TextInputType.number,
                inputFormatters: [FormFormatters.cep()],
                validator: FormValidators.cep('Digite um CEP valido'),
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
                onChanged: (value) {
                  // Callback para mudança de valor - UF selecionada
                },
                items: const [
                  DropdownMenuItem(value: 'SP', child: Text('SP')),
                  DropdownMenuItem(value: 'RJ', child: Text('RJ')),
                  DropdownMenuItem(value: 'MG', child: Text('MG')),
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
        DomaniTextField(
          label: 'Razao Social',
          hint: 'Nome da empresa conforme CNPJ',
          prefixIcon: Icons.business_outlined,
          required: true,
          helperText: 'Nome oficial da empresa para documentos fiscais',
        ),
        const SizedBox(height: 20),
        FormRow.top(
          children: [
            DomaniTextField(
              label: 'CNPJ',
              hint: '00.000.000/0000-00',
              prefixIcon: Icons.badge_outlined,
              required: true,
              keyboardType: TextInputType.number,
              helperText: 'Documento principal da empresa',
            ),
            DomaniTextField(
              label: 'Inscricao Estadual',
              hint: '000.000.000.000',
              keyboardType: TextInputType.number,
              helperText: 'Deixe em branco se isento',
            ),
          ],
        ),
        const SizedBox(height: 20),
        FormRow.top(
          children: [
            DomaniTextField(
              label: 'Email',
              hint: 'contato@fornecedor.com',
              prefixIcon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
              required: true,
            ),
            DomaniTextField(
              label: 'Telefone',
              hint: '(11) 3000-0000',
              prefixIcon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
            ),
          ],
        ),
        const SizedBox(height: 20),
        DomaniDropdown<String>(
          label: 'Regime Tributario',
          hint: 'Selecione o regime',
          prefixIcon: Icons.gavel_outlined,
          required: true,
          onChanged: (value) {
            // Callback para mudança de valor - Regime tributario do fornecedor
          },
          items: const [
            DropdownMenuItem(value: 'simples', child: Text('Simples Nacional')),
            DropdownMenuItem(
              value: 'presumido',
              child: Text('Lucro Presumido'),
            ),
            DropdownMenuItem(value: 'real', child: Text('Lucro Real')),
            DropdownMenuItem(value: 'mei', child: Text('MEI')),
          ],
          helperText: 'Regime tributario do fornecedor para calculos fiscais',
        ),
        const SizedBox(height: 20),
        DomaniTextField(
          label: 'Observacoes',
          hint: 'Informacoes adicionais sobre o fornecedor',
          maxLines: 3,
          helperText: 'Condicoes de pagamento, prazos de entrega, etc.',
        ),
      ],
    );
  }

  // Formulario de configuracoes
  static Widget _buildFormularioConfiguracoes() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DomaniTextField(
          label: 'Nome da Empresa',
          hint: 'Domani Fiscal Ltda',
          prefixIcon: Icons.business_center_outlined,
          required: true,
          helperText: 'Nome que aparecera nos relatorios e documentos',
        ),
        const SizedBox(height: 20),
        FormRow.top(
          children: [
            DomaniTextField(
              label: 'Email de Contato',
              hint: 'contato@empresa.com',
              prefixIcon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
              required: true,
            ),
            DomaniTextField(
              label: 'Telefone',
              hint: '(11) 3000-0000',
              prefixIcon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
            ),
          ],
        ),
        const SizedBox(height: 20),
        DomaniDropdown<String>(
          label: 'Tema da Aplicacao',
          hint: 'Selecione o tema',
          prefixIcon: Icons.palette_outlined,
          onChanged: (value) {
            // Callback para mudança de valor - Tema selecionado
          },
          items: const [
            DropdownMenuItem(value: 'light', child: Text('Claro')),
            DropdownMenuItem(value: 'dark', child: Text('Escuro')),
            DropdownMenuItem(value: 'auto', child: Text('Automatico')),
          ],
          helperText: 'Tema visual da interface do sistema',
        ),
        const SizedBox(height: 20),
        DomaniDropdown<String>(
          label: 'Regime Tributario',
          hint: 'Selecione o regime',
          prefixIcon: Icons.gavel_outlined,
          required: true,
          onChanged: (value) {
            // Callback para mudança de valor - Regime tributario da empresa
          },
          items: const [
            DropdownMenuItem(value: 'simples', child: Text('Simples Nacional')),
            DropdownMenuItem(
              value: 'presumido',
              child: Text('Lucro Presumido'),
            ),
            DropdownMenuItem(value: 'real', child: Text('Lucro Real')),
            DropdownMenuItem(value: 'mei', child: Text('MEI')),
          ],
          helperText: 'Regime tributario da empresa para calculos automaticos',
        ),
        const SizedBox(height: 20),
        FormRow.top(
          children: [
            DomaniTextField(
              label: 'CNPJ',
              hint: '00.000.000/0000-00',
              prefixIcon: Icons.badge_outlined,
              keyboardType: TextInputType.number,
              required: true,
              helperText: 'CNPJ da empresa configurada',
            ),
            DomaniTextField(
              label: 'Inscricao Estadual',
              hint: '000.000.000.000',
              keyboardType: TextInputType.number,
              helperText: 'Deixe em branco se isento',
            ),
          ],
        ),
        const SizedBox(height: 20),
        DomaniTextField(
          label: 'Observacoes',
          hint: 'Configuracoes adicionais do sistema',
          maxLines: 3,
          helperText: 'Informacoes gerais sobre a configuracao da empresa',
        ),
      ],
    );
  }
}
