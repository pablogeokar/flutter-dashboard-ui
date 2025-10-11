import 'package:flutter/services.dart';

// ═══════════════════════════════════════════════════════════════════════════════════════════════
// SISTEMA DE VALIDAÇÃO E FORMATAÇÃO PARA FORMULÁRIOS
// ═══════════════════════════════════════════════════════════════════════════════════════════════
//
// Este arquivo contém validadores e formatadores inteligentes para campos de formulário,
// garantindo consistência e qualidade dos dados inseridos.
//
// VALIDADORES DISPONÍVEIS:
// • FormValidators.required() - Campo obrigatório
// • FormValidators.email() - Email válido
// • FormValidators.cpf() - CPF válido
// • FormValidators.cnpj() - CNPJ válido
// • FormValidators.telefone() - Telefone brasileiro
// • FormValidators.cep() - CEP brasileiro
//
// FORMATADORES DISPONÍVEIS:
// • FormFormatters.cpf() - Formata CPF (000.000.000-00)
// • FormFormatters.cnpj() - Formata CNPJ (00.000.000/0000-00)
// • FormFormatters.telefone() - Formata telefone ((00) 00000-0000)
// • FormFormatters.cep() - Formata CEP (00000-000)
//
// EXEMPLO DE USO:
// ```dart
// DomaniTextField(
//   label: 'CPF',
//   validator: FormValidators.cpf(),
//   inputFormatters: [FormFormatters.cpf()],
// )
// ```
// ═══════════════════════════════════════════════════════════════════════════════════════════════

/// **FormValidators** - Validadores inteligentes para formulários
///
/// ## Propósito
/// Centraliza todas as validações comuns do sistema, garantindo consistência
/// e qualidade dos dados inseridos pelos usuários.
///
/// ## Características
/// - **Mensagens em português** - Feedback claro para o usuário
/// - **Validação robusta** - Algoritmos testados e confiáveis
/// - **Reutilização** - Validadores padronizados para toda aplicação
/// - **Flexibilidade** - Parâmetros customizáveis quando necessário
class FormValidators {
  /// **required** - Validador para campos obrigatórios
  ///
  /// ## Exemplo de Uso
  /// ```dart
  /// DomaniTextField(
  ///   label: 'Nome',
  ///   validator: FormValidators.required('Nome é obrigatório'),
  /// )
  /// ```
  static String? Function(String?) required([String? mensagem]) {
    return (String? value) {
      if (value == null || value.trim().isEmpty) {
        return mensagem ?? 'Este campo é obrigatório';
      }
      return null;
    };
  }

  /// **email** - Validador para endereços de email
  ///
  /// ## Características
  /// - Aceita emails vazios (use com required se obrigatório)
  /// - Validação robusta com regex
  /// - Mensagem em português
  ///
  /// ## Exemplo de Uso
  /// ```dart
  /// DomaniTextField(
  ///   label: 'Email',
  ///   validator: FormValidators.email(),
  ///   keyboardType: TextInputType.emailAddress,
  /// )
  /// ```
  static String? Function(String?) email([String? mensagem]) {
    return (String? value) {
      if (value == null || value.trim().isEmpty) {
        return null; // Email vazio é válido
      }

      final emailRegex = RegExp(
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
      );

      if (!emailRegex.hasMatch(value.trim())) {
        return mensagem ?? 'Digite um email válido';
      }

      return null;
    };
  }

  /// **cpf** - Validador para CPF brasileiro
  ///
  /// ## Características
  /// - Valida algoritmo do CPF
  /// - Remove formatação automaticamente
  /// - Rejeita CPFs inválidos conhecidos (000.000.000-00, etc.)
  ///
  /// ## Exemplo de Uso
  /// ```dart
  /// DomaniTextField(
  ///   label: 'CPF',
  ///   validator: FormValidators.cpf(),
  ///   inputFormatters: [FormFormatters.cpf()],
  /// )
  /// ```
  static String? Function(String?) cpf([String? mensagem]) {
    return (String? value) {
      if (value == null || value.trim().isEmpty) {
        return null; // CPF vazio é válido (use required se obrigatório)
      }

      // Remove formatação
      final cpfNumbers = value.replaceAll(RegExp(r'[^0-9]'), '');

      if (cpfNumbers.length != 11) {
        return mensagem ?? 'CPF deve ter 11 dígitos';
      }

      // Verifica se todos os dígitos são iguais
      if (RegExp(r'^(\d)\1*$').hasMatch(cpfNumbers)) {
        return mensagem ?? 'CPF inválido';
      }

      // Validação do algoritmo do CPF
      if (!_isValidCPF(cpfNumbers)) {
        return mensagem ?? 'CPF inválido';
      }

      return null;
    };
  }

