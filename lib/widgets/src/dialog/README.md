# 💬 Sistema de Dialogs - Domani Fiscal

Sistema completo para criação e gerenciamento de dialogs modais profissionais.

## 📁 Estrutura de Arquivos

```
dialog/
├── README.md                # Esta documentação
├── form_dialog.dart        # Widget base para dialogs de formulário
├── form_dialog_service.dart # Serviços e formulários pré-configurados
└── dialog_callbacks.dart   # Callbacks e integrações
```

## 🎯 Componentes Principais

### 1. **FormDialog** - Widget Base

Dialog reutilizável com header, conteúdo scrollável e footer.

```dart
FormDialog(
  titulo: 'Cadastro de Cliente',
  subtitulo: 'Preencha os dados do novo cliente',
  icone: Icons.person_add,
  formulario: _buildFormulario(),
  onConfirmar: () => _salvarCliente(),
  onCancelar: () => Navigator.pop(context),
)
```

**Características:**

- ✅ Header fixo com título, subtítulo e ícone
- ✅ Conteúdo com scroll automático
- ✅ Footer fixo com botões de ação
- ✅ Animações suaves de entrada/saída
- ✅ Responsivo e acessível

### 2. **FormDialogService** - Serviços Pré-configurados

Métodos estáticos para dialogs comuns do sistema.

```dart
// Cadastro de cliente
FormDialogService.mostrarCadastroCliente(
  context: context,
  onConfirmar: () => _processarCadastro(),
);

// Cadastro de fornecedor
FormDialogService.mostrarCadastroFornecedor(
  context: context,
  onConfirmar: () => _processarFornecedor(),
);

// Configurações do sistema
FormDialogService.mostrarConfiguracoes(
  context: context,
  onConfirmar: () => _salvarConfiguracoes(),
);
```

### 3. **DialogCallbacks** - Integrações

Callbacks pré-configurados para uso na sidebar e menus.

```dart
// Para uso em DrawerItem
DrawerItem(
  title: 'Clientes',
  icon: Icons.people_rounded,
  onDialogTap: DialogCallbacks.cadastroCliente(context),
)
```

## 🎨 Anatomia de um Dialog

```
┌─────────────────────────────────────────┐
│ HEADER (Fixo)                           │
│ ┌─────┐ Título do Dialog            [×] │
│ │ 🔧  │ Subtítulo explicativo           │
│ └─────┘                                 │
├─────────────────────────────────────────┤
│ CONTEÚDO (Scrollável)                   │
│                                         │
│ ┌─────────────────────────────────────┐ │
│ │                                     │ │
│ │        Formulário ou conteúdo       │ │
│ │                                     │ │
│ │     (Scroll automático quando       │ │
│ │      necessário)                    │ │
│ │                                     │ │
│ └─────────────────────────────────────┘ │
│                                         │
├─────────────────────────────────────────┤
│ FOOTER (Fixo)                           │
│                    [Cancelar] [Confirmar] │
└─────────────────────────────────────────┘
```

## 📖 Exemplos de Uso

### Dialog Personalizado

```dart
await FormDialogService.mostrarFormulario(
  context: context,
  titulo: 'Meu Dialog Customizado',
  subtitulo: 'Descrição do que o dialog faz',
  icone: Icons.custom_icon,
  larguraMaxima: 800,
  alturaMaxima: 600,
  formulario: Column(
    children: [
      DomaniTextField(label: 'Campo 1'),
      SizedBox(height: 20),
      FormRow.top(
        children: [
          DomaniTextField(label: 'Campo 2'),
          DomaniTextField(label: 'Campo 3'),
        ],
      ),
    ],
  ),
  onConfirmar: () {
    // Lógica de confirmação
    print('Dialog confirmado!');
  },
  onCancelar: () {
    // Lógica de cancelamento (opcional)
    print('Dialog cancelado!');
  },
);
```

### Dialog de Confirmação

```dart
await FormDialogService.mostrarConfirmacao(
  context: context,
  titulo: 'Confirmar Exclusão',
  mensagem: 'Tem certeza que deseja excluir este cliente?',
  textoConfirmacao: 'Excluir',
  textoCancelamento: 'Cancelar',
  icone: Icons.warning,
  onConfirmar: () => _excluirCliente(),
);
```

