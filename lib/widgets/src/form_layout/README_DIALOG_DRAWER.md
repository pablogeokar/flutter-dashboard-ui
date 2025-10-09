# Como Usar Dialogs Diretamente na Drawer

## Visão Geral

Este guia mostra como configurar itens da drawer que abrem dialogs diretamente, sem precisar navegar para uma tela intermediária.

## 🎯 **Métodos Disponíveis**

### **1. Usando DialogTriggerWidget (Recomendado)**

O `DialogTriggerWidget` é um widget especial que chama um dialog automaticamente quando é exibido.

```dart
import 'package:dashboard_ui/widgets/form_layout.dart';

// Na configuração da sidebar
DrawerItem(
  title: 'Cadastro de Cliente',
  icon: Icons.person_add,
  screen: DialogTriggerWidget(
    titulo: 'Cadastro de Cliente',
    subtitulo: 'Preencha os dados do novo cliente',
    icone: Icons.person_add,
    larguraMaxima: 700,
    onConfirmar: () {
      // Lógica de confirmação
      print('Cliente cadastrado!');
    },
    onCancelar: () {
      // Lógica de cancelamento
      print('Cadastro cancelado!');
    },
    formulario: MeuFormularioWidget(),
  ),
)
```

### **2. Usando DialogTriggers (Pré-configurados)**

Para casos comuns, use os widgets pré-configurados:

```dart
// Cadastro de cliente
DrawerItem(
  title: 'Clientes',
  icon: Icons.people,
  screen: DialogTriggers.cadastroCliente(
    onConfirmar: () => print('Cliente cadastrado!'),
  ),
)

// Cadastro de fornecedor
DrawerItem(
  title: 'Fornecedores',
  icon: Icons.business,
  screen: DialogTriggers.cadastroFornecedor(
    onConfirmar: () => print('Fornecedor cadastrado!'),
  ),
)

// Configurações
DrawerItem(
  title: 'Configurações',
  icon: Icons.settings,
  screen: DialogTriggers.configuracoes(
    onConfirmar: () => print('Configurações salvas!'),
  ),
)

// Busca customizada
DrawerItem(
  title: 'Buscar',
  icon: Icons.search,
  screen: DialogTriggers.busca(
    titulo: 'Buscar Produtos',
    formularioBusca: MeuFormularioBusca(),
    onConfirmar: () => print('Busca realizada!'),
  ),
)
```

### **3. Usando FormDialogService (Avançado)**

Para controle total, use o `FormDialogService` em uma tela customizada:

```dart
class MinhaTelaDialog extends StatefulWidget {
  @override
  State<MinhaTelaDialog> createState() => _MinhaTelaDialogState();
}

class _MinhaTelaDialogState extends State<MinhaTelaDialog> {
  @override
  void initState() {
    super.initState();
    // Chama o dialog quando a tela é carregada
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _mostrarDialog();
    });
  }

  void _mostrarDialog() {
    FormDialogService.mostrarFormulario(
      context: context,
      titulo: 'Meu Dialog Customizado',
      formulario: MeuFormularioWidget(),
      onConfirmar: () {
        // Lógica de confirmação
        Navigator.of(context).pop(); // Volta para a tela anterior
      },
      onCancelar: () {
        // Lógica de cancelamento
        Navigator.of(context).pop(); // Volta para a tela anterior
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink(); // Widget vazio
  }
}

// Na configuração da sidebar
DrawerItem(
  title: 'Meu Dialog',
  icon: Icons.dialog,
  screen: MinhaTelaDialog(),
)
```

## 📝 **Exemplo Completo de Configuração**