  /// **cnpj** - Validador para CNPJ brasileiro
  ///
  /// ## Características
  /// - Valida algoritmo do CNPJ
  /// - Remove formatação automaticamente
  /// - Rejeita CNPJs inválidos conhecidos
  ///
  /// ## Exemplo de Uso
  /// ```dart
  /// DomaniTextField(
  ///   label: 'CNPJ',
  ///   validator: FormValidators.cnpj(),
  ///   inputFormatters: [FormFormatters.cnpj()],
  /// )
  /// ```
  static String? Function(String?) cnpj([String? mensagem]) {
    return (String? value) {
      if (value == null || value.trim().isEmpty) {
        return null; // CNPJ vazio é válido (use required se obrigatório)
      }

      // Remove formatação
      final cnpjNumbers = value.replaceAll(RegExp(r'[^0-9]'), '');

      if (cnpjNumbers.length != 14) {
        return mensagem ?? 'CNPJ deve ter 14 dígitos';
      }

      // Verifica se todos os dígitos são iguais
      if (RegExp(r'^(\d)\1*$').hasMatch(cnpjNumbers)) {
        return mensagem ?? 'CNPJ inválido';
      }

      // Validação do algoritmo do CNPJ
      if (!_isValidCNPJ(cnpjNumbers)) {
        return mensagem ?? 'CNPJ inválido';
      }

      return null;
    };
  }

  /// **telefone** - Validador para telefone brasileiro
  ///
  /// ## Características
  /// - Aceita celular (11 dígitos) e fixo (10 dígitos)
  /// - Remove formatação automaticamente
  /// - Valida códigos de área brasileiros
  ///
  /// ## Exemplo de Uso
  /// ```dart
  /// DomaniTextField(
  ///   label: 'Telefone',
  ///   validator: FormValidators.telefone(),
  ///   inputFormatters: [FormFormatters.telefone()],
  /// )
  /// ```
  static String? Function(String?) telefone([String? mensagem]) {
    return (String? value) {
      if (value == null || value.trim().isEmpty) {
        return null; // Telefone vazio é válido
      }

      // Remove formatação
      final phoneNumbers = value.replaceAll(RegExp(r'[^0-9]'), '');

      if (phoneNumbers.length < 10 || phoneNumbers.length > 11) {
        return mensagem ?? 'Telefone deve ter 10 ou 11 dígitos';
      }

      // Valida código de área (11 a 99)
      final areaCode = int.tryParse(phoneNumbers.substring(0, 2));
      if (areaCode == null || areaCode < 11 || areaCode > 99) {
        return mensagem ?? 'Código de área inválido';
      }

      return null;
    };
  }

  /// **cep** - Validador para CEP brasileiro
  ///
  /// ## Características
  /// - Valida formato brasileiro (8 dígitos)
  /// - Remove formatação automaticamente
  /// - Aceita CEPs de todo o Brasil
  ///
  /// ## Exemplo de Uso
  /// ```dart
  /// DomaniTextField(
  ///   label: 'CEP',
  ///   validator: FormValidators.cep(),
  ///   inputFormatters: [FormFormatters.cep()],
  /// )
  /// ```
  static String? Function(String?) cep([String? mensagem]) {
    return (String? value) {
      if (value == null || value.trim().isEmpty) {
        return null; // CEP vazio é válido
      }

      // Remove formatação
      final cepNumbers = value.replaceAll(RegExp(r'[^0-9]'), '');

      if (cepNumbers.length != 8) {
        return mensagem ?? 'CEP deve ter 8 dígitos';
      }

      // Verifica se não é um CEP inválido conhecido (00000000, 11111111, etc.)
      if (RegExp(r'^(\d)\1*$').hasMatch(cepNumbers)) {
        return mensagem ?? 'CEP inválido';
      }

      return null;
    };
  }

