import 'dart:async';
import 'package:flutter/material.dart';

/// Enum para definir o tipo de SnackBar.
enum SnackBarType { success, warning, error, info }

/// Um serviço para exibir SnackBars personalizados no topo da tela.
///
/// Este serviço utiliza um [Overlay] para exibir um widget de feedback customizado,
/// posicionado no topo, com largura controlada e visual moderno.
///
/// LOCALIZAÇÃO: lib/widgets/src/feedback/
class SnackBarService {
  static OverlayEntry? _overlayEntry;
  static Timer? _timer;

  /// Mostra um feedback no topo da tela com um estilo pré-definido.
  static void show(
    BuildContext context, {
    required String message,
    required SnackBarType type,
  }) {
    // Cancela e remove qualquer feedback anterior para evitar sobreposição.
    hide();

    final Color backgroundColor;
    final IconData iconData;
    final Duration duration;

    switch (type) {
      case SnackBarType.success:
        backgroundColor = Colors.green;
        iconData = Icons.check_circle_outline;
        duration = const Duration(seconds: 3);
        break;
      case SnackBarType.warning:
        backgroundColor = Colors.orange;
        iconData = Icons.warning_amber_outlined;
        duration = const Duration(seconds: 4);
        break;
      case SnackBarType.error:
        backgroundColor = Colors.red;
        iconData = Icons.error_outline;
        duration = const Duration(seconds: 5);
        break;
      case SnackBarType.info:
        backgroundColor = Colors.blue;
        iconData = Icons.info_outline;
        duration = const Duration(seconds: 3);
        break;
    }

    final overlay = Overlay.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final snackbarWidth = screenWidth < 640 ? screenWidth * 0.9 : 600.0;

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 40.0,
        left: (screenWidth - snackbarWidth) / 2,
        width: snackbarWidth,
        child: Material(
          elevation: 8.0,
          borderRadius: BorderRadius.circular(12.0),
          color: backgroundColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 12.0,
            ),
            child: Row(
              children: [
                Icon(iconData, color: Colors.white, size: 28),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    message,
                    style: const TextStyle(color: Colors.white, fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    overlay.insert(_overlayEntry!);

    // Agenda o desaparecimento do feedback.
    _timer = Timer(duration, hide);
  }

  /// Remove o feedback da tela.
  static void hide() {
    _timer?.cancel();
    _timer = null;
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
  }

  /// Mostra um feedback de sucesso.
  static void showSuccess(BuildContext context, {required String message}) {
    show(context, message: message, type: SnackBarType.success);
  }

  /// Mostra um feedback de aviso.
  static void showWarning(BuildContext context, {required String message}) {
    show(context, message: message, type: SnackBarType.warning);
  }

  /// Mostra um feedback de erro.
  static void showError(BuildContext context, {required String message}) {
    show(context, message: message, type: SnackBarType.error);
  }

  /// Mostra um feedback de informação.
  static void showInfo(BuildContext context, {required String message}) {
    show(context, message: message, type: SnackBarType.info);
  }
}
