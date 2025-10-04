# Contexto do Projeto - Dashboard UI

## Visão Geral

Este projeto é uma interface de dashboard moderna desenvolvida em Flutter, com foco em design limpo, profissional e experiência de usuário intuitiva. O dashboard possui um tema personalizável (claro/escuro), uma barra lateral de navegação (sidebar) e uma AppBar superior transparente.

## Configurações de Idioma

- **Idioma principal:** Português do Brasil
- **Código de idioma:** pt-BR
- **Localização:** Brasil

## Diretrizes de Comunicação

Todas as interações, respostas, documentação e código-fonte deste projeto devem seguir as seguintes diretrizes:

1.  **Comunicação:** Todas as respostas, mensagens e comentários devem ser em português do Brasil.
2.  **Nomenclatura:** Funções, variáveis, widgets e componentes devem ser nomeados em português do Brasil.
3.  **Documentação:** Comentários no código, README e outros documentos devem estar em português do Brasil.
4.  **Interface do Usuário:** Todos os textos exibidos na interface do usuário devem estar em português do Brasil.
5.  **Mensagens de Erro:** Mensagens de erro e feedback para o usuário devem estar em português do Brasil.

## Objetivo

Garantir consistência linguística e de codificação em todo o projeto, proporcionando uma experiência unificada tanto para desenvolvedores quanto para usuários finais.

## Arquitetura do Projeto

### Estrutura de Diretórios

```
lib/
├── config/
│   └── sidebar_config.dart
├── screens/
├── theme/
│   ├── dark.dart
│   ├── light.dart
│   ├── theme.dart
│   └── theme_manager.dart
├── widgets/
│   ├── app_layout.dart
│   ├── form_fields.dart
│   └── src/
│       ├── app_layout/
│       │   ├── app_shell.dart
│       │   ├── drawer_item.dart
│       │   ├── drawer_list_item.dart
│       │   ├── modern_app_bar.dart
│       │   ├── responsive_scaffold.dart
│       │   └── responsive_drawer.dart
│       └── form_fields/
│           ├── currency_pt_br_input_formatter.dart
│           ├── custom_button.dart
│           ├── date_input_field.dart
│           ├── monetary_input_field.dart
│           └── text_input_field.dart
└── main.dart
```

### Componentes Principais (Continuação)

- **theme/animations.dart**: Centraliza todas as constantes de animação, durações, curvas e transições personalizadas da aplicação.
- **widgets/src/layout/drawer_list_item.dart**: Widget individual para itens do menu lateral com animações de hover e estados visuais aprimorados.

## Diretrizes de Codificação (Continuação)

### Animações e Transições

- **Consistência:** Todas as animações devem usar as constantes definidas em `AppAnimations` para garantir consistência visual.
- **Performance:** Animações são otimizadas para 60fps e usam `AnimatedContainer` e `AnimatedWidget` quando possível.
- **Sutileza:** As animações são sutis e não interferem na usabilidade, focando em melhorar o feedback visual.
- **Durações:** Use `AppAnimations.fast` (150ms) para micro-interações, `AppAnimations.normal` (300ms) para transições padrão.

### Sistema de Cores Semânticas

- **Estados:** Use as cores semânticas (`success`, `error`, `warning`, `info`) para comunicar estados específicos.
- **Neutrals:** A escala de neutros (50-900) oferece flexibilidade para diferentes níveis de contraste.
- **Interatividade:** Use as cores de hover, foco e ativo para estados interativos consistentes.

### Otimizações de Performance

- **Cache de Telas:** O `AppShell` mantém um cache das telas para preservar estado e melhorar performance.
- **Lazy Loading:** Telas são criadas apenas quando necessário através do sistema de cache.
- **Animações Eficientes:** Use `AnimatedContainer` e widgets animados nativos do Flutter para melhor performance.

## Melhorias Implementadas (v2.0)

### ✅ Prioridade Alta - Concluídas

1. **Dívida Técnica da ModernAppBar Resolvida**

   - Reestruturação do layout de telas grandes usando `Column` ao invés de `Stack`
   - AppBar agora não intercepta eventos do conteúdo principal
   - Mantém funcionalidade completa em ambos os layouts

