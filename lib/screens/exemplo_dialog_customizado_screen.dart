import 'package:flutter/material.dart';
import '../widgets/form_layout.dart';
import '../widgets/dialog.dart';
import '../theme/theme.dart';

/// Exemplo de como criar um dialog customizado para usar na drawer
class ExemploDialogCustomizadoScreen extends StatefulWidget {
  const ExemploDialogCustomizadoScreen({super.key});

  @override
  State<ExemploDialogCustomizadoScreen> createState() =>
      _ExemploDialogCustomizadoScreenState();
}

class _ExemploDialogCustomizadoScreenState
    extends State<ExemploDialogCustomizadoScreen> {
  late final TextEditingController _nomeController;
  late final TextEditingController _emailController;
  late final TextEditingController _telefoneController;

  @override
  void initState() {
    super.initState();
    _nomeController = TextEditingController();
    _emailController = TextEditingController();
    _telefoneController = TextEditingController();
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _telefoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DialogTriggerWidget(
      titulo: 'Cadastro de Cliente Avançado',
      subtitulo: 'Preencha todos os dados necessários para o cadastro',
      icone: Icons.person_add,
      larguraMaxima: 800,
      alturaMaxima: 600,
      onConfirmar: () {
        // Lógica de confirmação
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Cliente cadastrado com sucesso!'),
            backgroundColor: Colors.green,
          ),
        );
      },
      onCancelar: () {
        // Lógica de cancelamento
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Cadastro cancelado!'),
            backgroundColor: Colors.orange,
          ),
        );
      },
      formulario: _buildFormularioCompleto(),
    );
  }

  Widget _buildFormularioCompleto() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Seção de dados pessoais
          _buildSecaoFormulario(
            titulo: 'Dados Pessoais',
            icone: Icons.person,
            children: [
              TextInputField(
                labelText: 'Nome Completo',
                hintText: 'Digite o nome completo',
                controller: _nomeController,
              ),
              const SizedBox(height: 16),
              TextInputField(
                labelText: 'Email',
                hintText: 'Digite o email',
                controller: _emailController,
              ),
              const SizedBox(height: 16),
              TextInputField(
                labelText: 'Telefone',
                hintText: 'Digite o telefone',
                controller: _telefoneController,
              ),
              const SizedBox(height: 16),
              DateInputField(
                label: 'Data de Nascimento',
                initialValue: DateTime.now(),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Seção de dados profissionais
          _buildSecaoFormulario(
            titulo: 'Dados Profissionais',
            icone: Icons.work,
            children: [
              SelectInputField<String>(
                labelText: 'Cargo',
                hintText: 'Selecione o cargo',
                options: const [
                  SelectOption(value: 'gerente', label: 'Gerente'),
                  SelectOption(value: 'analista', label: 'Analista'),
                  SelectOption(value: 'desenvolvedor', label: 'Desenvolvedor'),
                  SelectOption(value: 'designer', label: 'Designer'),
                ],
                onChanged: (value) {},
              ),
              const SizedBox(height: 16),
              MonetaryInputField(
                label: 'Salário Pretendido',
                controller: TextEditingController(),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Seção de observações
          _buildSecaoFormulario(
            titulo: 'Observações',
            icone: Icons.note,
            children: [
              TextAreaField(
                labelText: 'Observações Importantes',
                hintText: 'Digite suas observações e comentários aqui...',
                maxLength: 500,
                onChanged: (value) {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSecaoFormulario({
    required String titulo,
    required IconData icone,
    required List<Widget> children,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? AppTheme.neutral800.withValues(alpha: 0.3)
            : AppTheme.neutral50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).brightness == Brightness.dark
              ? AppTheme.neutral700.withValues(alpha: 0.3)
              : AppTheme.neutral200,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Theme.of(
                    context,
                  ).colorScheme.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icone,
                  size: 20,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                titulo,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }
}
