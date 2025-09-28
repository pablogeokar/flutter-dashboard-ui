import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../theme/theme.dart';
import 'currency_pt_br_input_formatter.dart';

/// Widget personalizado para entrada de valores monetários.
///
/// Este widget fornece uma interface visualmente consistente com o tema do aplicativo,
/// incluindo bordas arredondadas, sombras sutis e suporte a temas claro/escuro.
/// Ele utiliza um [TextFormField] para permitir validação e um [CurrencyPtBrInputFormatter]
/// para formatar automaticamente o texto como moeda brasileira (BRL).
class MonetaryInputField extends StatefulWidget {
  final String label;
  final TextEditingController? controller;
  final String? hintText;
  final ValueChanged<String>? onChanged;
  final String? errorText;
  final bool enabled;
  final String? Function(String?)? validator;

  const MonetaryInputField({
    super.key,
    required this.label,
    this.controller,
    this.hintText = '0,00',
    this.onChanged,
    this.errorText,
    this.enabled = true,
    this.validator,
  });

  @override
  State<MonetaryInputField> createState() => _MonetaryInputFieldState();
}

class _MonetaryInputFieldState extends State<MonetaryInputField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    // Se o controller foi criado internamente, faça o dispose.
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final backgroundColor = isDarkMode
        ? AppTheme.surfaceDark
        : AppTheme.surfaceLight;
    final borderColor = isDarkMode ? AppTheme.neutral1 : AppTheme.neutral2;
    final textColor = isDarkMode
        ? AppTheme.secondaryDark
        : AppTheme.secondaryLight;
    final errorColor = Colors.red;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
        const SizedBox(height: AppTheme.spacingS),
        Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(AppTheme.borderRadiusL),
            border: Border.all(
              color: widget.errorText != null && widget.errorText!.isNotEmpty
                  ? errorColor
                  : borderColor,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TextFormField(
            controller: _controller,
            enabled: widget.enabled,
            style: GoogleFonts.inter(fontSize: 14, color: textColor),
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: GoogleFonts.inter(
                fontSize: 14,
                color: AppTheme.neutral1,
              ),
              prefixIcon: Padding(
                padding: const EdgeInsets.only(
                  left: AppTheme.spacingM,
                  right: AppTheme.spacingS,
                ),
                child: Text(
                  'R\$ ',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              prefixIconConstraints: const BoxConstraints(
                minWidth: 0,
                minHeight: 0,
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: AppTheme.spacingS,
              ).copyWith(right: AppTheme.spacingM),
              border: InputBorder.none,
              errorText: widget.errorText,
              // Esconde o texto de erro padrão para usar o customizado abaixo
              errorStyle: const TextStyle(height: 0, fontSize: 0),
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              CurrencyPtBrInputFormatter(),
            ],
            onChanged: (value) {
              if (widget.onChanged != null) {
                // Envia o valor numérico puro (ex: "1234.56")
                final numericString = value
                    .replaceAll('.', '')
                    .replaceAll(',', '.');
                widget.onChanged!(numericString);
              }
            },
            validator: widget.validator,
          ),
        ),
        if (widget.errorText != null && widget.errorText!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(
              top: AppTheme.spacingS,
              left: AppTheme.spacingS,
            ),
            child: Text(
              widget.errorText!,
              style: GoogleFonts.inter(
                fontSize: 12,
                color: errorColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
      ],
    );
  }
}
