# Contexto do Projeto - Domani Fiscal

## Visão Geral

Sistema de Gestão Fiscal desenvolvido em Flutter para a **Domani Fiscal**. Interface profissional com design moderno, tema claro/escuro, sidebar responsiva com densidade otimizada e sistema completo de formulários e dialogs.

## Diretrizes Essenciais

- **Idioma:** Português do Brasil (pt-BR) em todo código, comentários e interface
- **Nomenclatura:** Funções, variáveis e componentes em português
- **Branding:** Sempre usar "Domani Fiscal" (nunca "Dashboard UI")
- **Paleta de Cores Atualizada:**
  - **Modo Light:** Destaque `#007BFF`, Fundo `#F5F7FA`, Cards `#FFFFFF`
  - **Modo Dark:** Destaque `#5B9CF8`, Fundo `#121212`, Cards `#1E1E1E`

## Arquitetura Atual

```
lib/
├── config/sidebar_config.dart
├── screens/
│   ├── splash_screen.dart, dashboard_screen.dart
│   └── em_construcao_screen.dart, teste_screen.dart
├── theme/
│   ├── theme.dart (paleta completa), theme_manager.dart
│   ├── animations.dart, dark.dart, light.dart
├── widgets/
│   ├── README.md (documentação completa)
│   ├── app_initializer.dart, app_layout.dart, dialog.dart
│   └── src/
│       ├── app_layout/ (app_shell.dart, responsive_drawer.dart, drawer_list_item.dart)
│       ├── dialog/ (form_dialog.dart, form_dialog_service.dart, README.md)
│       └── forms/ (form_components.dart, form_row.dart, README.md)
├── assets/ (logo_light.png, logo_dark.png)
└── DESIGN_IMPROVEMENTS.md (histórico completo de melhorias)
```

## Padrões de Código

### Design System

- **Responsividade:** Use `AppTheme.getResponsive*()` para tamanhos adaptativos
- **Cores:** Sempre usar `AppTheme.primaryLight/primaryDark` para consistência
- **Animações:** Durações padronizadas (100ms, 200ms, 300ms)
- **Espaçamento:** Grid 8px - use `AppTheme.spacing*` (XS=4, S=8, M=16, L=24, XL=32)

### Formulários (OBRIGATÓRIO)

- **Alinhamento:** SEMPRE usar `FormRow.top()` ao invés de `Row` manual
- **Proporções:** Use `FormRowFlex` para controle de proporções (ex: 2:1, 1:2:1)
- **Espaçamento:** 16px entre campos, 20px entre seções
- **Validação:** Implementar em todos os campos obrigatórios

### Dialogs (OBRIGATÓRIO)

- **Serviços:** Use `FormDialogService.mostrar*()` ao invés de criar dialogs manuais
- **Tamanhos:** Pequeno=400px, Médio=600px, Grande=700px, XL=800px+
- **Scroll:** Automático para formulários longos
- **Ícones:** Sempre incluir ícone apropriado no header

## Estado Atual

### ✅ Implementado e Funcional

- **Interface:** Splash screen, dashboard com métricas, navegação completa
- **Temas:** Claro/escuro com paleta profissional refinada
- **Sidebar:** Responsiva, densidade otimizada, indicador de item ativo elegante
- **Formulários:** Sistema FormRow com alinhamento perfeito
- **Dialogs:** Sistema completo com scroll automático e validação
- **Documentação:** Completa e profissional (README.md em cada módulo)

### 🔧 Características Técnicas

- **Performance:** Otimizada, sem travamentos
- **Responsividade:** Breakpoints inteligentes para diferentes telas
- **Acessibilidade:** Cursor apropriado, feedback visual, navegação por teclado
- **UX:** Animações suaves (200ms), estados de hover, indicadores visuais

### 🚧 Em Desenvolvimento

- Telas específicas (usam EmConstrucaoPlaceholder com preview de funcionalidades)
- Integrações com APIs fiscais
- Relatórios avançados com gráficos

## Widgets Essenciais do Sistema

