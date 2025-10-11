import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/theme/theme.dart';
import '/theme/animations.dart';
import '/widgets/src/forms/formatters/currency_input_formatter.dart';

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
  late final FocusNode _focusNode;
  bool _isFocused = false;
  bool _isHovered = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    // Se o controller foi criado internamente, faça o dispose.
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  void _onFocusChange() {
    if (mounted) {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    }
  }

  Color _getBorderColor(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    if (_hasError) return AppTheme.errorLight;
    if (_isFocused) return colorScheme.primary;
    if (_isHovered) return colorScheme.primary.withValues(alpha: 0.6);
    return isDarkMode ? AppTheme.neutral600 : AppTheme.formFieldBorderLight;
  }

  Color _getBackgroundColor(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    if (!widget.enabled) {
      return isDarkMode
          ? AppTheme.neutral800.withValues(alpha: 0.5)
          : AppTheme.formFieldBackgroundLight.withValues(alpha: 0.5);
    }
    if (_isFocused) {
      return isDarkMode
          ? AppTheme.formFieldFocusDark
          : AppTheme.formFieldFocusLight;
    }
    if (_isHovered) {
      return isDarkMode
          ? AppTheme.formFieldHoverDark
          : AppTheme.formFieldHoverLight;
    }
    return isDarkMode ? AppTheme.neutral800 : AppTheme.formFieldBackgroundLight;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final hasError = widget.errorText != null && widget.errorText!.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedDefaultTextStyle(
          duration: AppAnimations.fast,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: hasError
                ? AppTheme.errorLight
                : _isFocused
                ? colorScheme.primary
                : colorScheme.onSurface.withValues(alpha: 0.8),
          ),
          child: Text(widget.label),
        ),
        const SizedBox(height: AppTheme.spacingS),
        MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: AnimatedContainer(
            duration: AppAnimations.fast,
            curve: AppAnimations.easeOut,
            decoration: BoxDecoration(
              color: _getBackgroundColor(context),
              borderRadius: BorderRadius.circular(AppTheme.borderRadiusM),
              border: Border.all(
                color: _getBorderColor(context),
                width: _isFocused ? 2.0 : 1.0,
              ),
              boxShadow: [
                if (_isFocused || _isHovered) ...[
                  BoxShadow(
                    color: hasError
                        ? AppTheme.errorLight.withValues(alpha: 0.15)
                        : colorScheme.primary.withValues(
                            alpha: _isFocused ? 0.15 : 0.08,
                          ),
                    blurRadius: _isFocused ? 8.0 : 4.0,
                    spreadRadius: _isFocused ? 1.0 : 0.0,
                    offset: const Offset(0, 2),
                  ),
                ],
              ],
            ),
            child: Row(
              children: [
                // Prefixo R$ com animação
                AnimatedContainer(
                  duration: AppAnimations.fast,
                  padding: const EdgeInsets.only(
                    left: AppTheme.spacingM,
                    right: AppTheme.spacingS,
                  ),
                  child: AnimatedDefaultTextStyle(
                    duration: AppAnimations.fast,
                    style: TextStyle(
                      fontSize: 14,
                      color: _isFocused
                          ? colorScheme.primary
                          : colorScheme.onSurface.withValues(alpha: 0.7),
                      fontWeight: FontWeight.bold,
                    ),
                    child: const Text('R\$'),
                  ),
                ),
                // Campo de entrada
                Expanded(
                  child: TextFormField(
                    controller: _controller,
                    focusNode: _focusNode,
                    enabled: widget.enabled,
                    style: TextStyle(
                      fontSize: 14,
                      color: widget.enabled
                          ? colorScheme.onSurface
                          : colorScheme.onSurface.withValues(alpha: 0.5),
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      hintText: widget.hintText,
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: colorScheme.onSurface.withValues(alpha: 0.5),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: AppTheme.spacingM,
                        horizontal: AppTheme.spacingS,
                      ),
                      border: InputBorder.none,
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
                    validator: (value) {
                      final result = widget.validator?.call(value);
                      setState(() => _hasError = result != null);
                      return result;
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        if (hasError)
          Padding(
            padding: const EdgeInsets.only(
              top: AppTheme.spacingS,
              left: AppTheme.spacingS,
            ),
            child: AnimatedOpacity(
              duration: AppAnimations.fast,
              opacity: 1.0,
              child: Text(
                widget.errorText!,
                style: TextStyle(
                  fontSize: 12,
                  color: AppTheme.errorLight,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
