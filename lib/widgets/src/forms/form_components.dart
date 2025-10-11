import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../theme/theme.dart';

// ═══════════════════════════════════════════════════════════════════════════════════════════════
// EXPORTAÇÕES DE WIDGETS E UTILITÁRIOS DE FORMULÁRIO
// ═══════════════════════════════════════════════════════════════════════════════════════════════

// Exportar widgets e utilitários de formulário
export 'form_row.dart';
export 'form_validators.dart';

/// Campo de texto padronizado do sistema
class DomaniTextField extends StatefulWidget {
  final String? label;
  final String? hint;
  final String? helperText;
  final String? errorText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool obscureText;
  final bool enabled;
  final bool required;
  final int? maxLines;
  final int? maxLength;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final Function()? onTap;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;

  const DomaniTextField({
    super.key,
    this.label,
    this.hint,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.controller,
    this.keyboardType,
    this.inputFormatters,
    this.obscureText = false,
    this.enabled = true,
    this.required = false,
    this.maxLines = 1,
    this.maxLength,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.validator,
    this.focusNode,
  });

  @override
  State<DomaniTextField> createState() => _DomaniTextFieldState();
}

class _DomaniTextFieldState extends State<DomaniTextField> {
  late FocusNode _focusNode;
  bool _isFocused = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusChange);
    _hasError = widget.errorText != null;
  }

  @override
  void didUpdateWidget(DomaniTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.errorText != oldWidget.errorText) {
      setState(() {
        _hasError = widget.errorText != null;
      });
    }
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        if (widget.label != null) ...[
          Row(
            children: [
              Text(
                widget.label!,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: AppTheme.getResponsiveFontSize(screenWidth, 13),
                  color: _hasError
                      ? AppTheme.errorLight
                      : Theme.of(context).colorScheme.onSurface,
                ),
              ),
              if (widget.required) ...[
                SizedBox(width: AppTheme.spacingXS),
                Text(
                  '*',
                  style: TextStyle(
                    color: AppTheme.errorLight,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ],
          ),
          SizedBox(height: AppTheme.spacingS),
        ],

        // Campo de texto
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: widget.enabled
                ? isDarkMode
                      ? AppTheme.formFieldBackgroundDark
                      : AppTheme.formFieldBackgroundLight
                : isDarkMode
                ? AppTheme.neutral800.withValues(alpha: 0.3)
                : AppTheme.neutral100.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(AppTheme.borderRadiusM),
            border: Border.all(
              color: _getBorderColor(isDarkMode),
              width: _isFocused ? 2 : 1,
            ),
            boxShadow: _isFocused && !_hasError
                ? [
                    BoxShadow(
                      color: Theme.of(
                        context,
                      ).colorScheme.primary.withValues(alpha: 0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: TextField(
            controller: widget.controller,
            focusNode: _focusNode,
            keyboardType: widget.keyboardType,
            inputFormatters: widget.inputFormatters,
            obscureText: widget.obscureText,
            enabled: widget.enabled,
            maxLines: widget.maxLines,
            maxLength: widget.maxLength,
            onChanged: widget.onChanged,
            onSubmitted: widget.onSubmitted,
            onTap: widget.onTap,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: AppTheme.getResponsiveFontSize(screenWidth, 14),
              color: widget.enabled
                  ? Theme.of(context).colorScheme.onSurface
                  : Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.5),
            ),
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: TextStyle(
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.5),
                fontSize: AppTheme.getResponsiveFontSize(screenWidth, 14),
              ),
              prefixIcon: widget.prefixIcon != null
                  ? Icon(
                      widget.prefixIcon,
                      color: _getIconColor(isDarkMode),
                      size: 20,
                    )
                  : null,
              suffixIcon: widget.suffixIcon,
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: AppTheme.spacingM,
                vertical: AppTheme.spacingM,
              ),
              counterText: '', // Remove contador padrão
            ),
          ),
        ),

        // Helper text ou error text
        if (widget.helperText != null || widget.errorText != null) ...[
          SizedBox(height: AppTheme.spacingS),
          Row(
            children: [
              if (_hasError) ...[
                Icon(
                  Icons.error_outline_rounded,
                  size: 16,
                  color: AppTheme.errorLight,
                ),
                SizedBox(width: AppTheme.spacingXS),
              ],
              Expanded(
                child: Text(
                  widget.errorText ?? widget.helperText!,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: _hasError
                        ? AppTheme.errorLight
                        : Theme.of(
                            context,
                          ).colorScheme.onSurface.withValues(alpha: 0.6),
                    fontSize: AppTheme.getResponsiveFontSize(screenWidth, 12),
                  ),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  Color _getBorderColor(bool isDarkMode) {
    if (_hasError) {
      return AppTheme.errorLight;
    } else if (_isFocused) {
      return Theme.of(context).colorScheme.primary;
    } else {
      return isDarkMode
          ? AppTheme.formFieldBorderDark
          : AppTheme.formFieldBorderLight;
    }
  }

  Color _getIconColor(bool isDarkMode) {
    if (_hasError) {
      return AppTheme.errorLight;
    } else if (_isFocused) {
      return Theme.of(context).colorScheme.primary;
    } else {
      return Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6);
    }
  }
}

/// Dropdown padronizado do sistema
class DomaniDropdown<T> extends StatefulWidget {
  final String? label;
  final String? hint;
  final String? helperText;
  final String? errorText;
  final IconData? prefixIcon;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final Function(T?)? onChanged;
  final bool enabled;
  final bool required;
  final String? Function(T?)? validator;

  const DomaniDropdown({
    super.key,
    this.label,
    this.hint,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.value,
    required this.items,
    this.onChanged,
    this.enabled = true,
    this.required = false,
    this.validator,
  });

  @override
  State<DomaniDropdown<T>> createState() => _DomaniDropdownState<T>();
}

class _DomaniDropdownState<T> extends State<DomaniDropdown<T>> {
  bool _isFocused = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _hasError = widget.errorText != null;
  }

  @override
  void didUpdateWidget(DomaniDropdown<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.errorText != oldWidget.errorText) {
      setState(() {
        _hasError = widget.errorText != null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        if (widget.label != null) ...[
          Row(
            children: [
              Text(
                widget.label!,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: AppTheme.getResponsiveFontSize(screenWidth, 13),
                  color: _hasError
                      ? AppTheme.errorLight
                      : Theme.of(context).colorScheme.onSurface,
                ),
              ),
              if (widget.required) ...[
                SizedBox(width: AppTheme.spacingXS),
                Text(
                  '*',
                  style: TextStyle(
                    color: AppTheme.errorLight,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ],
          ),
          SizedBox(height: AppTheme.spacingS),
        ],

        // Dropdown
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: widget.enabled
                ? isDarkMode
                      ? AppTheme.formFieldBackgroundDark
                      : AppTheme.formFieldBackgroundLight
                : isDarkMode
                ? AppTheme.neutral800.withValues(alpha: 0.3)
                : AppTheme.neutral100.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(AppTheme.borderRadiusM),
            border: Border.all(
              color: _getBorderColor(isDarkMode),
              width: _isFocused ? 2 : 1,
            ),
            boxShadow: _isFocused && !_hasError
                ? [
                    BoxShadow(
                      color: Theme.of(
                        context,
                      ).colorScheme.primary.withValues(alpha: 0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: DropdownButtonFormField<T>(
            initialValue: widget.value,
            items: widget.items,
            onChanged: widget.enabled ? widget.onChanged : null,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: AppTheme.getResponsiveFontSize(screenWidth, 14),
              color: widget.enabled
                  ? Theme.of(context).colorScheme.onSurface
                  : Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.5),
            ),
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: TextStyle(
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.5),
                fontSize: AppTheme.getResponsiveFontSize(screenWidth, 14),
              ),
              prefixIcon: widget.prefixIcon != null
                  ? Icon(
                      widget.prefixIcon,
                      color: _getIconColor(isDarkMode),
                      size: 20,
                    )
                  : null,
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: AppTheme.spacingM,
                vertical: AppTheme.spacingM,
              ),
            ),
            dropdownColor: isDarkMode
                ? AppTheme.formFieldBackgroundDark
                : AppTheme.formFieldBackgroundLight,
            borderRadius: BorderRadius.circular(AppTheme.borderRadiusM),
            onTap: () => setState(() => _isFocused = true),
          ),
        ),

        // Helper text ou error text
        if (widget.helperText != null || widget.errorText != null) ...[
          SizedBox(height: AppTheme.spacingS),
          Row(
            children: [
              if (_hasError) ...[
                Icon(
                  Icons.error_outline_rounded,
                  size: 16,
                  color: AppTheme.errorLight,
                ),
                SizedBox(width: AppTheme.spacingXS),
              ],
              Expanded(
                child: Text(
                  widget.errorText ?? widget.helperText!,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: _hasError
                        ? AppTheme.errorLight
                        : Theme.of(
                            context,
                          ).colorScheme.onSurface.withValues(alpha: 0.6),
                    fontSize: AppTheme.getResponsiveFontSize(screenWidth, 12),
                  ),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  Color _getBorderColor(bool isDarkMode) {
    if (_hasError) {
      return AppTheme.errorLight;
    } else if (_isFocused) {
      return Theme.of(context).colorScheme.primary;
    } else {
      return isDarkMode
          ? AppTheme.formFieldBorderDark
          : AppTheme.formFieldBorderLight;
    }
  }

  Color _getIconColor(bool isDarkMode) {
    if (_hasError) {
      return AppTheme.errorLight;
    } else if (_isFocused) {
      return Theme.of(context).colorScheme.primary;
    } else {
      return Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6);
    }
  }
}

/// Botão padronizado do sistema
class DomaniButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final DomaniButtonType type;
  final DomaniButtonSize size;
  final bool isLoading;
  final bool fullWidth;

  const DomaniButton({
    super.key,
    required this.text,
    this.onPressed,
    this.icon,
    this.type = DomaniButtonType.primary,
    this.size = DomaniButtonSize.medium,
    this.isLoading = false,
    this.fullWidth = false,
  });

  @override
  State<DomaniButton> createState() => _DomaniButtonState();
}

class _DomaniButtonState extends State<DomaniButton> {
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final isEnabled = widget.onPressed != null && !widget.isLoading;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: widget.fullWidth ? double.infinity : null,
          height: _getButtonHeight(),
          decoration: BoxDecoration(
            color: _getBackgroundColor(isDarkMode, isEnabled),
            borderRadius: BorderRadius.circular(AppTheme.borderRadiusM),
            border: widget.type == DomaniButtonType.outline
                ? Border.all(
                    color: _getBorderColor(isDarkMode, isEnabled),
                    width: 1.5,
                  )
                : null,
            boxShadow: _isHovered && isEnabled
                ? [
                    BoxShadow(
                      color: _getShadowColor(isDarkMode),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          transform: _isPressed && isEnabled
              ? Matrix4.diagonal3Values(0.98, 0.98, 1.0)
              : Matrix4.identity(),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: isEnabled ? widget.onPressed : null,
              borderRadius: BorderRadius.circular(AppTheme.borderRadiusM),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: _getHorizontalPadding(),
                  vertical: _getVerticalPadding(),
                ),
                child: Row(
                  mainAxisSize: widget.fullWidth
                      ? MainAxisSize.max
                      : MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (widget.isLoading) ...[
                      SizedBox(
                        width: _getIconSize(),
                        height: _getIconSize(),
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            _getTextColor(isDarkMode, isEnabled),
                          ),
                        ),
                      ),
                      SizedBox(width: AppTheme.spacingS),
                    ] else if (widget.icon != null) ...[
                      Icon(
                        widget.icon,
                        size: _getIconSize(),
                        color: _getTextColor(isDarkMode, isEnabled),
                      ),
                      SizedBox(width: AppTheme.spacingS),
                    ],
                    Text(
                      widget.text,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: AppTheme.getResponsiveFontSize(
                          screenWidth,
                          _getFontSize(),
                        ),
                        color: _getTextColor(isDarkMode, isEnabled),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  double _getButtonHeight() {
    switch (widget.size) {
      case DomaniButtonSize.small:
        return 36;
      case DomaniButtonSize.medium:
        return 44;
      case DomaniButtonSize.large:
        return 52;
    }
  }

  double _getHorizontalPadding() {
    switch (widget.size) {
      case DomaniButtonSize.small:
        return AppTheme.spacingM;
      case DomaniButtonSize.medium:
        return AppTheme.spacingL;
      case DomaniButtonSize.large:
        return AppTheme.spacingXL;
    }
  }

  double _getVerticalPadding() {
    switch (widget.size) {
      case DomaniButtonSize.small:
        return AppTheme.spacingS;
      case DomaniButtonSize.medium:
        return AppTheme.spacingM;
      case DomaniButtonSize.large:
        return AppTheme.spacingM;
    }
  }

  double _getIconSize() {
    switch (widget.size) {
      case DomaniButtonSize.small:
        return 16;
      case DomaniButtonSize.medium:
        return 18;
      case DomaniButtonSize.large:
        return 20;
    }
  }

  double _getFontSize() {
    switch (widget.size) {
      case DomaniButtonSize.small:
        return 13;
      case DomaniButtonSize.medium:
        return 14;
      case DomaniButtonSize.large:
        return 15;
    }
  }

  Color _getBackgroundColor(bool isDarkMode, bool isEnabled) {
    if (!isEnabled) {
      return isDarkMode
          ? AppTheme.neutral700.withValues(alpha: 0.3)
          : AppTheme.neutral200.withValues(alpha: 0.5);
    }

    switch (widget.type) {
      case DomaniButtonType.primary:
        return _isHovered
            ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.9)
            : Theme.of(context).colorScheme.primary;
      case DomaniButtonType.secondary:
        return _isHovered
            ? isDarkMode
                  ? AppTheme.neutral700
                  : AppTheme.neutral200
            : isDarkMode
            ? AppTheme.neutral800
            : AppTheme.neutral100;
      case DomaniButtonType.outline:
        return _isHovered
            ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.05)
            : Colors.transparent;
      case DomaniButtonType.danger:
        return _isHovered
            ? AppTheme.errorLight.withValues(alpha: 0.9)
            : AppTheme.errorLight;
    }
  }

  Color _getBorderColor(bool isDarkMode, bool isEnabled) {
    if (!isEnabled) {
      return isDarkMode ? AppTheme.neutral600 : AppTheme.neutral300;
    }

    switch (widget.type) {
      case DomaniButtonType.outline:
        return _isHovered
            ? Theme.of(context).colorScheme.primary
            : isDarkMode
            ? AppTheme.neutral600
            : AppTheme.neutral300;
      default:
        return Colors.transparent;
    }
  }

  Color _getTextColor(bool isDarkMode, bool isEnabled) {
    if (!isEnabled) {
      return isDarkMode ? AppTheme.neutral400 : AppTheme.neutral500;
    }

    switch (widget.type) {
      case DomaniButtonType.primary:
      case DomaniButtonType.danger:
        return Colors.white;
      case DomaniButtonType.secondary:
        return Theme.of(context).colorScheme.onSurface;
      case DomaniButtonType.outline:
        return _isHovered
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.onSurface;
    }
  }

  Color _getShadowColor(bool isDarkMode) {
    switch (widget.type) {
      case DomaniButtonType.primary:
        return Theme.of(context).colorScheme.primary.withValues(alpha: 0.3);
      case DomaniButtonType.danger:
        return AppTheme.errorLight.withValues(alpha: 0.3);
      default:
        return Colors.black.withValues(alpha: isDarkMode ? 0.2 : 0.1);
    }
  }
}

/// Tipos de botão
enum DomaniButtonType { primary, secondary, outline, danger }

/// Tamanhos de botão
enum DomaniButtonSize { small, medium, large }
