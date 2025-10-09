import 'package:flutter/material.dart';
import '../widgets/form_layout.dart';
import '../widgets/dialog.dart';
import '../theme/theme.dart';

/// Tela de exemplo mostrando como usar o FormDialog
class ExemploFormDialogScreen extends StatefulWidget {
  const ExemploFormDialogScreen({super.key});

  @override
  State<ExemploFormDialogScreen> createState() =>
      _ExemploFormDialogScreenState();
}

class _ExemploFormDialogScreenState extends State<ExemploFormDialogScreen> {
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

  /// Exemplo 1: Dialog simples com formulário customizado
  void _mostrarDialogSimples() {
    FormDialogService.mostrarFormulario(
      context: context,
      titulo: 'Formulário Simples',
      subtitulo: 'Exemplo de dialog com formulário customizado',
      icone: Icons.edit,
      larguraMaxima: 500,
      onConfirmar: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Formulário confirmado!'),
            backgroundColor: Colors.green,
          ),
        );
      },
      onCancelar: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Formulário cancelado!'),
            backgroundColor: Colors.orange,
          ),
        );
      },
      formulario: _buildFormularioSimples(),
    );
  }

  /// Exemplo 2: Dialog de cadastro de cliente
  void _mostrarDialogCliente() {
    FormDialogService.mostrarCadastroCliente(
      context: context,
      onConfirmar: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Cliente cadastrado com sucesso!'),
            backgroundColor: Colors.green,
          ),
        );
      },
    );
  }

  /// Exemplo 3: Dialog de busca
  void _mostrarDialogBusca() {
    FormDialogService.mostrarBusca(
      context: context,
      titulo: 'Buscar Clientes',
      onConfirmar: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Busca realizada!'),
            backgroundColor: Colors.blue,
          ),
        );
      },
      formularioBusca: _buildFormularioBusca(),
    );
  }

  /// Exemplo 4: Dialog de confirmação
  void _mostrarDialogConfirmacao() {
    FormDialogService.mostrarConfirmacao(
      context: context,
      titulo: 'Confirmar Exclusão',
      mensagem: 'Tem certeza que deseja excluir este item?',
      icone: Icons.warning,
      textoConfirmacao: 'Excluir',
      textoCancelamento: 'Cancelar',
      onConfirmar: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Item excluído!'),
            backgroundColor: Colors.red,
          ),
        );
      },
    );
  }

  /// Exemplo 5: Dialog com formulário completo
  void _mostrarDialogCompleto() {
    FormDialogService.mostrarFormulario(
      context: context,
      titulo: 'Cadastro Completo',
      subtitulo: 'Preencha todos os dados necessários',
      icone: Icons.person_add,
      larguraMaxima: 700,
      alturaMaxima: 600,
      onConfirmar: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Cadastro realizado com sucesso!'),
            backgroundColor: Colors.green,
          ),
        );
      },
      formulario: _buildFormularioCompleto(),
    );
  }

  Widget _buildFormularioSimples() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextInputField(
          labelText: 'Nome',
          hintText: 'Digite seu nome',
          controller: _nomeController,
        ),
        const SizedBox(height: 16),
        TextInputField(
          labelText: 'Email',
          hintText: 'Digite seu email',
          controller: _emailController,
        ),
      ],
    );
  }

  Widget _buildFormularioBusca() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextInputField(
          labelText: 'Nome do Cliente',
          hintText: 'Digite o nome para buscar',
          controller: _nomeController,
        ),
        const SizedBox(height: 16),
        SelectInputField<String>(
          labelText: 'Status',
          hintText: 'Selecione o status',
          options: const [
            SelectOption(value: 'ativo', label: 'Ativo'),
            SelectOption(value: 'inativo', label: 'Inativo'),
            SelectOption(value: 'todos', label: 'Todos'),
          ],
          onChanged: (value) {},
        ),
      ],
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
        ],
      ),
    );
  }

  Widget _buildSecaoFormulario({
    required String titulo,
    required List<Widget> children,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
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
          Text(
            titulo,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 16),
          ...children,
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
                // Header
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
                        child: const Icon(
                          Icons.widgets,
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
                              'Exemplos de FormDialog',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Demonstração dos diferentes tipos de dialogs de formulário disponíveis',
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

                // Botões de exemplo
                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    CustomButton(
                      onPressed: _mostrarDialogSimples,
                      text: 'Dialog Simples',
                      variant: ButtonVariant.primary,
                      icon: Icons.edit,
                    ),
                    CustomButton(
                      onPressed: _mostrarDialogCliente,
                      text: 'Cadastro Cliente',
                      variant: ButtonVariant.secondary,
                      icon: Icons.person_add,
                    ),
                    CustomButton(
                      onPressed: _mostrarDialogBusca,
                      text: 'Dialog de Busca',
                      variant: ButtonVariant.outline,
                      icon: Icons.search,
                    ),
                    CustomButton(
                      onPressed: _mostrarDialogConfirmacao,
                      text: 'Dialog Confirmação',
                      variant: ButtonVariant.error,
                      icon: Icons.warning,
                    ),
                    CustomButton(
                      onPressed: _mostrarDialogCompleto,
                      text: 'Dialog Completo',
                      variant: ButtonVariant.success,
                      icon: Icons.assignment,
                    ),
                  ],
                ),

                const SizedBox(height: 32),

                // Instruções
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? AppTheme.neutral800.withValues(alpha: 0.2)
                        : AppTheme.neutral100.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? AppTheme.primaryDark.withValues(alpha: 0.2)
                          : AppTheme.primaryLight.withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: Theme.of(context).colorScheme.primary,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Como Usar',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        '• Use FormDialogService.mostrarFormulario() para dialogs customizados\n'
                        '• Use FormDialogService.mostrarCadastroCliente() para cadastro de clientes\n'
                        '• Use FormDialogService.mostrarBusca() para dialogs de busca\n'
                        '• Use FormDialogService.mostrarConfirmacao() para confirmações\n'
                        '• Todos os dialogs são responsivos e seguem o design system',
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
