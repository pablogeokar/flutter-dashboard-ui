import 'package:flutter/material.dart';
import '../widgets/form_fields.dart'; // Importa o barril com todos os widgets de formulário
import '../theme/theme_manager.dart'; // Para acessar o ThemeManager e alternar temas (opcional)

/// Tela de teste para os widgets de formulário.
/// 
/// Esta tela exibe instâncias dos widgets `TextInputField`, `DateInputField`, `MonetaryInputField` e `CustomButton`
/// para verificar sua aparência nos modos claro e escuro.
class FormTestScreen extends StatelessWidget {
  const FormTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teste de Widgets'),
        actions: [
          // Botão para alternar tema (opcional, para facilitar o teste)
          IconButton(
            icon: Icon(
              Theme.of(context).brightness == Brightness.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            onPressed: () {
              final themeManager = ThemeManager();
              themeManager.toggleTheme();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Widgets de Formulário',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),

            // TextInputField
            const Text('Input de Texto'),
            const SizedBox(height: 8),
            TextInputField(
              hintText: 'Digite seu nome',
              labelText: 'Nome',
              controller: TextEditingController(),
            ),
            const SizedBox(height: 24),

            // DateInputField
            const Text('Input de Data'),
            const SizedBox(height: 8),
            DateInputField(
              label: 'Data de Nascimento',
              initialValue: DateTime.now(),
            ),
            const SizedBox(height: 24),

            // MonetaryInputField
            const Text('Input de Valor Monetário'),
            const SizedBox(height: 8),
            MonetaryInputField(
              label: 'Valor',
              hintText: 'Digite o valor',
              controller: TextEditingController(),
            ),
            const SizedBox(height: 24),

            // CustomButton
            const Text('Botão Personalizado'),
            const SizedBox(height: 8),
            CustomButton(
              onPressed: () {
                // Lógica do botão
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Botão pressionado!')),
                );
              },
              text: 'Clique Aqui',
            ),
          ],
        ),
      ),
    );
  }
}