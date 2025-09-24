import 'package:flutter/material.dart';
import '../theme.dart';

class TesteScreen extends StatelessWidget {
  const TesteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.widgets, size: 80, color: Colors.blue),
          SizedBox(height: AppTheme.spacingL), // 24 é 1.5 vezes spacingM (16)
          Text(
            'Tela de Teste',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: AppTheme.spacingM),
          Text(
            'Esta é uma tela de exemplo para testes',
            style: TextStyle(fontSize: 16, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
