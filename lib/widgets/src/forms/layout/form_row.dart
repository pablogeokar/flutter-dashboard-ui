import 'package:flutter/material.dart';

// ═══════════════════════════════════════════════════════════════════════════════════════════════
// FORM ROW WIDGETS - SISTEMA DE ALINHAMENTO PARA FORMULÁRIOS
// ═══════════════════════════════════════════════════════════════════════════════════════════════
//
// Este arquivo contém widgets especializados para criar linhas de formulário com alinhamento
// perfeito, resolvendo problemas comuns de desalinhamento quando campos têm alturas diferentes.
//
// WIDGETS PRINCIPAIS:
// • FormRow - Alinhamento automático com distribuição igual
// • FormRowFlex - Alinhamento com controle de proporções customizadas
// • FormRowItem - Item para uso no FormRowFlex
// • FormRowExtensions - Extensões de conveniência
//
// CASOS DE USO:
// • Campos de formulário com helperText diferentes
// • Campos com validação que alteram altura
// • Dropdowns e TextFields na mesma linha
// • Layouts responsivos de formulário
//
// EXEMPLO BÁSICO:
// ```dart
// FormRow.top(
//   children: [
//     DomaniTextField(label: 'Nome', helperText: 'Nome completo'),
//     DomaniTextField(label: 'Sobrenome'), // Alinha automaticamente
//   ],
// )
// ```
//
// EXEMPLO AVANÇADO:
// ```dart
// FormRowFlex.top(
//   items: [
//     FormRowItem(flex: 2, child: DomaniTextField(label: 'Endereço')),
//     FormRowItem(flex: 1, child: DomaniTextField(label: 'Número')),
//   ],
// )
// ```
// ═══════════════════════════════════════════════════════════════════════════════════════════════

/// **FormRow** - Widget para criar linhas de formulário com alinhamento consistente
///
/// ## Propósito
/// Resolve problemas de desalinhamento quando campos têm alturas diferentes devido a:
/// - `helperText` de tamanhos variados
/// - Mensagens de validação
/// - Diferentes tipos de campos (TextField, Dropdown, etc.)
///
/// ## Características
/// - **Alinhamento automático**: Usa `IntrinsicHeight` para igualar alturas
/// - **Distribuição igual**: Todos os campos ocupam espaço igual
/// - **Espaçamento consistente**: 16px padrão entre campos
/// - **Flexibilidade**: Suporta diferentes tipos de alinhamento
///
/// ## Construtores Disponíveis
/// - `FormRow.top()` - Alinha campos no topo (padrão para formulários)
/// - `FormRow.center()` - Alinha campos no centro
/// - `FormRow.bottom()` - Alinha campos na base
///
/// ## Exemplo de Uso
/// ```dart
/// FormRow.top(
///   spacing: 20.0, // Espaçamento customizado
///   children: [
///     DomaniTextField(
///       label: 'Email',
///       helperText: 'Para envio de documentos fiscais',
///     ),
///     DomaniTextField(
///       label: 'Telefone',
///       // Sem helperText - alinha automaticamente com Email
///     ),
///   ],
/// )
/// ```
///
/// ## Quando Usar
/// - ✅ Campos com distribuição igual (50/50, 33/33/33, etc.)
/// - ✅ Formulários simples sem necessidade de proporções específicas
/// - ✅ Quando todos os campos têm importância similar
///
/// ## Quando NÃO Usar
/// - ❌ Quando precisa de proporções específicas (use `FormRowFlex`)
/// - ❌ Para layouts complexos com mais de 4 campos
/// - ❌ Quando campos têm tamanhos muito diferentes por natureza
class FormRow extends StatelessWidget {
  /// Lista de widgets (campos) a serem exibidos na linha
  final List<Widget> children;

  /// Espaçamento entre os campos
  final double spacing;

  /// Alinhamento vertical dos campos na linha
  final CrossAxisAlignment crossAxisAlignment;

  /// Alinhamento principal (horizontal) dos campos
  final MainAxisAlignment mainAxisAlignment;

