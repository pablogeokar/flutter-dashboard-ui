import 'package:flutter/material.dart';
import '/theme/theme.dart';
import '/theme/animations.dart';

/// Widget de área de texto (textarea) personalizado
class TextAreaField extends StatefulWidget {
  final String labelText;
  final String hintText;
  final TextEditingController? controller;
  final int maxLines;
  final int? maxLength;
  final ValueChanged<String>? onChanged;
  final String? errorText;
  final bool enabled;
  final String? Function(String?)? validator;

  const TextAreaField({
    super.key,
    required this.labelText,
    required this.hintText,
    this.controller,
    this.maxLines = 4,
    this.maxLength,
    this.onChanged,
    this.errorText,
    this.enabled = true,
    this.validator,
  });

  @override
  State<TextAreaField> createState() => _TextAreaFieldState();
}

class _TextAreaFieldState extends State<TextAreaField> {
  late final FocusNode _focusNode;
  bool _isFocused = false;
  bool _isHovered = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);
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
    final colorScheme = Theme.of(context).colorScheme;
    final hasError = widget.errorText != null && widget.errorText!.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            if (widget.maxLength != null)
              AnimatedDefaultTextStyle(
                duration: AppAnimations.fast,
                style: TextStyle(
                  fontSize: 12,
                  color: colorScheme.onSurface.withValues(alpha: 0.6),
                ),
                child: Text(
                  '${widget.controller?.text.length ?? 0}/${widget.maxLength}',
                ),
              ),
          ],
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
            child: TextFormField(
              controller: widget.controller,
              focusNode: _focusNode,
              maxLines: widget.maxLines,
              maxLength: widget.maxLength,
              enabled: widget.enabled,
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: TextStyle(
                  color: colorScheme.onSurface.withValues(alpha: 0.5),
                  fontSize: 14,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.all(AppTheme.spacingM),
                counterText: '', // Remove o contador padrão
              ),
              style: TextStyle(
                color: widget.enabled
                    ? colorScheme.onSurface
                    : colorScheme.onSurface.withValues(alpha: 0.5),
                fontSize: 14,
                fontWeight: FontWeight.w500,
                height: 1.4,
              ),
              onChanged: (value) {
                widget.onChanged?.call(value);
                if (widget.maxLength != null) {
                  setState(() {}); // Atualiza o contador
                }
              },
              validator: (value) {
                final result = widget.validator?.call(value);
                setState(() => _hasError = result != null);
                return result;
              },
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
