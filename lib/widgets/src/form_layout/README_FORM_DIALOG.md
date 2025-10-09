# FormDialog - Sistema de Dialogs para Formulários

## Visão Geral

O `FormDialog` é um sistema completo de dialogs reutilizáveis para exibir formulários em qualquer parte da aplicação. Ele foi projetado para seguir o design system corporativo premium e oferece uma experiência de usuário consistente e elegante.

## Componentes Principais

### 1. FormDialog
Widget principal que renderiza o dialog com formulário.

### 2. FormDialogService
Serviço com métodos estáticos para facilitar a exibição de diferentes tipos de dialogs.

### 3. FormDialogButton
Botão que abre automaticamente um FormDialog quando pressionado.

## Como Usar

### Uso Básico com FormDialogService

```dart
import 'package:dashboard_ui/widgets/form_layout.dart';

// Dialog simples
FormDialogService.mostrarFormulario(
  context: context,
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
);
```

### Dialogs Específicos

```dart
// Cadastro de cliente
FormDialogService.mostrarCadastroCliente(
  context: context,
  onConfirmar: () => print('Cliente cadastrado!'),
);

// Cadastro de fornecedor
FormDialogService.mostrarCadastroFornecedor(
  context: context,
  onConfirmar: () => print('Fornecedor cadastrado!'),
);

// Dialog de busca
FormDialogService.mostrarBusca(
  context: context,
  titulo: 'Buscar Produtos',
  formularioBusca: MeuFormularioBusca(),
  onConfirmar: () => print('Busca realizada!'),
);

// Dialog de confirmação
FormDialogService.mostrarConfirmacao(
  context: context,
  titulo: 'Confirmar Exclusão',
  mensagem: 'Tem certeza que deseja excluir este item?',
  icone: Icons.warning,
  textoConfirmacao: 'Excluir',
  formulario: MeuFormularioConfirmacao(),
  onConfirmar: () => print('Item excluído!'),
);
```

### Uso com FormDialogButton

```dart
// Botão genérico
FormDialogButton(
  texto: 'Abrir Formulário',
  icone: Icons.edit,
  tituloDialog: 'Editar Dados',
  formulario: MeuFormularioWidget(),
  onConfirmar: () => print('Dados salvos!'),
)

// Botão de cadastro de cliente
FormDialogButton.cadastroCliente(
  onConfirmar: () => print('Cliente cadastrado!'),
)

// Botão de cadastro de fornecedor
FormDialogButton.cadastroFornecedor(
  onConfirmar: () => print('Fornecedor cadastrado!'),
)

// Botão de busca
FormDialogButton.busca(
  tituloDialog: 'Buscar Clientes',
  onConfirmar: () => print('Busca realizada!'),
)
```

## Parâmetros Principais

### FormDialog

- `titulo`: Título do dialog
- `subtitulo`: Descrição/subtítulo (opcional)
- `formulario`: Widget do formulário a ser exibido
- `textoConfirmacao`: Texto do botão de confirmação (padrão: "Confirmar")
- `textoCancelamento`: Texto do botão de cancelamento (padrão: "Cancelar")
- `onConfirmar`: Callback de confirmação
- `onCancelar`: Callback de cancelamento
- `mostrarCancelamento`: Se deve mostrar botão de cancelamento (padrão: true)
- `larguraMaxima`: Largura máxima do dialog
- `alturaMaxima`: Altura máxima do dialog
- `barrierDismissible`: Se pode fechar clicando fora (padrão: true)
- `icone`: Ícone do dialog

### FormDialogButton

- `texto`: Texto do botão
- `icone`: Ícone do botão
- `variant`: Variante do botão (primary, secondary, outline, success, error)
- `size`: Tamanho do botão (small, medium, large)
- `desabilitado`: Se o botão está desabilitado
- Todos os parâmetros do FormDialog

## Exemplos de Formulários

### Formulário Simples

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

### Formulário com Seções

```dart
Widget _buildFormularioComSecoes() {
  return SingleChildScrollView(
    child: Column(
      children: [
        _buildSecaoFormulario(
          titulo: 'Dados Pessoais',
          children: [
            TextInputField(labelText: 'Nome', controller: _nomeController),
            TextInputField(labelText: 'Email', controller: _emailController),
          ],
        ),
        const SizedBox(height: 24),
        _buildSecaoFormulario(
          titulo: 'Dados Profissionais',
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

## Características Premium

- **Design Corporativo**: Segue o design system premium da aplicação
- **Animações Suaves**: Transições elegantes de entrada e saída
- **Responsivo**: Adapta-se a diferentes tamanhos de tela
- **Acessível**: Suporte completo a navegação por teclado
- **Temas**: Suporte completo aos temas claro e escuro
- **Reutilizável**: Pode ser usado em qualquer parte da aplicação
- **Flexível**: Altamente customizável para diferentes necessidades

## Integração com Sidebar

O FormDialog está integrado com a sidebar através do item "Cadastros > Clientes", que agora exibe a tela `ExemploFormDialogScreen` com demonstrações de todos os tipos de dialogs disponíveis.

## Boas Práticas

1. **Use FormDialogService** para dialogs simples e rápidos
2. **Use FormDialogButton** para botões que sempre abrem o mesmo tipo de dialog
3. **Mantenha formulários simples** - use scroll se necessário
4. **Sempre forneça feedback** através dos callbacks onConfirmar/onCancelar
5. **Use ícones apropriados** para melhor identificação visual
6. **Teste em diferentes tamanhos de tela** para garantir responsividade
