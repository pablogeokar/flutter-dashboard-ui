import 'package:flutter/material.dart';
import '../screens/splash_screen.dart';
import 'app_layout.dart';

/// Widget responsável por gerenciar o estado de inicialização da aplicação
class AppInitializer extends StatefulWidget {
  const AppInitializer({super.key});

  @override
  State<AppInitializer> createState() => _AppInitializerState();
}

class _AppInitializerState extends State<AppInitializer> {
  bool _isInitialized = false;

  void _onInitializationComplete() {
    setState(() {
      _isInitialized = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return SplashScreen(onInitializationComplete: _onInitializationComplete);
    }

    return const AppLayout();
  }
}
