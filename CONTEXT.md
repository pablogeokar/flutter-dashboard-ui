# Dashboard UI - Contexto do Projeto

## Visão Geral

Este projeto é uma interface de dashboard moderna desenvolvida em Flutter, com foco em design limpo e experiência de usuário intuitiva. O dashboard possui um tema personalizável (claro/escuro), uma barra lateral de navegação (sidebar) e uma AppBar superior.

## Estrutura do Projeto

### Diretórios Principais

- `lib/`: Código fonte principal
  - `config/`: Configurações do aplicativo
  - `screens/`: Telas do aplicativo
  - `theme/`: Definições de tema (claro/escuro)
  - `widgets/`: Componentes reutilizáveis da UI
    - `src/`: Implementações dos widgets
      - `layout/`: Componentes de layout (sidebar, AppBar, etc.)

### Arquivos Importantes

#### Tema

- `theme/theme.dart`: Define constantes de tema e classes de utilidade
- `theme/light.dart`: Implementação do tema claro
- `theme/dark.dart`: Implementação do tema escuro
- `theme/theme_manager.dart`: Gerenciamento de tema (alternância claro/escuro)

#### Layout

- `widgets/app_layout.dart`: Exporta componentes de layout
- `widgets/src/layout/layout_widget.dart`: Widget principal de layout
- `widgets/src/layout/layout_base_widget.dart`: Implementação base do layout (AppBar, conteúdo)
- `widgets/src/layout/responsive_drawer.dart`: Sidebar responsiva
- `widgets/src/layout/drawer_item.dart`: Definição de itens da sidebar
- `widgets/src/layout/drawer_list_item.dart`: Implementação visual dos itens da sidebar

## Melhorias de Design Implementadas

### Tema

- Adicionada cor secundária ao tema para maior flexibilidade de design
- Cores configuradas nos temas claro e escuro

### Sidebar

- Design limpo com cores sólidas
- Bordas arredondadas para visual moderno
- Cabeçalho informativo adicionado
- Itens selecionados com destaque sutil
- Sombras suaves para dar profundidade

### AppBar

- Visual limpo com cores sólidas
- Botões com design minimalista
- Efeitos visuais sutis para melhor experiência do usuário

## Padrões de Design

- Uso de `StatefulWidget` para componentes com estado
- Implementação responsiva para diferentes tamanhos de tela
- Separação clara entre definição de dados e apresentação visual
- Uso de temas para consistência visual em todo o aplicativo
- Animações sutis para transições

## Convenções de Código

- Nomes descritivos para classes e métodos
- Comentários em português
- Uso de constantes para valores reutilizáveis
- Organização de código em arquivos específicos por funcionalidade
