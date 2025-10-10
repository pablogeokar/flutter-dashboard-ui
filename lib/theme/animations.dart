import 'package:flutter/material.dart';

/// Constantes para animações e transições da aplicação
class AppAnimations {
  // === DURAÇÕES ===
  static const Duration ultraFast = Duration(milliseconds: 100);
  static const Duration fast = Duration(milliseconds: 200);
  static const Duration normal = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);
  static const Duration verySlow = Duration(milliseconds: 800);

  // === CURVAS DE ANIMAÇÃO ===
  static const Curve easeInOut = Curves.easeInOut;
  static const Curve easeOut = Curves.easeOut;
  static const Curve easeIn = Curves.easeIn;
  static const Curve bounceOut = Curves.bounceOut;
  static const Curve elasticOut = Curves.elasticOut;
  static const Curve backOut = Curves.easeOutBack;
  static const Curve cubicOut = Curves.easeOutCubic;

  // === TRANSFORMAÇÕES MICRO-INTERATIVAS ===

  /// Escala sutil para hover
  static Matrix4 get hoverScale => Matrix4.identity()..scale(1.03);

  /// Escala mais dramática para botões
  static Matrix4 get buttonHoverScale => Matrix4.identity()..scale(1.08);

  /// Movimento lateral sutil
  static Matrix4 get slideRight => Matrix4.identity()..translate(4.0, 0.0, 0.0);

  /// Rotação sutil para ícones
  static Matrix4 get iconRotation => Matrix4.identity()..rotateZ(0.05);

  /// Combinação de escala + rotação + movimento
  static Matrix4 get dramaticHover => Matrix4.identity()
    ..scale(1.03)
    ..rotateZ(0.02)
    ..translate(2.0, 0.0, 0.0);

  // === TRANSIÇÕES PERSONALIZADAS ===

  /// Transição suave para mudança de páginas
  static Widget slideTransition({
    required Widget child,
    required Animation<double> animation,
    Offset begin = const Offset(1.0, 0.0),
  }) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: begin,
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: animation, curve: easeInOut)),
      child: child,
    );
  }

  /// Transição de fade com escala
  static Widget fadeScaleTransition({
    required Widget child,
    required Animation<double> animation,
  }) {
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: Tween<double>(
          begin: 0.95,
          end: 1.0,
        ).animate(CurvedAnimation(parent: animation, curve: easeOut)),
        child: child,
      ),
    );
  }

  /// Animação de hover para botões
  static AnimatedContainer hoverContainer({
    required Widget child,
    required bool isHovered,
    Color? hoverColor,
    double? elevation,
  }) {
    return AnimatedContainer(
      duration: fast,
      curve: easeOut,
      decoration: BoxDecoration(
        color: isHovered ? hoverColor : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        boxShadow: isHovered && elevation != null
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: elevation,
                  offset: Offset(0, elevation / 2),
                ),
              ]
            : null,
      ),
      child: child,
    );
  }

  /// Animação de pulsação para indicadores
  static Widget pulseAnimation({
    required Widget child,
    Duration duration = const Duration(seconds: 2),
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.8, end: 1.0),
      duration: duration,
      builder: (context, value, child) {
        return Transform.scale(scale: value, child: child);
      },
      child: child,
    );
  }
}
