import 'package:flutter/material.dart';
import '../../../theme/theme.dart';

/// Widget de botão personalizado.
///
/// Este botão oferece um estilo consistente com a identidade visual do dashboard,
/// incluindo bordas arredondadas, sombras sutis e suporte a temas claro/escuro.
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final Color? color;
  final Color? textColor;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final IconData? icon;
  final bool showLoadingIndicator;
  final Widget? child; // Adiciona o parâmetro child opcional

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
    this.child, // Permite passar um widget filho opcional
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final primaryColor = isDarkMode
        ? AppTheme.primaryDark
        : AppTheme.primaryLight;
    final secondaryColor = isDarkMode
        ? AppTheme.secondaryDark
        : AppTheme.secondaryLight;

    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? primaryColor,
          foregroundColor: textColor ?? secondaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding:
              padding ??
              const EdgeInsets.symmetric(
                horizontal: AppTheme.spacingL,
                vertical: AppTheme.spacingS,
              ),
          shadowColor: Colors.black.withOpacity(0.1),
          elevation: 2.0,
        ),
        child: isLoading
            ? showLoadingIndicator
                  ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                  : Text(
                      text,
                      style: TextStyle(color: textColor ?? secondaryColor),
                    )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null)
                    Icon(icon, color: textColor ?? secondaryColor, size: 18),
                  if (icon != null) const SizedBox(width: 8.0),
                  Text(
                    text,
                    style: TextStyle(
                      color: textColor ?? secondaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