```dart
// lib/config/sidebar_config.dart
import 'package:dashboard_ui/widgets/form_layout.dart';

class SidebarConfig {
  static const List<DrawerItem> itensPrincipais = [
    DrawerItem(
      title: 'Painel Principal',
      icon: Icons.dashboard,
      screen: EmConstrucaoPlaceholder(),
    ),
    DrawerItem(
      title: 'Cadastros',
      icon: Icons.edit_document,
      subItems: [
        // Dialog direto para clientes
        DrawerItem(
          title: 'Clientes',
          icon: Icons.people,
          screen: DialogTriggers.cadastroCliente(
            onConfirmar: () {
              // Lógica de confirmação
              print('Cliente cadastrado!');
            },
          ),
        ),
        // Dialog direto para fornecedores
        DrawerItem(
          title: 'Fornecedores',
          icon: Icons.business,
          screen: DialogTriggers.cadastroFornecedor(
            onConfirmar: () {
              // Lógica de confirmação
              print('Fornecedor cadastrado!');
            },
          ),
        ),
        // Dialog customizado para produtos
        DrawerItem(
          title: 'Produtos',
          icon: Icons.inventory,
          screen: DialogTriggerWidget(
            titulo: 'Cadastro de Produto',
            subtitulo: 'Preencha os dados do novo produto',
            icone: Icons.inventory,
            larguraMaxima: 800,
            onConfirmar: () {
              // Lógica de confirmação
              print('Produto cadastrado!');
            },
            formulario: MeuFormularioProduto(),
          ),
        ),
      ],
    ),
  ];

  static const List<DrawerItem> itensInferiores = [
    // Dialog direto para configurações
    DrawerItem(
      title: 'Configurações',
      icon: Icons.settings,
      screen: DialogTriggers.configuracoes(
        onConfirmar: () {
          // Lógica de confirmação
          print('Configurações salvas!');
        },
      ),
    ),
  ];
}
```

## 🎨 **Criando Formulários Customizados**

### **Formulário Simples**

```dart
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
```

### **Formulário com Seções**

```dart
Widget _buildFormularioComSecoes() {
  return SingleChildScrollView(
    child: Column(
      children: [
        _buildSecaoFormulario(
          titulo: 'Dados Pessoais',
          icone: Icons.person,
          children: [
            TextInputField(labelText: 'Nome', controller: _nomeController),
            TextInputField(labelText: 'Email', controller: _emailController),
          ],
        ),
        const SizedBox(height: 24),
        _buildSecaoFormulario(
          titulo: 'Dados Profissionais',
          icone: Icons.work,
          children: [
            SelectInputField<String>(
              labelText: 'Cargo',
              options: [
                SelectOption(value: 'gerente', label: 'Gerente'),
                SelectOption(value: 'analista', label: 'Analista'),
              ],
              onChanged: (value) {},
            ),
          ],
        ),
      ],
    ),
  );
}
```

## ⚡ **Vantagens dos Dialogs na Drawer**

1. **Experiência Fluida**: Usuário não precisa navegar para uma tela intermediária
2. **Foco no Conteúdo**: Dialog mantém o foco na ação específica
3. **Navegação Intuitiva**: Volta automaticamente para a tela anterior
4. **Performance**: Não carrega telas desnecessárias
5. **Consistência**: Mantém o design system em todos os dialogs

## 🔧 **Configurações Avançadas**

### **Parâmetros do DialogTriggerWidget**

```dart
DialogTriggerWidget(
  titulo: 'Título do Dialog',
  subtitulo: 'Descrição opcional',
  icone: Icons.edit, // Ícone do dialog
  larguraMaxima: 700, // Largura máxima
  alturaMaxima: 600, // Altura máxima
  textoConfirmacao: 'Salvar', // Texto do botão confirmar
  textoCancelamento: 'Cancelar', // Texto do botão cancelar
  mostrarCancelamento: true, // Mostrar botão cancelar
  barrierDismissible: true, // Pode fechar clicando fora
  onConfirmar: () {
    // Callback de confirmação
  },
  onCancelar: () {
    // Callback de cancelamento
  },
  formulario: MeuFormularioWidget(),
)
```

## 🚀 **Próximos Passos**

1. **Teste os exemplos** fornecidos
2. **Crie seus próprios formulários** customizados
3. **Configure callbacks** para integração com sua lógica de negócio
4. **Personalize o design** conforme necessário
5. **Adicione validações** nos formulários

## 📚 **Recursos Relacionados**

- [FormDialog - Documentação Completa](README_FORM_DIALOG.md)
- [FormDialogService - Métodos Disponíveis](form_dialog_service.dart)
- [FormDialogButton - Botões que Abrem Dialogs](form_dialog_button.dart)
