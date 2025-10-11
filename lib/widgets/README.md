# 🧩 Sistema de Widgets - Domani Fiscal

Sistema completo de widgets reutilizáveis para construção de interfaces profissionais e consistentes.

## 📁 Estrutura Geral

```
widgets/
├── README.md                    # Esta documentação
├── app_initializer.dart        # Inicializador da aplicação
├── app_layout.dart            # Layout principal da aplicação
├── dialog.dart                # Exportações de dialogs
├── form.dart           # Layouts para formulários
│
├── src/                       # Código fonte dos widgets
│   ├── app_layout/           # Widgets de layout da aplicação
│   │   ├── app_shell.dart    # Shell principal da aplicação
│   │   ├── responsive_drawer.dart # Sidebar responsiva
│   │   ├── drawer_list_item.dart # Itens da sidebar
│   │   └── ...
│   │
│   ├── dialog/               # Sistema de dialogs
│   │   ├── README.md         # Documentação específica
│   │   ├── form_dialog.dart  # Widget base para dialogs
│   │   ├── form_dialog_service.dart # Serviços pré-configurados
│   │   └── dialog_callbacks.dart # Callbacks e integrações
│   │
│   └── forms/                # Widgets de formulário
│       ├── README.md         # Documentação específica
│       ├── form_components.dart # Componentes básicos
│       ├── form_row.dart     # Sistema de alinhamento
│       └── form.dart  # Layouts para formulários
```

## 🎯 Sistemas Principais

### 1. **Sistema de Layout** (`src/app_layout/`)

Widgets para estrutura principal da aplicação.

**Componentes:**

- `AppShell` - Shell principal com navegação
- `ResponsiveDrawer` - Sidebar adaptativa
- `DrawerListItem` - Itens de menu com estados
- `Breadcrumb` - Navegação hierárquica

**Características:**

- ✅ Design responsivo
- ✅ Temas claro/escuro
- ✅ Animações suaves
- ✅ Acessibilidade completa

### 2. **Sistema de Dialogs** (`src/dialog/`)

Dialogs modais padronizados para toda a aplicação.

**Componentes:**

- `FormDialog` - Widget base reutilizável
- `FormDialogService` - Serviços pré-configurados
- `DialogCallbacks` - Integrações com menus

**Casos de Uso:**

- ✅ Cadastros (Cliente, Fornecedor)
- ✅ Configurações do sistema
- ✅ Confirmações e alertas
- ✅ Busca e filtros

### 3. **Sistema de Formulários** (`src/forms/`)

Widgets especializados para criação de formulários.

**Componentes:**

- `FormRow` - Alinhamento automático
- `FormRowFlex` - Proporções customizadas
- `DomaniTextField` - Campo de texto padrão
- `DomaniDropdown` - Seleção padrão

**Benefícios:**

- ✅ Alinhamento perfeito
- ✅ Código mais limpo
- ✅ Reutilização máxima
- ✅ Manutenção centralizada

## 🎨 Padrões de Design

### Cores e Temas

- **Modo Light**: Fundo `#F5F7FA`, Cards `#FFFFFF`
- **Modo Dark**: Fundo `#121212`, Cards `#1E1E1E`
- **Destaque**: `#007BFF` (light) / `#5B9CF8` (dark)

### Espaçamento

- **Entre campos**: 16px
- **Entre seções**: 20px
- **Padding interno**: 16px
- **Margens externas**: 24px

### Tipografia

- **Títulos**: Bold, tamanhos hierárquicos
- **Corpo**: Normal, legibilidade otimizada
- **Detalhes**: Smaller, cor secundária

### Animações

- **Duração padrão**: 200ms
- **Curva**: easeOut
- **Efeitos**: Scale, Fade, Slide

## 📖 Guias de Uso

### Criando um Formulário

```dart
Column(
  children: [
    // Campo único
    DomaniTextField(
      label: 'Nome Completo',
      required: true,
      helperText: 'Nome como aparece nos documentos',
    ),

    SizedBox(height: 20),

    // Linha com alinhamento automático
    FormRow.top(
      children: [
        DomaniTextField(label: 'Email'),
        DomaniTextField(label: 'Telefone'),
      ],
    ),

    SizedBox(height: 20),

    // Linha com proporções customizadas
    FormRowFlex.top(
      items: [
        FormRowItem(flex: 2, child: DomaniTextField(label: 'Endereço')),
        FormRowItem(flex: 1, child: DomaniTextField(label: 'Número')),
      ],
    ),
  ],
)
```

### Exibindo um Dialog

```dart
await FormDialogService.mostrarCadastroCliente(
  context: context,
  onConfirmar: () {
    // Processar dados do formulário
    _salvarCliente();
  },
);
```

### Criando Item de Menu

```dart
DrawerItem(
  title: 'Clientes',
  icon: Icons.people_rounded,
  onDialogTap: DialogCallbacks.cadastroCliente(context),
)
```

## 🚀 Melhores Práticas

### ✅ Faça

- Use widgets do sistema ao invés de criar do zero
- Siga os padrões de espaçamento estabelecidos
- Implemente validação adequada em formulários
- Use FormRow para alinhamento perfeito
- Documente widgets customizados
- Teste em diferentes tamanhos de tela
- Mantenha consistência visual

### ❌ Evite

- Misturar padrões de espaçamento
- Criar widgets similares aos existentes
- Ignorar responsividade
- Usar cores fora da paleta
- Formulários sem validação
- Dialogs muito grandes
- Animações excessivas

## 🔧 Extensibilidade

### Criando Novos Widgets

1. **Analise** se já existe algo similar
2. **Documente** propósito e uso
3. **Siga** padrões estabelecidos
4. **Teste** em diferentes cenários
5. **Integre** com sistema de temas
6. **Adicione** exemplos de uso

### Modificando Widgets Existentes

1. **Avalie** impacto em toda aplicação
2. **Mantenha** compatibilidade
3. **Atualize** documentação
4. **Teste** todos os casos de uso
5. **Comunique** mudanças à equipe

## 🐛 Solução de Problemas

### Alinhamento de Formulários

**Problema**: Campos desalinhados
**Solução**: Use `FormRow` ao invés de `Row`

### Dialogs Não Abrem

**Problema**: `showDialog` falha
**Solução**: Verifique `context` válido

### Temas Inconsistentes

**Problema**: Cores diferentes
**Solução**: Use `Theme.of(context)` sempre

### Performance Lenta

**Problema**: Interface travando
**Solução**: Use `const` e evite rebuilds desnecessários

## 📚 Documentação Específica

- **[Formulários](src/forms/README.md)** - Widgets de formulário
- **[Dialogs](src/dialog/README.md)** - Sistema de dialogs
- **[Layout](src/app_layout/)** - Estrutura da aplicação

## 🔄 Versionamento

### v1.0.0 (Atual)

- ✅ Sistema de formulários com FormRow
- ✅ Dialogs padronizados
- ✅ Layout responsivo
- ✅ Temas claro/escuro
- ✅ Documentação completa

### Próximas Versões

- 🔄 Widgets de tabela
- 🔄 Sistema de notificações
- 🔄 Componentes de gráficos
- 🔄 Widgets de upload

---

**Última atualização:** Dezembro 2024  
**Versão:** 1.0.0  
**Mantido por:** Equipe Domani Fiscal