### Dialog de Busca

```dart
await FormDialogService.mostrarBusca(
  context: context,
  titulo: 'Buscar Cliente',
  formularioBusca: Column(
    children: [
      DomaniTextField(label: 'Nome'),
      SizedBox(height: 16),
      FormRow.top(
        children: [
          DomaniTextField(label: 'CPF/CNPJ'),
          DomaniTextField(label: 'Telefone'),
        ],
      ),
    ],
  ),
  onConfirmar: () => _executarBusca(),
);
```

## 🎨 Padrões de Design

### Tamanhos Padrão

- **Pequeno:** 400px (confirmações, alertas)
- **Médio:** 600px (configurações, busca)
- **Grande:** 700px (cadastros complexos)
- **Extra Grande:** 800px+ (formulários extensos)

### Ícones Recomendados

- **Cadastros:** `Icons.person_add`, `Icons.business`
- **Configurações:** `Icons.settings`
- **Busca:** `Icons.search`
- **Confirmação:** `Icons.help_outline`, `Icons.warning`
- **Erro:** `Icons.error_outline`
- **Sucesso:** `Icons.check_circle_outline`

### Textos de Botões

- **Confirmação padrão:** "Confirmar"
- **Cancelamento padrão:** "Cancelar"
- **Salvamento:** "Salvar"
- **Exclusão:** "Excluir"
- **Busca:** "Buscar"

## 🔧 Configurações Avançadas

### Responsividade

```dart
FormDialogService.mostrarFormulario(
  context: context,
  titulo: 'Dialog Responsivo',
  larguraMaxima: MediaQuery.of(context).size.width * 0.9, // 90% da tela
  alturaMaxima: MediaQuery.of(context).size.height * 0.8, // 80% da tela
  formulario: _buildFormulario(),
);
```

### Validação e Estados

```dart
class _MeuDialogState extends State<MeuDialog> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  Future<void> _confirmar() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isLoading = true);

      try {
        await _processarDados();
        Navigator.of(context).pop();
      } catch (e) {
        _mostrarErro(e.toString());
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }
}
```

### Animações Customizadas

```dart
// As animações são configuradas automaticamente no FormDialog
// Duração: 300ms
// Curva: easeOut
// Efeitos: Scale + Fade
```

## 🚀 Melhores Práticas

### ✅ Faça

- Use títulos claros e descritivos
- Inclua subtítulos explicativos quando necessário
- Escolha ícones apropriados para o contexto
- Mantenha formulários organizados com FormRow
- Implemente validação adequada
- Forneça feedback visual durante operações
- Use tamanhos apropriados para o conteúdo

### ❌ Evite

- Dialogs muito grandes (> 90% da tela)
- Formulários sem validação
- Títulos genéricos ("Dialog", "Formulário")
- Muitos campos sem organização
- Operações longas sem feedback
- Dialogs aninhados (dialog dentro de dialog)
- Textos de botão confusos

## 🐛 Solução de Problemas

### Dialog Não Abre

**Problema:** `showDialog` não funciona
**Solução:** Verifique se o `context` é válido e se está dentro de um `MaterialApp`

### Overflow de Conteúdo

**Problema:** Conteúdo ultrapassa o dialog
**Solução:** O scroll é automático, mas verifique se não há widgets com altura fixa muito grande

### Botões Não Funcionam

**Problema:** `onConfirmar` ou `onCancelar` não executam
**Solução:** Verifique se os callbacks estão sendo passados corretamente

### Performance Lenta

**Problema:** Dialog demora para abrir
**Solução:** Evite widgets pesados no formulário, use `const` quando possível

### Validação Não Funciona

**Problema:** Campos não validam
**Solução:** Implemente validação nos próprios campos ou use `Form` com `GlobalKey`

## 📚 Referências

- [Flutter Dialogs](https://flutter.dev/docs/cookbook/design/dialogs)
- [Material Design Dialogs](https://material.io/components/dialogs)
- [Form Validation](https://flutter.dev/docs/cookbook/forms/validation)

---

**Última atualização:** Dezembro 2024  
**Versão:** 1.0.0  
**Mantido por:** Equipe Domani Fiscal