  /// **minLength** - Validador para tamanho mínimo
  ///
  /// ## Exemplo de Uso
  /// ```dart
  /// DomaniTextField(
  ///   label: 'Senha',
  ///   validator: FormValidators.minLength(6, 'Senha deve ter pelo menos 6 caracteres'),
  /// )
  /// ```
  static String? Function(String?) minLength(int min, [String? mensagem]) {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return null; // Vazio é válido (use required se obrigatório)
      }

      if (value.length < min) {
        return mensagem ?? 'Deve ter pelo menos $min caracteres';
      }

      return null;
    };
  }

  /// **combine** - Combina múltiplos validadores
  ///
  /// ## Exemplo de Uso
  /// ```dart
  /// DomaniTextField(
  ///   label: 'Email',
  ///   validator: FormValidators.combine([
  ///     FormValidators.required('Email é obrigatório'),
  ///     FormValidators.email('Digite um email válido'),
  ///   ]),
  /// )
  /// ```
  static String? Function(String?) combine(
    List<String? Function(String?)> validators,
  ) {
    return (String? value) {
      for (final validator in validators) {
        final result = validator(value);
        if (result != null) {
          return result; // Retorna o primeiro erro encontrado
        }
      }
      return null;
    };
  }

  // ═══════════════════════════════════════════════════════════════════════════════════════════════
  // MÉTODOS PRIVADOS DE VALIDAÇÃO
  // ═══════════════════════════════════════════════════════════════════════════════════════════════

  /// Valida algoritmo do CPF
  static bool _isValidCPF(String cpf) {
    // Primeiro dígito verificador
    int sum = 0;
    for (int i = 0; i < 9; i++) {
      sum += int.parse(cpf[i]) * (10 - i);
    }
    int firstDigit = 11 - (sum % 11);
    if (firstDigit >= 10) firstDigit = 0;

    if (int.parse(cpf[9]) != firstDigit) return false;

    // Segundo dígito verificador
    sum = 0;
    for (int i = 0; i < 10; i++) {
      sum += int.parse(cpf[i]) * (11 - i);
    }
    int secondDigit = 11 - (sum % 11);
    if (secondDigit >= 10) secondDigit = 0;

    return int.parse(cpf[10]) == secondDigit;
  }

  /// Valida algoritmo do CNPJ
  static bool _isValidCNPJ(String cnpj) {
    // Primeiro dígito verificador
    const weights1 = [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];
    int sum = 0;
    for (int i = 0; i < 12; i++) {
      sum += int.parse(cnpj[i]) * weights1[i];
    }
    int firstDigit = sum % 11;
    firstDigit = firstDigit < 2 ? 0 : 11 - firstDigit;

    if (int.parse(cnpj[12]) != firstDigit) return false;

    // Segundo dígito verificador
    const weights2 = [6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];
    sum = 0;
    for (int i = 0; i < 13; i++) {
      sum += int.parse(cnpj[i]) * weights2[i];
    }
    int secondDigit = sum % 11;
    secondDigit = secondDigit < 2 ? 0 : 11 - secondDigit;

    return int.parse(cnpj[13]) == secondDigit;
  }
}

/// **FormFormatters** - Formatadores automáticos para campos de entrada
///
/// ## Propósito
/// Formata automaticamente os dados conforme o usuário digita, melhorando
/// a experiência e garantindo consistência visual.
///
/// ## Características
/// - **Formatação em tempo real** - Aplica máscara conforme digitação
/// - **Remoção inteligente** - Remove formatação ao apagar
/// - **Padrões brasileiros** - Formatos familiares aos usuários
/// - **Performance otimizada** - Formatação eficiente
class FormFormatters {
  /// **cpf** - Formatador para CPF (000.000.000-00)
  ///
  /// ## Exemplo de Uso
  /// ```dart
  /// DomaniTextField(
  ///   label: 'CPF',
  ///   inputFormatters: [FormFormatters.cpf()],
  ///   keyboardType: TextInputType.number,
  /// )
  /// ```
  static TextInputFormatter cpf() {
    return TextInputFormatter.withFunction((oldValue, newValue) {
      final text = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

      if (text.length > 11) {
        return oldValue;
      }

      String formatted = text;
      if (text.length > 3) {
        formatted = '${text.substring(0, 3)}.${text.substring(3)}';
      }
      if (text.length > 6) {
        formatted =
            '${text.substring(0, 3)}.${text.substring(3, 6)}.${text.substring(6)}';
      }
      if (text.length > 9) {
        formatted =
            '${text.substring(0, 3)}.${text.substring(3, 6)}.${text.substring(6, 9)}-${text.substring(9)}';
      }

      return TextEditingValue(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
      );
    });
  }

