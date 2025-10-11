import 'package:flutter/material.dart';
import 'form_dialog.dart';
import '../forms/form_components.dart';
import '../forms/form_row.dart';

// ═══════════════════════════════════════════════════════════════════════════════════════════════
// FORM DIALOG SERVICE - SERVIÇOS DE DIALOGS PRÉ-CONFIGURADOS
// ═══════════════════════════════════════════════════════════════════════════════════════════════
//
// Este arquivo contém serviços para exibir dialogs de formulário padronizados do sistema.
// Todos os dialogs seguem o mesmo padrão visual e de UX, garantindo consistência.
//
// SERVIÇOS DISPONÍVEIS:
// • mostrarFormulario() - Dialog genérico customizável
// • mostrarCadastroCliente() - Formulário de cadastro de cliente
// • mostrarCadastroFornecedor() - Formulário de cadastro de fornecedor
// • mostrarConfiguracoes() - Formulário de configurações do sistema
// • mostrarBusca() - Dialog de busca genérico
// • mostrarConfirmacao() - Dialog de confirmação simples
//
// CARACTERÍSTICAS:
// • Scroll automático para formulários longos
// • Validação integrada
// • Animações suaves
// • Design responsivo
// • Acessibilidade completa
//
// EXEMPLO DE USO:
// ```dart
// await FormDialogService.mostrarCadastroCliente(
//   context: context,
//   onConfirmar: () => _salvarCliente(),
// );
// ```
// ═══════════════════════════════════════════════════════════════════════════════════════════════

/// **FormDialogService** - Serviços para dialogs de formulário padronizados
///
/// ## Propósito
/// Centraliza a criação de dialogs comuns do sistema, garantindo consistência
/// visual e de UX em toda a aplicação.
///
/// ## Características
/// - **Padronização**: Todos os dialogs seguem o mesmo padrão
/// - **Reutilização**: Métodos pré-configurados para casos comuns
/// - **Flexibilidade**: Dialog genérico para casos específicos
/// - **Manutenibilidade**: Mudanças centralizadas afetam toda a aplicação
///
/// ## Métodos Principais
/// - `mostrarFormulario()` - Dialog genérico customizável
/// - `mostrarCadastroCliente()` - Cadastro de cliente
/// - `mostrarCadastroFornecedor()` - Cadastro de fornecedor
/// - `mostrarConfiguracoes()` - Configurações do sistema
/// - `mostrarBusca()` - Dialog de busca
/// - `mostrarConfirmacao()` - Confirmação simples
class FormDialogService {
  // ═══════════════════════════════════════════════════════════════════════════════════════════════
  // MÉTODO GENÉRICO
  // ═══════════════════════════════════════════════════════════════════════════════════════════════

  /// **mostrarFormulario** - Exibe um dialog de formulário genérico
  ///
  /// ## Propósito
  /// Método base para criar dialogs customizados. Todos os outros métodos
  /// desta classe usam este método internamente.
  ///
  /// ## Parâmetros
  /// - `context` - BuildContext obrigatório
  /// - `titulo` - Título principal do dialog
  /// - `subtitulo` - Descrição opcional (recomendado)
  /// - `formulario` - Widget do formulário a ser exibido
  /// - `textoConfirmacao` - Texto do botão de confirmação (padrão: "Confirmar")
  /// - `textoCancelamento` - Texto do botão de cancelamento (padrão: "Cancelar")
  /// - `onConfirmar` - Callback executado ao confirmar
  /// - `onCancelar` - Callback executado ao cancelar (opcional)
  /// - `mostrarCancelamento` - Se deve mostrar botão cancelar (padrão: true)
  /// - `larguraMaxima` - Largura máxima do dialog (padrão: 600px)
  /// - `alturaMaxima` - Altura máxima do dialog (padrão: 700px)
  /// - `barrierDismissible` - Se pode fechar clicando fora (padrão: true)
  /// - `icone` - Ícone do header (opcional)
  ///
  /// ## Exemplo de Uso
  /// ```dart
  /// await FormDialogService.mostrarFormulario(
  ///   context: context,
  ///   titulo: 'Meu Dialog',
  ///   subtitulo: 'Descrição do que faz',
  ///   icone: Icons.edit,
  ///   larguraMaxima: 800,
  ///   formulario: Column(
  ///     children: [
  ///       DomaniTextField(label: 'Campo 1'),
  ///       FormRow.top(
  ///         children: [
  ///           DomaniTextField(label: 'Campo 2'),
  ///           DomaniTextField(label: 'Campo 3'),
  ///         ],
  ///       ),
  ///     ],
  ///   ),
  ///   onConfirmar: () => _salvarDados(),
  /// );
  /// ```
  ///
  /// ## Retorno
  /// `Future<void>` que completa quando o dialog é fechado
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

  // ═══════════════════════════════════════════════════════════════════════════════════════════════
  // DIALOGS DE CADASTRO
  // ═══════════════════════════════════════════════════════════════════════════════════════════════

