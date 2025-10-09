import 'package:flutter/material.dart';
import '../../../theme/theme.dart';
import '../../../theme/animations.dart';

class TextInputField extends StatefulWidget {
  final String hintText;
  final String? labelText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final void Function(String)? onChanged;
  final void Function()? onEditingComplete;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;

  const TextInputField({
    super.key,
    required this.hintText,
    this.labelText,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.onChanged,
    this.onEditingComplete,
    this.focusNode,
    this.validator,
  });

  @override
  State<TextInputField> createState() => _TextInputFieldState();
}

class _TextInputFieldState extends State<TextInputField> {
  late final FocusNode _focusNode;
  bool _isFocused = false;
  bool _isHovered = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    // Se o focus node foi criado internamente, faça o dispose.
    if (widget.focusNode == null) {
      _focusNode.dispose();
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
    if (_isFocused) {
      return colorScheme.primary;
    }
    if (_isHovered) {
      return colorScheme.primary.withValues(alpha: 0.6);
    }
    return isDarkMode ? AppTheme.neutral600 : AppTheme.formFieldBorderLight;
  }

  Color _getBackgroundColor(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.labelText != null) ...[
          AnimatedDefaultTextStyle(
            duration: AppAnimations.fast,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: _isFocused
                  ? colorScheme.primary
                  : colorScheme.onSurface.withValues(alpha: 0.8),
            ),
            child: Text(widget.labelText!),
          ),
          const SizedBox(height: AppTheme.spacingS),
        ],
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
                    color: colorScheme.primary.withValues(
                      alpha: _isFocused ? 0.15 : 0.08,
                    ),
                    blurRadius: _isFocused ? 8.0 : 4.0,
                    spreadRadius: _isFocused ? 1.0 : 0.0,
                    offset: const Offset(0, 2),
                  ),
                ],
              ],
            ),
            child: TextFormField(
              controller: widget.controller,
              keyboardType: widget.keyboardType,
              obscureText: widget.obscureText,
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: TextStyle(
                  color: colorScheme.onSurface.withValues(alpha: 0.5),
                  fontSize: AppTheme.textTheme.bodyMedium?.fontSize,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacingM,
                  vertical: AppTheme.spacingM,
                ),
                // Ícone de sufixo para campos de senha
                suffixIcon: widget.obscureText
                    ? Icon(
                        Icons.visibility_off_outlined,
                        color: colorScheme.onSurface.withValues(alpha: 0.6),
                        size: 20,
                      )
                    : null,
              ),
              style: TextStyle(
                color: colorScheme.onSurface,
                fontSize: AppTheme.textTheme.bodyMedium?.fontSize,
                fontWeight: FontWeight.w500,
              ),
              onChanged: widget.onChanged,
              onEditingComplete: widget.onEditingComplete,
              focusNode: _focusNode,
              validator: (value) {
                final result = widget.validator?.call(value);
                setState(() => _hasError = result != null);
                return result;
              },
            ),
          ),
        ),
      ],
    );
  }
}