  /// **cnpj** - Formatador para CNPJ (00.000.000/0000-00)
  ///
  /// ## Exemplo de Uso
  /// ```dart
  /// DomaniTextField(
  ///   label: 'CNPJ',
  ///   inputFormatters: [FormFormatters.cnpj()],
  ///   keyboardType: TextInputType.number,
  /// )
  /// ```
  static TextInputFormatter cnpj() {
    return TextInputFormatter.withFunction((oldValue, newValue) {
      final text = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

      if (text.length > 14) {
        return oldValue;
      }

      String formatted = text;
      if (text.length > 2) {
        formatted = '${text.substring(0, 2)}.${text.substring(2)}';
      }
      if (text.length > 5) {
        formatted =
            '${text.substring(0, 2)}.${text.substring(2, 5)}.${text.substring(5)}';
      }
      if (text.length > 8) {
        formatted =
            '${text.substring(0, 2)}.${text.substring(2, 5)}.${text.substring(5, 8)}/${text.substring(8)}';
      }
      if (text.length > 12) {
        formatted =
            '${text.substring(0, 2)}.${text.substring(2, 5)}.${text.substring(5, 8)}/${text.substring(8, 12)}-${text.substring(12)}';
      }

      return TextEditingValue(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
      );
    });
  }

  /// **telefone** - Formatador para telefone ((00) 00000-0000)
  ///
  /// ## Características
  /// - Suporta celular (11 dígitos) e fixo (10 dígitos)
  /// - Formatação automática conforme digitação
  ///
  /// ## Exemplo de Uso
  /// ```dart
  /// DomaniTextField(
  ///   label: 'Telefone',
  ///   inputFormatters: [FormFormatters.telefone()],
  ///   keyboardType: TextInputType.phone,
  /// )
  /// ```
  static TextInputFormatter telefone() {
    return TextInputFormatter.withFunction((oldValue, newValue) {
      final text = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

      if (text.length > 11) {
        return oldValue;
      }

      String formatted = text;
      if (text.length > 2) {
        formatted = '(${text.substring(0, 2)}) ${text.substring(2)}';
      }
      if (text.length > 7) {
        if (text.length == 10) {
          // Telefone fixo: (00) 0000-0000
          formatted =
              '(${text.substring(0, 2)}) ${text.substring(2, 6)}-${text.substring(6)}';
        } else {
          // Celular: (00) 00000-0000
          formatted =
              '(${text.substring(0, 2)}) ${text.substring(2, 7)}-${text.substring(7)}';
        }
      }

      return TextEditingValue(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
      );
    });
  }

  /// **cep** - Formatador para CEP (00000-000)
  ///
  /// ## Exemplo de Uso
  /// ```dart
  /// DomaniTextField(
  ///   label: 'CEP',
  ///   inputFormatters: [FormFormatters.cep()],
  ///   keyboardType: TextInputType.number,
  /// )
  /// ```
  static TextInputFormatter cep() {
    return TextInputFormatter.withFunction((oldValue, newValue) {
      final text = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

      if (text.length > 8) {
        return oldValue;
      }

      String formatted = text;
      if (text.length > 5) {
        formatted = '${text.substring(0, 5)}-${text.substring(5)}';
      }

      return TextEditingValue(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
      );
    });
  }

  /// **currency** - Formatador para valores monetários (R$ 0.000,00)
  ///
  /// ## Exemplo de Uso
  /// ```dart
  /// DomaniTextField(
  ///   label: 'Valor',
  ///   inputFormatters: [FormFormatters.currency()],
  ///   keyboardType: TextInputType.number,
  /// )
  /// ```
  static TextInputFormatter currency() {
    return TextInputFormatter.withFunction((oldValue, newValue) {
      final text = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

      if (text.isEmpty) {
        return const TextEditingValue(text: '');
      }

      final value = int.parse(text);
      final formatted =
          'R\$ ${(value / 100).toStringAsFixed(2).replaceAll('.', ',')}';

      return TextEditingValue(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
      );
    });
  }
}
