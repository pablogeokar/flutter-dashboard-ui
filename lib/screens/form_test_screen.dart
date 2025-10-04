import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/form_fields.dart'; // Importa o barril com todos os widgets de formulário
import '../theme/theme_manager.dart'; // Para acessar o ThemeManager e alternar temas (opcional)
import '../theme/theme.dart'; // Para acessar as constantes de design system

/// Tela de teste para os widgets de formulário.
///
/// Esta tela exibe instâncias dos widgets `TextInputField`, `DateInputField`, `MonetaryInputField` e `CustomButton`
/// para verificar sua aparência nos modos claro e escuro, utilizando o layout visual do dashboard.
class FormTestScreen extends StatefulWidget {
  const FormTestScreen({super.key});

  @override
  State<FormTestScreen> createState() => _FormTestScreenState();
}

class _FormTestScreenState extends State<FormTestScreen> {
  late final TextEditingController _textController;
  late final TextEditingController _monetaryController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    _monetaryController = TextEditingController();
  }

  @override
  void dispose() {
    _textController.dispose();
    _monetaryController.dispose();
    super.dispose();
  }

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
              final themeManager = Provider.of<ThemeManager>(
                context,
                listen: false,
              );
              themeManager.toggleTheme();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppTheme.spacingM),
        child: Center(
          child: Container(
            width: double.infinity,
            constraints: const BoxConstraints(
              maxWidth: 800,
            ), // Limita a largura máxima para telas grandes
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark
                  ? AppTheme.cardBackgroundDark
                  : AppTheme.cardBackgroundLight,
              borderRadius: BorderRadius.circular(AppTheme.borderRadiusXL),
              border: Border.all(
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppTheme.cardBorderDark
                    : AppTheme.cardBorderLight,
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? AppTheme.cardShadowDark
                      : AppTheme.cardShadowLight,
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppTheme.borderRadiusXL),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(AppTheme.spacingM),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(AppTheme.spacingM),
                        decoration: BoxDecoration(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? AppTheme.formFieldBackgroundDark.withValues(
                                  alpha: 0.3,
                                )
                              : AppTheme.formFieldBackgroundLight.withValues(
                                  alpha: 0.7,
                                ),
                          borderRadius: BorderRadius.circular(
                            AppTheme.borderRadiusL,
                          ),
                          border: Border.all(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                ? AppTheme.formFieldBorderDark.withValues(
                                    alpha: 0.5,
                                  )
                                : AppTheme.formFieldBorderLight,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(AppTheme.spacingS),
                              decoration: BoxDecoration(
                                color: Theme.of(
                                  context,
                                ).colorScheme.primary.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(
                                  AppTheme.borderRadiusS,
                                ),
                              ),
                              child: Icon(
                                Icons.widgets,
                                color: Theme.of(context).colorScheme.primary,
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: AppTheme.spacingM),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Widgets de Formulário',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onSurface,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Componentes com cores suaves inspiradas em dashboards modernos',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface
                                          .withValues(alpha: 0.7),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),

                      // TextInputField
                      const Text('Input de Texto'),
                      const SizedBox(height: 8),
                      TextInputField(
                        hintText: 'Digite seu nome',
                        labelText: 'Nome',
                        controller:
                            _textController, // Usa o controller do state
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
                        controller:
                            _monetaryController, // Usa o controller do state
                      ),
                      const SizedBox(height: 24),

                      // SelectInputField
                      const Text('Campo de Seleção'),
                      const SizedBox(height: 8),
                      SelectInputField<String>(
                        labelText: 'Estado Civil',
                        hintText: 'Selecione seu estado civil',
                        options: const [
                          SelectOption(value: 'solteiro', label: 'Solteiro(a)'),
                          SelectOption(value: 'casado', label: 'Casado(a)'),
                          SelectOption(
                            value: 'divorciado',
                            label: 'Divorciado(a)',
                          ),
                          SelectOption(value: 'viuvo', label: 'Viúvo(a)'),
                        ],
                        onChanged: (value) {
                          // Estado civil selecionado: $value
                        },
                      ),
                      const SizedBox(height: 24),

                      // TextAreaField
                      const Text('Área de Texto'),
                      const SizedBox(height: 8),
                      TextAreaField(
                        labelText: 'Observações',
                        hintText: 'Digite suas observações aqui...',
                        maxLength: 200,
                        onChanged: (value) {
                          // Observações: $value
                        },
                      ),
                      const SizedBox(height: 24),

                      // Botões com diferentes variantes
                      const Text('Botões Personalizados'),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: AppTheme.spacingM,
                        runSpacing: AppTheme.spacingS,
                        children: [
                          CustomButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Botão primário pressionado!'),
                                ),
                              );
                            },
                            text: 'Primário',
                            variant: ButtonVariant.primary,
                            icon: Icons.check,
                          ),
                          CustomButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Botão secundário pressionado!',
                                  ),
                                ),
                              );
                            },
                            text: 'Secundário',
                            variant: ButtonVariant.secondary,
                          ),
                          CustomButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Botão outline pressionado!'),
                                ),
                              );
                            },
                            text: 'Outline',
                            variant: ButtonVariant.outline,
                            icon: Icons.edit,
                          ),
                          CustomButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Botão sucesso pressionado!'),
                                ),
                              );
                            },
                            text: 'Sucesso',
                            variant: ButtonVariant.success,
                            icon: Icons.check_circle,
                            size: ButtonSize.small,
                          ),
                          CustomButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Botão erro pressionado!'),
                                ),
                              );
                            },
                            text: 'Erro',
                            variant: ButtonVariant.error,
                            icon: Icons.error,
                            size: ButtonSize.small,
                          ),
                        ],
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
