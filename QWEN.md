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

### Componentes Principais

- **main.dart**: Ponto de entrada da aplicação, responsável por configurar os temas, o provedor de estado e a navegação principal.
- **config/sidebar_config.dart**: Define as listas de itens que compõem o menu de navegação lateral (`itensPrincipais` e `itensInferiores`).
- **theme/light.dart**: Define o `ThemeData` completo para o modo claro da aplicação.
- **theme/dark.dart**: Define o `ThemeData` completo para o modo escuro da aplicação.
- **theme/theme.dart**: Centraliza todas as constantes de design system, como paleta de cores para os temas, escala de texto, espaçamentos, bordas e dimensões.
- **theme/theme_manager.dart**: Gerencia a lógica de alternância e persistência da preferência de tema do usuário (claro/escuro).
- **widgets/app_layout.dart**: Arquivo barril que exporta os widgets públicos de layout.
- **widgets/src/layout/app_shell.dart**: Widget "inteligente" (stateful) que gerencia o estado da navegação (item selecionado) e envolve a estrutura visual da aplicação.
- **widgets/src/layout/responsive_scaffold.dart**: Widget "burro" (stateless) que constrói o `Scaffold` e adapta a UI entre telas grandes e pequenas, recebendo o estado do `AppShell`.
- **widgets/src/layout/modern_app_bar.dart**: Widget que define a `AppBar` customizada da aplicação.
- **widgets/form_fields.dart**: Arquivo barril que exporta os widgets públicos de campos de formulário.
- **widgets/src/form_fields/currency_pt_br_input_formatter.dart**: Formatter para campos de entrada de moeda no formato brasileiro.
- **widgets/src/form_fields/custom_button.dart**: Widget de botão customizado.
- **widgets/src/form_fields/date_input_field.dart**: Campo de entrada para datas.
- **widgets/src/form_fields/monetary_input_field.dart**: Campo de entrada para valores monetários.
- **widgets/src/form_fields/text_input_field.dart**: Campo de entrada de texto genérico.

## Diretrizes de Codificação

### Temas e Estilos

- **Centralização:** Todas as constantes de design (cores, fontes, tamanhos, etc.) devem ser definidas em `lib/theme/theme.dart` para garantir consistência e facilitar a manutenção.
- **Cores:** A paleta de cores é dividida em `primaryLight`/`primaryDark`, `secondaryLight`/`secondaryDark`, etc., para suportar os dois modos de tema.
- **Tipografia:** A fonte padrão da aplicação é a **Inter**, gerenciada pelo pacote `google_fonts`. A escala de texto (tamanhos e pesos) é definida pela constante `AppTheme.textTheme` no arquivo `theme.dart`.

### Estrutura e Privacidade de Widgets

Para garantir um código modular e de fácil manutenção, os widgets devem ser organizados em "módulos" autocontidos.

- **Diretório `src`:** O código interno de um módulo de widget (widgets auxiliares, lógica interna, etc.) deve ser colocado dentro de um subdiretório `src`. Ex: `lib/widgets/nome_do_modulo/src/`.
- **Arquivo Barril (Barrel File):** Cada módulo deve ter um arquivo na sua raiz (ex: `lib/widgets/app_layout.dart`) que exporta apenas os widgets que compõem sua API pública.
- **Importações:** As telas e outros widgets fora do módulo devem importar **apenas** o arquivo barril, e nunca importar arquivos de dentro do diretório `src` de outro módulo diretamente.

### Comentários e Documentação

- **Código Auto-Documentado:** A prioridade é escrever um código claro e legível, com nomes de variáveis, funções e classes que descrevam suas próprias finalidades. O bom código deve ser a principal forma de documentação.
- **Comente o "Porquê", não o "O Quê":** Evite comentários que apenas repetem o que o código já está fazendo. Use comentários para explicar a razão por trás de uma lógica complexa, uma decisão de arquitetura não óbvia ou uma solução alternativa para um problema específico.
- **Comentários de Alto Nível:** É útil adicionar um breve comentário no topo de classes ou widgets importantes para descrever sua responsabilidade principal dentro da aplicação (ex: "Este widget gerencia o estado da navegação principal").

### Navegação

- O sistema de navegação é baseado no widget `AppShell`, que gerencia a exibição das telas.
- O menu é composto de itens principais e itens inferiores, definidos em `sidebar_config.dart`.
- Itens podem ter subitens para organizar melhor as opções.
- A classe `DrawerItem` define as propriedades de cada item do menu (título, ícone, tela, subitens).

## Desenvolvimento e Qualidade

### Comandos Úteis

- **Executar a aplicação:** `flutter run`
- **Executar os testes:** `flutter test`
- **Analisar o código estaticamente:** `flutter analyze`

## Dependências Importantes

- `flutter`: SDK principal
- `provider`: Gerenciamento de estado
- `shared_preferences`: Persistência de dados locais (preferência de tema)
- `google_fonts`: Para carregamento de fontes do Google Fonts.
- `intl`: Para internacionalização e localização.
- `flutter_lints`: Regras de linting

## Boas Práticas

- Seguir as melhores práticas de desenvolvimento Flutter.
- Manter consistência de estilos usando as constantes do `AppTheme`.
- Organizar widgets em estruturas modulares com arquivos `src` e barril.
- Documentar código usando comentários em português do Brasil.

## Dívidas Técnicas e Refatorações Futuras

### Refatorar `ModernAppBar` no `ResponsiveScaffold` para evitar interceptação de eventos em telas grandes.

- **Problema Anterior:** Em telas grandes, a `FormTestScreen` (e potencialmente outras telas) não permitia interação com os campos de formulário. Após investigação, descobriu-se que a `ModernAppBar`, quando posicionada no `Stack` do `_buildLargeScreenLayout()` do `ResponsiveScaffold`, estava interceptando os eventos de toque do conteúdo principal, mesmo sendo transparente e tendo uma altura definida.
- **Solução Temporária Aplicada:** A `ModernAppBar` foi removida temporariamente do `_buildLargeScreenLayout()` no `responsive_scaffold.dart` para permitir a interação com os campos de formulário.
- **Urgência e Solução Adequada:**
  - **Urgência:** Média. A funcionalidade principal está comprometida sem a `AppBar`. É crucial restaurar a `AppBar` sem reintroduzir o problema de interação.
  - **Solução Adequada:** A `ModernAppBar` precisa ser reintroduzida no `_buildLargeScreenLayout()` de forma que não interfira com os eventos de toque do conteúdo principal. Isso pode envolver:
    - **Revisar o `Stack`:** Garantir que o `Stack` esteja configurado corretamente para que a `AppBar` não se expanda além de sua área ou que seus eventos de toque não se propaguem para baixo.
    - **Usar `Positioned`:** Posicionar a `ModernAppBar` explicitamente no `Stack` com `Positioned(top: 0, left: 0, right: 0, child: ModernAppBar(...))` para controlar sua área.
    - **Considerar `IgnorePointer`:** Envolver a `ModernAppBar` em um `IgnorePointer` se ela for puramente visual e não precisar de interação (exceto para seus próprios botões, que teriam seus próprios `onPressed`). No entanto, isso pode ser complexo se os botões da `AppBar` precisarem ser clicáveis.
    - **Reavaliar a estrutura do `ResponsiveScaffold`:** Se o `Stack` continuar a ser problemático, pode ser necessário repensar a forma como a `AppBar` e o conteúdo principal são combinados no layout de tela grande.