  const FormRow({
    super.key,
    required this.children,
    this.spacing = 16.0,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.mainAxisAlignment = MainAxisAlignment.start,
  });

  /// Construtor para alinhamento no topo (padrão para formulários)
  const FormRow.top({
    super.key,
    required this.children,
    this.spacing = 16.0,
    this.mainAxisAlignment = MainAxisAlignment.start,
  }) : crossAxisAlignment = CrossAxisAlignment.start;

  /// Construtor para alinhamento no centro
  const FormRow.center({
    super.key,
    required this.children,
    this.spacing = 16.0,
    this.mainAxisAlignment = MainAxisAlignment.start,
  }) : crossAxisAlignment = CrossAxisAlignment.center;

  /// Construtor para alinhamento no bottom
  const FormRow.bottom({
    super.key,
    required this.children,
    this.spacing = 16.0,
    this.mainAxisAlignment = MainAxisAlignment.start,
  }) : crossAxisAlignment = CrossAxisAlignment.end;

  @override
  Widget build(BuildContext context) {
    if (children.isEmpty) {
      return const SizedBox.shrink();
    }

    // Se há apenas um campo, retorna sem Row
    if (children.length == 1) {
      return children.first;
    }

    // Cria lista de widgets com espaçamento entre eles
    final List<Widget> spacedChildren = [];

    for (int i = 0; i < children.length; i++) {
      // Envolve cada campo em Expanded para distribuição igual
      spacedChildren.add(Expanded(child: children[i]));

      // Adiciona espaçamento entre campos (exceto no último)
      if (i < children.length - 1) {
        spacedChildren.add(SizedBox(width: spacing));
      }
    }

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: crossAxisAlignment,
        mainAxisAlignment: mainAxisAlignment,
        children: spacedChildren,
      ),
    );
  }
}

/// **FormRowFlex** - Widget para linhas de formulário com controle de proporções
///
/// ## Propósito
/// Versão avançada do `FormRow` que permite definir proporções específicas para cada campo,
/// ideal quando diferentes campos precisam de tamanhos diferentes.
///
/// ## Características
/// - **Proporções customizáveis**: Cada campo pode ter flex value diferente
/// - **Alinhamento perfeito**: Mesmo `IntrinsicHeight` do FormRow
/// - **Flexibilidade total**: Controle granular sobre o layout
/// - **Reutilizável**: Padrões podem ser salvos e reutilizados
///
/// ## Construtores Disponíveis
/// - `FormRowFlex.top()` - Alinha campos no topo
/// - `FormRowFlex.center()` - Alinha campos no centro
/// - `FormRowFlex.bottom()` - Alinha campos na base
///
/// ## Exemplo de Uso
/// ```dart
/// FormRowFlex.top(
///   spacing: 16.0,
///   items: [
///     FormRowItem(
///       flex: 2, // 66% do espaço
///       child: DomaniTextField(label: 'Endereço Completo'),
///     ),
///     FormRowItem(
///       flex: 1, // 33% do espaço
///       child: DomaniTextField(label: 'Número'),
///     ),
///   ],
/// )
/// ```
///
/// ## Padrões Comuns de Flex
/// - **2:1** - Campo principal + campo secundário (ex: Endereço + Número)
/// - **1:1:1** - Três campos iguais (ex: CEP + Cidade + UF)
/// - **3:2:1** - Degradê de importância (ex: Nome + Sobrenome + Inicial)
/// - **1:2** - Campo pequeno + campo grande (ex: Código + Descrição)
///
/// ## Quando Usar
/// - ✅ Campos com importâncias/tamanhos diferentes
/// - ✅ Layouts específicos de formulário
/// - ✅ Quando precisa de controle fino sobre proporções
/// - ✅ Formulários complexos com muitos campos
///
/// ## Quando NÃO Usar
/// - ❌ Quando todos os campos têm mesma importância (use `FormRow`)
/// - ❌ Para layouts simples sem necessidade de proporções
/// - ❌ Quando a simplicidade é mais importante que o controle
class FormRowFlex extends StatelessWidget {
  /// Lista de campos com seus respectivos flex values
  final List<FormRowItem> items;

