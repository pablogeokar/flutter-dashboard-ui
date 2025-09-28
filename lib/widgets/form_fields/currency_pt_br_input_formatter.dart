import 'package:flutter/services.dart';

/// Formata o valor do campo para o padrão de moeda BRL (R$).
///
/// Ex: O usuário digita `12345` e o campo exibe `123,45`.
class CurrencyPtBrInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // 1. Obter apenas os dígitos
    String digitsOnly = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    // Se não houver dígitos, retorna um campo vazio
    if (digitsOnly.isEmpty) {
      return newValue.copyWith(text: '');
    }

    // 2. Remover zeros à esquerda que não sejam significativos
    while (digitsOnly.length > 3 && digitsOnly.startsWith('0')) {
      digitsOnly = digitsOnly.substring(1);
    }
    // Garante que valores como "0,50" (digitando 50) funcionem
    while (digitsOnly.length < 3) {
      digitsOnly = '0$digitsOnly';
    }

    // 4. Construir a string formatada
    final int len = digitsOnly.length;
    String integerPart = digitsOnly.substring(0, len - 2);
    final String decimalPart = digitsOnly.substring(len - 2);

    // 5. Adicionar separadores de milhar
    final re = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    integerPart = integerPart.replaceAllMapped(re, (Match m) => '${m[1]}.');
    
    // Remove o ponto inicial se a parte inteira for algo como ".123"
    if (integerPart.startsWith('.')) {
      integerPart = integerPart.substring(1);
    }
    // Garante que a parte inteira seja '0' se estiver vazia
    if (integerPart.isEmpty) {
      integerPart = '0';
    }


    final String newText = '$integerPart,$decimalPart';

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