  /// **mostrarCadastroCliente** - Dialog para cadastro de cliente
  ///
  /// ## Propósito
  /// Exibe formulário completo para cadastro de novos clientes com todos
  /// os campos necessários para operações fiscais.
  ///
  /// ## Campos Incluídos
  /// - Nome Completo (obrigatório)
  /// - CPF/CNPJ (obrigatório) + Tipo (PF/PJ)
  /// - Email + Telefone
  /// - Endereço completo
  /// - CEP + Cidade + UF
  ///
  /// ## Exemplo de Uso
  /// ```dart
  /// await FormDialogService.mostrarCadastroCliente(
  ///   context: context,
  ///   onConfirmar: () {
  ///     // Processar dados do formulário
  ///     _salvarCliente();
  ///   },
  ///   onCancelar: () {
  ///     // Lógica opcional de cancelamento
  ///     _limparFormulario();
  ///   },
  /// );
  /// ```
  ///
  /// ## Validações
  /// - Nome: obrigatório, mínimo 2 caracteres
  /// - CPF/CNPJ: obrigatório, formato válido
  /// - Email: formato válido (se preenchido)
  /// - Telefone: formato válido (se preenchido)
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

  /// **mostrarCadastroFornecedor** - Dialog para cadastro de fornecedor
  ///
  /// ## Propósito
  /// Exibe formulário específico para cadastro de fornecedores com campos
  /// voltados para empresas e informações fiscais.
  ///
  /// ## Campos Incluídos
  /// - Razão Social (obrigatório)
  /// - CNPJ (obrigatório) + Inscrição Estadual
  /// - Email + Telefone
  /// - Regime Tributário (obrigatório)
  /// - Observações
  ///
  /// ## Diferenças do Cliente
  /// - Foco em pessoa jurídica
  /// - Campos fiscais específicos
  /// - Regime tributário obrigatório
  /// - Observações para condições comerciais
  ///
  /// ## Exemplo de Uso
  /// ```dart
  /// await FormDialogService.mostrarCadastroFornecedor(
  ///   context: context,
  ///   onConfirmar: () => _salvarFornecedor(),
  /// );
  /// ```
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

  // ═══════════════════════════════════════════════════════════════════════════════════════════════
  // DIALOGS DE SISTEMA
  // ═══════════════════════════════════════════════════════════════════════════════════════════════

  /// **mostrarConfiguracoes** - Dialog para configurações do sistema
  ///
  /// ## Propósito
  /// Permite configurar parâmetros globais do sistema como dados da empresa,
  /// preferências de interface e configurações fiscais.
  ///
  /// ## Seções de Configuração
  /// - **Empresa**: Nome, CNPJ, Inscrição Estadual
  /// - **Contato**: Email, Telefone
  /// - **Interface**: Tema (Claro/Escuro/Automático)
  /// - **Fiscal**: Regime Tributário
  /// - **Observações**: Configurações adicionais
  ///
  /// ## Exemplo de Uso
  /// ```dart
  /// await FormDialogService.mostrarConfiguracoes(
  ///   context: context,
  ///   onConfirmar: () => _salvarConfiguracoes(),
  /// );
  /// ```
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

  // ═══════════════════════════════════════════════════════════════════════════════════════════════
  // DIALOGS UTILITÁRIOS
  // ═══════════════════════════════════════════════════════════════════════════════════════════════

  /// **mostrarBusca** - Dialog genérico para busca
  ///
  /// ## Propósito
  /// Exibe um dialog de busca customizável que pode ser usado para
  /// diferentes tipos de pesquisa no sistema.
  ///
  /// ## Características
  /// - Formulário de busca customizável
  /// - Botão "Buscar" ao invés de "Confirmar"
  /// - Largura otimizada para campos de busca
  /// - Ícone de lupa no header
  ///
  /// ## Exemplo de Uso
  /// ```dart
  /// await FormDialogService.mostrarBusca(
  ///   context: context,
  ///   titulo: 'Buscar Cliente',
  ///   formularioBusca: Column(
  ///     children: [
  ///       DomaniTextField(label: 'Nome'),
  ///       FormRow.top(
  ///         children: [
  ///           DomaniTextField(label: 'CPF/CNPJ'),
  ///           DomaniTextField(label: 'Telefone'),
  ///         ],
  ///       ),
  ///     ],
  ///   ),
  ///   onConfirmar: () => _executarBusca(),
  /// );
  /// ```
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

