import 'package:flutter/material.dart';
import '../../../theme/theme.dart';
import '../../../theme/animations.dart';

/// Widget de seleção (dropdown) personalizado usando a API atual do Flutter
///
/// Este widget implementa um dropdown com design consistente usando FormField
/// e DropdownButton ao invés da API depreciada DropdownButtonFormField.
class SelectInputField<T> extends StatefulWidget {
  final String labelText;
  final String hintText;
  final T? value;
  final List<SelectOption<T>> options;
  final ValueChanged<T?>? onChanged;
  final String? errorText;
  final bool enabled;
  final String? Function(T?)? validator;

  const SelectInputField({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.options,
    this.value,
    this.onChanged,
    this.errorText,
    this.enabled = true,
    this.validator,
  });

  @override
  State<SelectInputField<T>> createState() => _SelectInputFieldState<T>();
}

class _SelectInputFieldState<T> extends State<SelectInputField<T>> {
  late final FocusNode _focusNode;
  bool _isHovered = false;
  bool _isFocused = false;
  bool _hasError = false;
  T? _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.value;
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void didUpdateWidget(SelectInputField<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _currentValue = widget.value;
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    if (mounted) {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    }
  }

  void _handleTap() {
    if (widget.enabled) {
      _focusNode.requestFocus();
    }
  }

  /// Reseta o valor selecionado para null
  void reset() {
    setState(() {
      _currentValue = null;
    });
    widget.onChanged?.call(null);
  }

  Color _getBorderColor(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    if (_hasError) return AppTheme.errorLight;
    if (_isFocused) return colorScheme.primary;
    if (_isHovered) return colorScheme.primary.withValues(alpha: 0.6);
    return isDarkMode
        ? AppTheme.formFieldBorderDark
        : AppTheme.formFieldBorderLight;
  }

  Color _getBackgroundColor(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    if (!widget.enabled) {
      return isDarkMode
          ? AppTheme.formFieldBackgroundDark.withValues(alpha: 0.5)
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
    return isDarkMode
        ? AppTheme.formFieldBackgroundDark
        : AppTheme.formFieldBackgroundLight;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
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
          child: Text(widget.labelText),
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
            child: GestureDetector(
              onTap: _handleTap,
              child: Focus(
                focusNode: _focusNode,
                child: Container(
                  height: 48, // Altura fixa consistente com outros campos
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppTheme.spacingM,
                  ),
                  alignment:
                      Alignment.centerLeft, // Alinhamento vertical centralizado
                  child: DropdownButton<T>(
                    value: _currentValue,
                    hint: Text(
                      widget.hintText,
                      style: TextStyle(
                        color: colorScheme.onSurface.withValues(alpha: 0.5),
                        fontSize: 14,
                      ),
                    ),
                    isExpanded: true,
                    underline: const SizedBox(), // Remove a linha padrão
                    style: TextStyle(
                      color: widget.enabled
                          ? colorScheme.onSurface
                          : colorScheme.onSurface.withValues(alpha: 0.5),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    dropdownColor:
                        Theme.of(context).brightness == Brightness.dark
                        ? AppTheme.formFieldBackgroundDark
                        : AppTheme.formFieldBackgroundLight,
                    icon: AnimatedRotation(
                      duration: AppAnimations.fast,
                      turns: _isFocused ? 0.5 : 0.0,
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        color: hasError
                            ? AppTheme.errorLight
                            : _isFocused
                            ? colorScheme.primary
                            : colorScheme.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                    onChanged: widget.enabled
                        ? (T? value) {
                            setState(() {
                              _currentValue = value;
                            });

                            // Executar validação se fornecida
                            if (widget.validator != null) {
                              final result = widget.validator!(value);
                              setState(() => _hasError = result != null);
                            }

                            widget.onChanged?.call(value);

                            // Remover o foco após a seleção para comportamento natural
                            Future.delayed(
                              const Duration(milliseconds: 100),
                              () {
                                if (mounted) {
                                  _focusNode.unfocus();
                                }
                              },
                            );
                          }
                        : null,
                    items: widget.options.map((option) {
                      return DropdownMenuItem<T>(
                        value: option.value,
                        child: Text(
                          option.label,
                          style: TextStyle(
                            color: colorScheme.onSurface,
                            fontSize: 14,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
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

class SelectOption<T> {
  final T value;
  final String label;
  final IconData? icon;

  const SelectOption({required this.value, required this.label, this.icon});
}