  /// Espaçamento entre os campos
  final double spacing;

  /// Alinhamento vertical dos campos na linha
  final CrossAxisAlignment crossAxisAlignment;

  /// Alinhamento principal (horizontal) dos campos
  final MainAxisAlignment mainAxisAlignment;

  const FormRowFlex({
    super.key,
    required this.items,
    this.spacing = 16.0,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.mainAxisAlignment = MainAxisAlignment.start,
  });

  /// Construtor para alinhamento no topo
  const FormRowFlex.top({
    super.key,
    required this.items,
    this.spacing = 16.0,
    this.mainAxisAlignment = MainAxisAlignment.start,
  }) : crossAxisAlignment = CrossAxisAlignment.start;

  /// Construtor para alinhamento no centro
  const FormRowFlex.center({
    super.key,
    required this.items,
    this.spacing = 16.0,
    this.mainAxisAlignment = MainAxisAlignment.start,
  }) : crossAxisAlignment = CrossAxisAlignment.center;

  /// Construtor para alinhamento no bottom
  const FormRowFlex.bottom({
    super.key,
    required this.items,
    this.spacing = 16.0,
    this.mainAxisAlignment = MainAxisAlignment.start,
  }) : crossAxisAlignment = CrossAxisAlignment.end;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const SizedBox.shrink();
    }

    // Se há apenas um item, retorna sem Row
    if (items.length == 1) {
      return items.first.child;
    }

    // Cria lista de widgets com espaçamento entre eles
    final List<Widget> spacedChildren = [];

    for (int i = 0; i < items.length; i++) {
      final item = items[i];

      // Envolve cada campo em Expanded com flex personalizado
      spacedChildren.add(Expanded(flex: item.flex, child: item.child));

      // Adiciona espaçamento entre campos (exceto no último)
      if (i < items.length - 1) {
        spacedChildren.add(SizedBox(width: spacing));
      }
    }

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: crossAxisAlignment,
        mainAxisAlignment: mainAxisAlignment,
        children: spacedChildren,
      ),
    );
  }
}

/// **FormRowItem** - Item individual para uso no FormRowFlex
///
/// ## Propósito
/// Encapsula um widget de formulário com seu valor de flex, permitindo controle
/// granular sobre as proporções de cada campo na linha.
///
/// ## Parâmetros
/// - `child` - Widget do campo de formulário
/// - `flex` - Proporção do campo na linha (padrão: 1)
///
/// ## Exemplos de Flex Values
/// ```dart
/// // Proporção 2:1 (campo maior : campo menor)
/// FormRowItem(flex: 2, child: DomaniTextField(label: 'Endereço')),
/// FormRowItem(flex: 1, child: DomaniTextField(label: 'Número')),
///
/// // Proporção 3:2:1 (degradê de tamanhos)
/// FormRowItem(flex: 3, child: DomaniTextField(label: 'Nome Completo')),
/// FormRowItem(flex: 2, child: DomaniTextField(label: 'Sobrenome')),
/// FormRowItem(flex: 1, child: DomaniTextField(label: 'Inicial')),
/// ```
///
/// ## Cálculo de Proporções
/// O espaço é distribuído proporcionalmente aos valores de flex:
/// - Total flex = soma de todos os flex values
/// - Porcentagem de cada campo = (flex do campo / total flex) * 100%
///
/// Exemplo: flex [2, 1] = total 3
/// - Campo 1: (2/3) * 100% = 66.7%
/// - Campo 2: (1/3) * 100% = 33.3%
class FormRowItem {
  /// Widget do campo de formulário
  final Widget child;

  /// Proporção do campo na linha
  ///
  /// Valores comuns:
  /// - `1` - Tamanho padrão
  /// - `2` - Duas vezes maior que flex 1
  /// - `3` - Três vezes maior que flex 1
  final int flex;