2. **Sistema de Cores Aprimorado**

   - Paleta semântica completa com cores para sucesso, erro, aviso e informação
   - Escala de neutros expandida (50-900) para maior flexibilidade
   - Cores interativas específicas para hover, foco e estados ativos
   - Integração completa com temas claro e escuro

3. **Simplificação do ResponsiveScaffold**

   - Método `_buildDrawer()` centralizado para evitar duplicação
   - Lógica de navegação otimizada e mais limpa
   - Redução significativa de código duplicado

4. **Gerenciamento de Estado Otimizado**
   - Cache de telas inicializado uma única vez no `initState()`
   - Métodos separados para construção de telas e navegação
   - Performance melhorada com lazy loading de componentes

### ✅ Animações e Micro-interações

1. **Sistema de Animações Centralizado**

   - Arquivo `animations.dart` com constantes e helpers
   - Durações e curvas padronizadas para consistência
   - Transições personalizadas reutilizáveis

2. **DrawerListItem Animado**

   - Animações de hover com escala e rotação sutil
   - Transições suaves entre estados (selecionado, hover, normal)
   - Feedback visual aprimorado com sombras animadas

3. **ModernAppBar Interativa**
   - Botões com animações de hover e escala
   - Avatar com efeitos visuais ao passar o mouse
   - Transições suaves entre ícones de tema

### 🎯 Benefícios das Melhorias

- **Performance:** Cache otimizado e animações eficientes
- **UX:** Feedback visual consistente e intuitivo
- **Manutenibilidade:** Código mais limpo e organizado
- **Escalabilidade:** Sistema de cores e animações reutilizáveis
- **Acessibilidade:** Melhor contraste e estados visuais claros

## Melhorias Específicas para Windows Desktop (v2.1)

### ✅ Otimizações para Desktop Windows

1. **Breakpoints Responsivos Aprimorados**

   - Desktop padrão: >= 1024px (layout completo com barra de status)
   - Desktop compacto: 768-1023px (drawer mais estreito, funcionalidades completas)
   - Mobile/Tablet: < 768px (drawer colapsável, layout otimizado para toque)

2. **Barra de Status Desktop**

   - Componente `DesktopStatusBar` específico para aplicações desktop
   - Exibe status da conexão, versão da aplicação e hora atual
   - Integrada nos layouts de desktop (grande e médio)
   - Atualização automática da hora a cada segundo

3. **Suporte a Atalhos de Teclado**

   - Sistema de atalhos integrado com `Shortcuts` e `Actions` do Flutter
   - Atalhos implementados:
     - `Ctrl+T`: Alternar tema claro/escuro
   - Arquitetura extensível para novos atalhos

4. **Configurações Específicas para Windows**
   - Constantes de tamanho de janela recomendados
   - Configurações de densidade visual otimizadas para desktop
   - Velocidade de scroll ajustada para mouse desktop

### 🎯 Benefícios das Melhorias Windows

- **Experiência Nativa:** Interface que segue padrões do Windows
- **Produtividade:** Atalhos de teclado familiares aos usuários Windows
- **Informações Contextuais:** Barra de status com informações úteis
- **Responsividade Inteligente:** Layouts otimizados para diferentes tamanhos de tela desktop
- **Performance:** Componentes otimizados para aplicações desktop

### 📁 Novos Arquivos Criados

- `lib/utils/keyboard_shortcuts.dart`: Gerenciamento de atalhos de teclado
- `lib/widgets/src/app_layout/desktop_status_bar.dart`: Barra de status para desktop

### 🔧 Arquivos Modificados

- `lib/theme/theme.dart`: Adicionadas constantes específicas para Windows desktop
- `lib/widgets/src/app_layout/responsive_scaffold.dart`: Breakpoints e layouts aprimorados
- `lib/widgets/src/app_layout/app_shell.dart`: Integração com sistema de atalhos
- `lib/widgets/app_layout.dart`: Exportação dos novos componentes

### 🚀 Próximas Melhorias Sugeridas

1. **Integração com Sistema Operacional**

   - Notificações nativas do Windows
   - Integração com barra de tarefas
   - Suporte a temas do sistema

2. **Funcionalidades Avançadas**

   - Múltiplas janelas
   - Drag and drop de arquivos
   - Menu de contexto personalizado

3. **Performance Desktop**
   - Lazy loading de componentes pesados
   - Cache inteligente de recursos
   - Otimizações de memória para sessões longas
