import 'package:flutter/material.dart';
import '../../../theme/theme.dart';

// ═══════════════════════════════════════════════════════════════════════════════════════════════
// EXPORTAÇÕES DE WIDGETS E UTILITÁRIOS DE FORMULÁRIO
// ═══════════════════════════════════════════════════════════════════════════════════════════════

// Exportar widgets e utilitários de formulário
export 'form_row.dart';
export 'form_validators.dart';

// Exportar widgets de form_layout
export '../form_layout/select_input_field.dart';
export '../form_layout/text_input_field.dart';
export '../form_layout/date_input_field.dart';
export '../form_layout/monetary_input_field.dart';

// ═══════════════════════════════════════════════════════════════════════════════════════════════
// WIDGETS ESPECÍFICOS DO SISTEMA
// ═══════════════════════════════════════════════════════════════════════════════════════════════

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