### FormRow (SEMPRE usar para formulários)

```dart
// Distribuição igual
FormRow.top(
  children: [
    DomaniTextField(label: 'Email'),
    DomaniTextField(label: 'Telefone'),
  ],
)

// Proporções customizadas
FormRowFlex.top(
  items: [
    FormRowItem(flex: 2, child: DomaniTextField(label: 'Endereço')),
    FormRowItem(flex: 1, child: DomaniTextField(label: 'Número')),
  ],
)
```

### FormDialogService (SEMPRE usar para dialogs)

```dart
// Cadastros pré-configurados
FormDialogService.mostrarCadastroCliente(
  context: context,
  onConfirmar: () => _salvarCliente(),
);

// Dialog customizado
FormDialogService.mostrarFormulario(
  context: context,
  titulo: 'Meu Dialog',
  icone: Icons.edit,
  formulario: _buildFormulario(),
  onConfirmar: () => _processar(),
);
```

## Melhorias Implementadas (Dezembro 2024)

### 🎨 Design Profissional

- **Nova paleta de cores** seguindo especificações de design moderno
- **Cards com profundidade adequada** - sombras sutis no light, bordas no dark
- **Tipografia hierárquica** - títulos bold, texto normal, detalhes smaller
- **Espaçamento ultra-compacto** na sidebar para máximo aproveitamento

### 🔧 Sistema de Formulários

- **FormRow** - Alinhamento automático perfeito
- **FormRowFlex** - Controle de proporções (2:1, 1:2:1, etc.)
- **Validação integrada** - Campos obrigatórios e formatos
- **Responsividade** - Adapta-se a diferentes tamanhos

### 💬 Sistema de Dialogs

- **FormDialog** - Widget base reutilizável
- **FormDialogService** - Serviços pré-configurados
- **Scroll automático** - Formulários longos funcionam perfeitamente
- **Animações suaves** - Entrada/saída com scale + fade

### 🎯 UX Aprimorada

- **Cursor inteligente** - Pointer em áreas clicáveis
- **Indicador de item ativo** - Linha vertical de 4px elegante
- **Estados de hover** - Feedback visual profissional
- **Divisores entre grupos** - Organização visual na sidebar

## Documentação e Manutenibilidade

### 📚 Sistema de Documentação

- **README.md principal** - Visão geral completa
- **README.md por módulo** - Documentação específica
- **Código autodocumentado** - Comentários detalhados
- **Exemplos práticos** - Copy-paste ready

### 🏗️ Arquitetura Limpa

- **Separação de responsabilidades** - Cada widget tem propósito claro
- **Reutilização máxima** - Widgets genéricos e específicos
- **Padrões consistentes** - Estrutura uniforme
- **Escalabilidade** - Base sólida para crescimento

## Próximas Implementações

1. **Tabelas de dados** - Sistema de DataTable responsivo
2. **Gráficos fiscais** - Charts para métricas e relatórios
3. **Sistema de notificações** - Alerts e toasts padronizados
4. **Upload de arquivos** - Drag & drop para documentos
5. **Calendário fiscal** - Componente de agenda integrado
6. **APIs fiscais** - Integrações com serviços externos

## Troubleshooting Comum

### Formulários Desalinhados

❌ **Não faça:** `Row(children: [Expanded(...), Expanded(...)])`
✅ **Faça:** `FormRow.top(children: [...])`

### Dialogs Quebrados

❌ **Não faça:** `showDialog` manual
✅ **Faça:** `FormDialogService.mostrarFormulario()`

### Cores Inconsistentes

❌ **Não faça:** `Color(0xFF...)`
✅ **Faça:** `Theme.of(context).colorScheme.primary`

### Performance Lenta

❌ **Não faça:** Widgets sem `const`
✅ **Faça:** `const DomaniTextField(...)` quando possível

---

**Última atualização:** Dezembro 2024  
**Status:** Produção - Sistema estável e documentado  
**Próxima revisão:** Após implementação de tabelas e gráficos
