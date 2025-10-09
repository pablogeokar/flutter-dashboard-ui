import 'package:flutter/material.dart';
import '../widgets/form_layout.dart';
import '../theme/theme.dart';

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

  Widget _buildFormSection({
    required String title,
    required String subtitle,
    required List<Widget> children,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: AppTheme.spacingL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header da seção - mais sutil
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppTheme.spacingL,
              vertical: AppTheme.spacingM,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark
                  ? AppTheme.neutral800.withValues(alpha: 0.3)
                  : AppTheme.neutral100.withValues(alpha: 0.6),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              border: Border(
                left: BorderSide(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? AppTheme.primaryDark.withValues(alpha: 0.6)
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
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Theme.of(context).colorScheme.onSurface
                        : Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 13,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          ),
          // Conteúdo da seção - limpo
          Container(
            padding: EdgeInsets.all(AppTheme.spacingL),
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark
                  ? AppTheme.neutral800.withValues(alpha: 0.15)
                  : Colors.white.withValues(alpha: 0.9),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
              border: Border.all(
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppTheme.neutral700.withValues(alpha: 0.2)
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
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Container(
            width: double.infinity,
            constraints: const BoxConstraints(maxWidth: 800),
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark
                  ? AppTheme.drawerBackgroundDark
                  : Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Theme.of(context).brightness == Brightness.dark
                  ? Border.all(
                      color: AppTheme.primaryDark.withValues(alpha: 0.15),
                      width: 1,
                    )
                  : null,
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.black.withValues(alpha: 0.3)
                      : Colors.black.withValues(alpha: 0.06),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header principal - elegante mas sutil
                Container(
                  padding: const EdgeInsets.all(24.0),
                  margin: const EdgeInsets.only(bottom: 32.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? AppTheme.neutral800.withValues(alpha: 0.4)
                        : AppTheme.neutral50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? AppTheme.primaryDark.withValues(alpha: 0.2)
                          : AppTheme.neutral200,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? AppTheme.primaryDark.withValues(alpha: 0.8)
                              : Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color:
                                  Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? AppTheme.primaryDark.withValues(alpha: 0.2)
                                  : Theme.of(context).colorScheme.primary
                                        .withValues(alpha: 0.2),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.widgets_rounded,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Widgets de Formulário',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Componentes premium com design sofisticado para aplicações corporativas',
                              style: TextStyle(
                                fontSize: 15,
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurface.withValues(alpha: 0.75),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Seções de formulário
                _buildFormSection(
                  title: 'Campos de Entrada',
                  subtitle: 'Componentes para captura de dados',
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
                  title: 'Seleção e Texto Longo',
                  subtitle: 'Componentes para escolhas e observações',
                  children: [
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
                      onChanged: (value) {},
                    ),
                    SizedBox(height: AppTheme.spacingL),
                    TextAreaField(
                      labelText: 'Observações Importantes',
                      hintText: 'Digite suas observações e comentários aqui...',
                      maxLength: 500,
                      onChanged: (value) {},
                    ),
                  ],
                ),

                _buildFormSection(
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
                                content: Text('Botão secundário pressionado!'),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
