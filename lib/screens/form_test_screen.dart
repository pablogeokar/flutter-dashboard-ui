import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/form_fields.dart'; // Importa o barril com todos os widgets de formulário
import '../theme/theme_manager.dart'; // Para acessar o ThemeManager e alternar temas (opcional)
import '../theme/theme.dart'; // Para acessar as constantes de design system

/// Tela de teste para os widgets de formulário.
///
/// Esta tela exibe instâncias dos widgets `TextInputField`, `DateInputField`,
/// `MonetaryInputField` e `CustomButton` para verificar sua aparência nos modos
/// claro e escuro, utilizando o layout visual do dashboard.
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

  Widget _buildFormSection(
    BuildContext context, {
    required String title,
    required String subtitle,
    required List<Widget> children,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: AppTheme.spacingL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppTheme.spacingL,
              vertical: AppTheme.spacingM,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: Theme.of(context).brightness == Brightness.dark
                    ? [
                        AppTheme.neutral800.withValues(alpha: 0.4),
                        AppTheme.neutral800.withValues(alpha: 0.1),
                      ]
                    : [
                        AppTheme.neutral100.withValues(alpha: 0.8),
                        AppTheme.neutral50.withValues(alpha: 0.4),
                      ],
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              border: Border(
                left: BorderSide(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? AppTheme.neutral600
                      : Theme.of(context).colorScheme.primary,
                  width: 3,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.2,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(AppTheme.spacingL),
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark
                  ? AppTheme.neutral900.withValues(alpha: 0.3)
                  : Colors.white.withValues(alpha: 0.7),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              border: Border.all(
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppTheme.neutral700.withValues(alpha: 0.3)
                    : AppTheme.neutral200.withValues(alpha: 0.5),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teste de Widgets'),
        actions: [
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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: Theme.of(context).brightness == Brightness.dark
                ? [
                    AppTheme.surfaceDark,
                    AppTheme.surfaceDark.withValues(alpha: 0.95),
                  ]
                : [
                    AppTheme.surfaceLight,
                    AppTheme.surfaceLight.withValues(alpha: 0.98),
                  ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: Container(
              width: double.infinity,
              constraints: const BoxConstraints(maxWidth: 900),
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppTheme.neutral900.withValues(alpha: 0.8)
                    : Colors.white.withValues(alpha: 0.95),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? AppTheme.neutral700.withValues(alpha: 0.3)
                      : AppTheme.neutral200.withValues(alpha: 0.5),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.black.withValues(alpha: 0.4)
                        : Colors.black.withValues(alpha: 0.08),
                    blurRadius: 32,
                    offset: const Offset(0, 16),
                  ),
                  BoxShadow(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.black.withValues(alpha: 0.2)
                        : Colors.black.withValues(alpha: 0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(32.0),
                          margin: const EdgeInsets.only(bottom: 32.0),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors:
                                  Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? [
                                      AppTheme.neutral800.withValues(
                                        alpha: 0.6,
                                      ),
                                      AppTheme.neutral800.withValues(
                                        alpha: 0.3,
                                      ),
                                    ]
                                  : [
                                      AppTheme.neutral50,
                                      AppTheme.neutral100.withValues(
                                        alpha: 0.8,
                                      ),
                                    ],
                            ),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color:
                                  Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? AppTheme.neutral600.withValues(alpha: 0.3)
                                  : AppTheme.neutral300.withValues(alpha: 0.5),
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color:
                                    Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.black.withValues(alpha: 0.2)
                                    : Colors.black.withValues(alpha: 0.04),
                                blurRadius: 12,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors:
                                        Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? [
                                            AppTheme.neutral600,
                                            AppTheme.neutral700,
                                          ]
                                        : [
                                            Theme.of(
                                              context,
                                            ).colorScheme.primary,
                                            Theme.of(context)
                                                .colorScheme
                                                .primary
                                                .withValues(alpha: 0.8),
                                          ],
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.black.withValues(alpha: 0.3)
                                          : Theme.of(context)
                                                .colorScheme
                                                .primary
                                                .withValues(alpha: 0.2),
                                      blurRadius: 8,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  Icons.widgets_rounded,
                                  color:
                                      Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? AppTheme.neutral100
                                      : Colors.white,
                                  size: 28,
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
                                        fontSize: 24,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: -0.5,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.onSurface,
                                        height: 1.2,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Componentes premium com design sofisticado para aplicações corporativas de alto padrão',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: 0.1,
                                        height: 1.4,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface
                                            .withValues(alpha: 0.75),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        _buildFormSection(
                          context,
                          title: 'Campos de Entrada',
                          subtitle: 'Componentes premium para captura de dados',
                          children: [
                            TextInputField(
                              hintText: 'Digite seu nome completo',
                              labelText: 'Nome Completo',
                              controller: _textController,
                            ),
                            SizedBox(height: AppTheme.spacingL),
                            DateInputField(
                              label: 'Data de Nascimento',
                              initialValue: DateTime.now(),
                            ),
                            SizedBox(height: AppTheme.spacingL),
                            MonetaryInputField(
                              label: 'Valor de Investimento',
                              controller: _monetaryController,
                            ),
                          ],
                        ),
                        _buildFormSection(
                          context,
                          title: 'Seleção e Texto Longo',
                          subtitle: 'Componentes para escolhas e observações',
                          children: [
                            SelectInputField<String>(
                              labelText: 'Estado Civil',
                              hintText: 'Selecione seu estado civil',
                              options: const [
                                SelectOption(
                                  value: 'solteiro',
                                  label: 'Solteiro(a)',
                                ),
                                SelectOption(
                                  value: 'casado',
                                  label: 'Casado(a)',
                                ),
                                SelectOption(
                                  value: 'divorciado',
                                  label: 'Divorciado(a)',
                                ),
                                SelectOption(value: 'viuvo', label: 'Viúvo(a)'),
                              ],
                              onChanged: (value) {},
                            ),
                            SizedBox(height: AppTheme.spacingL),
                            TextAreaField(
                              labelText: 'Observações Importantes',
                              hintText:
                                  'Digite suas observações e comentários aqui...',
                              maxLength: 500,
                              onChanged: (value) {},
                            ),
                          ],
                        ),
                        _buildFormSection(
                          context,
                          title: 'Ações do Sistema',
                          subtitle: 'Botões e controles de interação',
                          children: [
                            Wrap(
                              spacing: AppTheme.spacingL,
                              runSpacing: AppTheme.spacingM,
                              children: [
                                CustomButton(
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Botão primário pressionado!',
                                        ),
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
                                        content: Text(
                                          'Botão outline pressionado!',
                                        ),
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
                                        content: Text(
                                          'Botão sucesso pressionado!',
                                        ),
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
                                        content: Text(
                                          'Botão erro pressionado!',
                                        ),
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
                      ],
                    ),
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
