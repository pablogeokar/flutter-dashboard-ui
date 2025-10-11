import 'package:flutter/material.dart';

/// Widget para criar linhas de formulário com alinhamento consistente
///
/// Resolve problemas de desalinhamento quando campos têm alturas diferentes
/// devido a helperText, validação, etc.
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

/// Widget para criar linhas de formulário com controle de flex personalizado
///
/// Permite definir diferentes proporções para cada campo
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

/// Item para uso no FormRowFlex
class FormRowItem {
  /// Widget do campo
  final Widget child;

  /// Proporção do campo na linha (flex value)
  final int flex;

  const FormRowItem({required this.child, this.flex = 1});
}

/// Extensões de conveniência para criar FormRows rapidamente
extension FormRowExtensions on List<Widget> {
  /// Converte lista de widgets em FormRow com alinhamento no topo
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

  /// Converte lista de widgets em FormRow com alinhamento no bottom
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