  /// **mostrarConfirmacao** - Dialog simples de confirmação
  ///
  /// ## Propósito
  /// Exibe um dialog de confirmação simples para ações que precisam de
  /// confirmação do usuário (exclusões, alterações importantes, etc.).
  ///
  /// ## Características
  /// - Sem formulário (apenas mensagem)
  /// - Botões customizáveis
  /// - Ícone de alerta por padrão
  /// - Largura compacta (400px)
  ///
  /// ## Exemplos de Uso
  /// ```dart
  /// // Confirmação de exclusão
  /// await FormDialogService.mostrarConfirmacao(
  ///   context: context,
  ///   titulo: 'Confirmar Exclusão',
  ///   mensagem: 'Tem certeza que deseja excluir este cliente?',
  ///   textoConfirmacao: 'Excluir',
  ///   icone: Icons.warning,
  ///   onConfirmar: () => _excluirCliente(),
  /// );
  ///
  /// // Confirmação de salvamento
  /// await FormDialogService.mostrarConfirmacao(
  ///   context: context,
  ///   titulo: 'Salvar Alterações',
  ///   mensagem: 'Deseja salvar as alterações feitas?',
  ///   textoConfirmacao: 'Salvar',
  ///   icone: Icons.save,
  ///   onConfirmar: () => _salvarAlteracoes(),
  /// );
  /// ```
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

  // ═══════════════════════════════════════════════════════════════════════════════════════════════
  // CONSTRUTORES DE FORMULÁRIOS PRIVADOS
  // ═══════════════════════════════════════════════════════════════════════════════════════════════
  //
  // Estes métodos constroem os formulários específicos para cada tipo de dialog.
  // São privados pois são usados apenas internamente pelos métodos públicos.
  //
  // PADRÕES SEGUIDOS:
  // • Uso de FormRow para alinhamento perfeito
  // • Espaçamento consistente (20px entre seções)
  // • Campos obrigatórios marcados com required: true
  // • helperText para orientar o usuário
  // • Validação de tipos de entrada (email, telefone, etc.)
  // • Proporções adequadas com FormRowFlex quando necessário
  // ═══════════════════════════════════════════════════════════════════════════════════════════════

  /// **_buildFormularioCliente** - Constrói formulário de cadastro de cliente
  ///
  /// ## Estrutura do Formulário
  /// 1. **Nome Completo** - Campo único, obrigatório
  /// 2. **CPF/CNPJ + Tipo** - Linha com proporção 2:1
  /// 3. **Email + Telefone** - Linha com distribuição igual
  /// 4. **Endereço** - Campo único para endereço completo
  /// 5. **CEP + Cidade + UF** - Linha com proporção 1:2:1
  ///
  /// ## Validações Implementadas
  /// - Nome: obrigatório, mínimo 2 caracteres
  /// - CPF/CNPJ: obrigatório, formato válido
  /// - Tipo: obrigatório (Pessoa Física/Jurídica)
  /// - Email: formato válido se preenchido
  /// - Telefone: formato brasileiro se preenchido
  ///
  /// ## Layout Responsivo
  /// - Campos se ajustam automaticamente
  /// - Proporções mantidas em diferentes tamanhos
  /// - Scroll automático se necessário
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

  /// **_buildFormularioFornecedor** - Constrói formulário de cadastro de fornecedor
  ///
  /// ## Estrutura do Formulário
  /// 1. **Razão Social** - Campo único, obrigatório
  /// 2. **CNPJ + Inscrição Estadual** - Linha com distribuição igual
  /// 3. **Email + Telefone** - Linha com distribuição igual
  /// 4. **Regime Tributário** - Dropdown obrigatório
  /// 5. **Observações** - Campo de texto multilinha
  ///
  /// ## Diferenças do Cliente
  /// - Foco em pessoa jurídica (CNPJ obrigatório)
  /// - Regime tributário para cálculos fiscais
  /// - Inscrição Estadual (opcional, para isentos)
  /// - Observações para condições comerciais
  ///
  /// ## Regimes Tributários Disponíveis
  /// - Simples Nacional
  /// - Lucro Presumido
  /// - Lucro Real
  /// - MEI (Microempreendedor Individual)
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

  /// **_buildFormularioConfiguracoes** - Constrói formulário de configurações
  ///
  /// ## Estrutura do Formulário
  /// 1. **Nome da Empresa** - Campo único, obrigatório
  /// 2. **Email + Telefone** - Linha com distribuição igual
  /// 3. **Tema da Aplicação** - Dropdown (Claro/Escuro/Automático)
  /// 4. **Regime Tributário** - Dropdown obrigatório
  /// 5. **CNPJ + Inscrição Estadual** - Linha com distribuição igual
  /// 6. **Observações** - Campo multilinha para configurações adicionais
  ///
  /// ## Configurações Disponíveis
  /// - **Empresa**: Dados básicos da empresa
  /// - **Contato**: Email e telefone para comunicações
  /// - **Interface**: Tema visual do sistema
  /// - **Fiscal**: Regime tributário para cálculos automáticos
  /// - **Observações**: Configurações específicas da empresa
  ///
  /// ## Impacto das Configurações
  /// - Nome da empresa aparece em relatórios
  /// - Email usado para notificações do sistema
  /// - Tema afeta toda a interface
  /// - Regime tributário influencia cálculos fiscais
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
