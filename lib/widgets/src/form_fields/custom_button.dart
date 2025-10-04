import 'package:flutter/material.dart';
import '../../../theme/theme.dart';
import '../../../theme/animations.dart';

/// Widget de botão personalizado.
///
/// Este botão oferece um estilo consistente com a identidade visual do dashboard,
/// incluindo bordas arredondadas, sombras sutis e suporte a temas claro/escuro.
class CustomButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Color? color;
  final Color? textColor;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final IconData? icon;
  final bool showLoadingIndicator;
  final Widget? child;
  final ButtonVariant variant;
  final ButtonSize size;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.color,
    this.textColor,
    this.width,
    this.height,
    this.padding,
    this.borderRadius = AppTheme.borderRadiusM,
    this.icon,
    this.showLoadingIndicator = true,
    this.child,
    this.variant = ButtonVariant.primary,
    this.size = ButtonSize.medium,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

enum ButtonVariant { primary, secondary, outline, ghost, success, error }

enum ButtonSize { small, medium, large }

class _CustomButtonState extends State<CustomButton> {
  bool _isHovered = false;
  bool _isPressed = false;

  ButtonColors _getButtonColors(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    switch (widget.variant) {
      case ButtonVariant.primary:
        return ButtonColors(
          background: widget.color ?? colorScheme.primary,
          foreground: widget.textColor ?? colorScheme.onPrimary,
          hoverBackground: (widget.color ?? colorScheme.primary).withValues(
            alpha: 0.9,
          ),
          border: Colors.transparent,
        );
      case ButtonVariant.secondary:
        return ButtonColors(
          background: colorScheme.secondary,
          foreground: colorScheme.onSecondary,
          hoverBackground: colorScheme.secondary.withValues(alpha: 0.9),
          border: Colors.transparent,
        );
      case ButtonVariant.outline:
        return ButtonColors(
          background: Colors.transparent,
          foreground: colorScheme.primary,
          hoverBackground: colorScheme.primary.withValues(alpha: 0.1),
          border: colorScheme.primary,
        );
      case ButtonVariant.ghost:
        return ButtonColors(
          background: Colors.transparent,
          foreground: colorScheme.onSurface,
          hoverBackground: colorScheme.surfaceContainerHighest,
          border: Colors.transparent,
        );
      case ButtonVariant.success:
        return ButtonColors(
          background: AppTheme.successLight,
          foreground: Colors.white,
          hoverBackground: AppTheme.successLight.withValues(alpha: 0.9),
          border: Colors.transparent,
        );
      case ButtonVariant.error:
        return ButtonColors(
          background: AppTheme.errorLight,
          foreground: Colors.white,
          hoverBackground: AppTheme.errorLight.withValues(alpha: 0.9),
          border: Colors.transparent,
        );
    }
  }

  EdgeInsetsGeometry _getPadding() {
    switch (widget.size) {
      case ButtonSize.small:
        return const EdgeInsets.symmetric(
          horizontal: AppTheme.spacingM,
          vertical: AppTheme.spacingS,
        );
      case ButtonSize.medium:
        return const EdgeInsets.symmetric(
          horizontal: AppTheme.spacingL,
          vertical: AppTheme.spacingM,
        );
      case ButtonSize.large:
        return const EdgeInsets.symmetric(
          horizontal: AppTheme.spacingL * 1.5,
          vertical: AppTheme.spacingM,
        );
    }
  }

  double _getFontSize() {
    switch (widget.size) {
      case ButtonSize.small:
        return 12;
      case ButtonSize.medium:
        return 14;
      case ButtonSize.large:
        return 16;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = _getButtonColors(context);
    final isDisabled = widget.onPressed == null || widget.isLoading;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        child: AnimatedContainer(
          duration: AppAnimations.fast,
          curve: AppAnimations.easeOut,
          width: widget.width,
          height: widget.height,
          transform: _isPressed
              ? Matrix4.diagonal3Values(0.98, 0.98, 1.0)
              : Matrix4.identity(),
          child: Container(
            decoration: BoxDecoration(
              color: isDisabled
                  ? colors.background.withValues(alpha: 0.5)
                  : _isHovered
                  ? colors.hoverBackground
                  : colors.background,
              borderRadius: BorderRadius.circular(widget.borderRadius),
              border: widget.variant == ButtonVariant.outline
                  ? Border.all(color: colors.border, width: 1.5)
                  : null,
              boxShadow:
                  !isDisabled &&
                      (widget.variant == ButtonVariant.primary ||
                          widget.variant == ButtonVariant.secondary)
                  ? [
                      BoxShadow(
                        color: colors.background.withValues(alpha: 0.3),
                        blurRadius: _isHovered ? 8 : 4,
                        offset: Offset(0, _isHovered ? 4 : 2),
                      ),
                    ]
                  : null,
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: isDisabled ? null : widget.onPressed,
                borderRadius: BorderRadius.circular(widget.borderRadius),
                child: Container(
                  padding: widget.padding ?? _getPadding(),
                  child: widget.isLoading && widget.showLoadingIndicator
                      ? SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              colors.foreground,
                            ),
                          ),
                        )
                      : Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (widget.icon != null) ...[
                              AnimatedRotation(
                                duration: AppAnimations.fast,
                                turns: _isHovered ? 0.02 : 0.0,
                                child: Icon(
                                  widget.icon,
                                  color: isDisabled
                                      ? colors.foreground.withValues(alpha: 0.5)
                                      : colors.foreground,
                                  size: widget.size == ButtonSize.small
                                      ? 16
                                      : 18,
                                ),
                              ),
                              const SizedBox(width: AppTheme.spacingS),
                            ],
                            AnimatedDefaultTextStyle(
                              duration: AppAnimations.fast,
                              style: TextStyle(
                                color: isDisabled
                                    ? colors.foreground.withValues(alpha: 0.5)
                                    : colors.foreground,
                                fontWeight: FontWeight.w600,
                                fontSize: _getFontSize(),
                              ),
                              child: Text(widget.text),
                            ),
                          ],
                        ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ButtonColors {
  final Color background;
  final Color foreground;
  final Color hoverBackground;
  final Color border;

  const ButtonColors({
    required this.background,
    required this.foreground,
    required this.hoverBackground,
    required this.border,
  });
}