  /// Cria um item para FormRowFlex
  ///
  /// [child] é obrigatório e deve ser um widget de formulário
  /// [flex] define a proporção (padrão: 1)
  const FormRowItem({required this.child, this.flex = 1});
}

// ═══════════════════════════════════════════════════════════════════════════════════════════════
// EXTENSÕES DE CONVENIÊNCIA
// ═══════════════════════════════════════════════════════════════════════════════════════════════

/// **FormRowExtensions** - Extensões para criar FormRows de forma mais concisa
///
/// ## Propósito
/// Permite converter listas de widgets em FormRows usando sintaxe fluente,
/// tornando o código mais legível e conciso.
///
/// ## Exemplos de Uso
/// ```dart
/// // Sintaxe tradicional
/// FormRow.top(
///   children: [
///     DomaniTextField(label: 'Nome'),
///     DomaniTextField(label: 'Sobrenome'),
///   ],
/// )
///
/// // Sintaxe com extensão (mais concisa)
/// [
///   DomaniTextField(label: 'Nome'),
///   DomaniTextField(label: 'Sobrenome'),
/// ].toFormRow()
/// ```
///
/// ## Métodos Disponíveis
/// - `toFormRow()` - Cria FormRow com alinhamento no topo
/// - `toFormRowCenter()` - Cria FormRow com alinhamento no centro
/// - `toFormRowBottom()` - Cria FormRow com alinhamento na base
///
/// ## Quando Usar
/// - ✅ Para código mais conciso e legível
/// - ✅ Quando já tem uma lista de widgets
/// - ✅ Em builders ou métodos que retornam listas
///
/// ## Quando NÃO Usar
/// - ❌ Quando precisa de FormRowFlex (proporções customizadas)
/// - ❌ Em código que prioriza clareza sobre concisão
/// - ❌ Quando parâmetros customizados são complexos
extension FormRowExtensions on List<Widget> {
  /// Converte lista de widgets em FormRow com alinhamento no topo
  ///
  /// ## Parâmetros
  /// - [spacing] - Espaçamento entre campos (padrão: 16.0)
  /// - [mainAxisAlignment] - Alinhamento horizontal (padrão: start)
  ///
  /// ## Exemplo
  /// ```dart
  /// [
  ///   DomaniTextField(label: 'Email'),
  ///   DomaniTextField(label: 'Telefone'),
  /// ].toFormRow(spacing: 20.0)
  /// ```
  FormRow toFormRow({
    double spacing = 16.0,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
  }) {
    return FormRow.top(
      spacing: spacing,
      mainAxisAlignment: mainAxisAlignment,
      children: this,
    );
  }

  /// Converte lista de widgets em FormRow com alinhamento no centro
  ///
  /// Útil quando campos têm alturas muito diferentes e o alinhamento
  /// central fica mais harmonioso visualmente.
  ///
  /// ## Exemplo
  /// ```dart
  /// [
  ///   DomaniTextField(label: 'Campo Alto'),
  ///   IconButton(onPressed: () {}, icon: Icon(Icons.add)),
  /// ].toFormRowCenter()
  /// ```
  FormRow toFormRowCenter({
    double spacing = 16.0,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
  }) {
    return FormRow.center(
      spacing: spacing,
      mainAxisAlignment: mainAxisAlignment,
      children: this,
    );
  }

  /// Converte lista de widgets em FormRow com alinhamento na base
  ///
  /// Útil quando quer alinhar campos pela linha de base do texto,
  /// especialmente com campos que têm labels em posições diferentes.
  ///
  /// ## Exemplo
  /// ```dart
  /// [
  ///   DomaniTextField(label: 'Campo com Label'),
  ///   ElevatedButton(onPressed: () {}, child: Text('Botão')),
  /// ].toFormRowBottom()
  /// ```
  FormRow toFormRowBottom({
    double spacing = 16.0,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
  }) {
    return FormRow.bottom(
      spacing: spacing,
      mainAxisAlignment: mainAxisAlignment,
      children: this,
    );
  }
}
