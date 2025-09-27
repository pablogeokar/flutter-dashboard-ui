# Contexto do Projeto - Dashboard UI

## Visão Geral

Este projeto é uma interface de dashboard moderna desenvolvida em Flutter, com foco em design limpo e experiência de usuário intuitiva. O dashboard possui um tema personalizável (claro/escuro), uma barra lateral de navegação (sidebar) e uma AppBar superior.

## Configurações de Idioma

- **Idioma principal:** Português do Brasil
- **Código de idioma:** pt-BR
- **Localização:** Brasil

## Diretrizes de Comunicação

Todas as interações, respostas, documentação e código-fonte deste projeto devem seguir as seguintes diretrizes:

1. **Comunicação:** Todas as respostas, mensagens e comentários devem ser em português do Brasil
2. **Nomenclatura:** Funções, variáveis, widgets e componentes devem ser nomeados em português do Brasil
3. **Documentação:** Comentários no código, README e outros documentos devem estar em português do Brasil
4. **Interface do Usuário:** Todos os textos exibidos na interface do usuário devem estar em português do Brasil
5. **Mensagens de Erro:** Mensagens de erro e feedback para o usuário devem estar em português do Brasil

## Objetivo

Garantir consistência linguística em todo o projeto, proporcionando uma experiência unificada em português do Brasil tanto para desenvolvedores quanto para usuários finais.

## Exemplo de Aplicação

- Nomes de funções: `calcularTotal()` em vez de `calculateTotal()`
- Textos na interface: "Painel de Controle" em vez de "Dashboard"
- Comentários: "Função responsável por calcular o total" em vez de "Function responsible for calculating the total"

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
│   └── src/
│       └── layout/
└── main.dart
```

### Componentes Principais

- **main.dart**: Ponto de entrada da aplicação, responsável por configurar os temas, o provedor de estado e a navegação principal.
- **config/sidebar_config.dart**: Define as listas de itens que compõem o menu de navegação lateral (`itensPrincipais` e `itensInferiores`).
- **theme/light.dart**: Define o `ThemeData` completo para o modo claro da aplicação.
- **theme/dark.dart**: Define o `ThemeData` completo para o modo escuro da aplicação.
- **theme/theme.dart**: Define a cor primária (semente) para a geração dos temas e as constantes de layout (espaçamentos, bordas, dimensões).
- **theme/theme_manager.dart**: Gerencia a lógica de alternância e persistência da preferência de tema do usuário (claro/escuro).
- **widgets/app_layout.dart**: Arquivo barril que exporta os widgets públicos de layout.
- **widgets/src/layout/**: Contém os componentes de layout internos (estrutura modular).

## Diretrizes de Codificação

### Temas e Estilos

- **Método de opacidade:** O método `.withOpacity()` está depreciado e deve ser substituído por `.withValues(alpha)` para evitar perda de precisão
- **Cores do tema:** O atributo `surfaceVariant` está depreciado e deve ser substituído por `surfaceContainerLowest`, `surfaceContainerLow`, `surfaceContainer`, `surfaceContainerHigh` ou `surfaceContainerHighest` dependendo do contexto
- **Uso do theme/theme.dart:** Sempre que possível, os widgets devem utilizar as constantes definidas no arquivo theme.dart para manter consistência visual e facilitar a manutenção e personalização do layout. Isso inclui:
  - Utilizar constantes de espaçamento (AppTheme.spacingS, AppTheme.spacingM, etc.)
  - Utilizar constantes de bordas arredondadas (AppTheme.borderRadiusS, AppTheme.borderRadiusM, etc.)
  - Utilizar constantes de dimensões específicas (AppTheme.drawerWidth, AppTheme.appBarHeight, etc.)
  - Sempre que um novo valor de estilo for necessário em um widget, deve-se verificar se já existe uma constante adequada no theme.dart ou adicionar uma nova constante ao arquivo antes de usar um valor fixo no widget

### Estrutura e Privacidade de Widgets

Para garantir um código modular e de fácil manutenção, os widgets devem ser organizados em 'módulos' autocontidos.

- **Diretório `src`:** O código interno de um módulo de widget (widgets auxiliares, lógica interna, etc.) deve ser colocado dentro de um subdiretório `src`. Ex: `lib/widgets/nome_do_modulo/src/`.
- **Arquivo Barril (Barrel File):** Cada módulo deve ter um arquivo na sua raiz (ex: `lib/widgets/app_layout.dart`) que exporta apenas os widgets que compõem sua API pública.
- **Importações:** As telas e outros widgets fora do módulo devem importar **apenas** o arquivo barril, e nunca importar arquivos de dentro do diretório `src` de outro módulo diretamente.

### Gestão de Tema

- O projeto implementa um sistema de tema claro/escuro usando `ThemeManager`
- A preferência do usuário é persistida usando `SharedPreferences`
- O botão no AppBar permite alternar entre os modos de tema
- O `ThemeManager` lida com a lógica de alternância e persistência do tema
- O parâmetro `listen: false` é usado ao acessar o ThemeManager em handlers de eventos para evitar rebuilds desnecessários

### Navegação

- O sistema de navegação é baseado em um `LayoutWidget` que gerencia a exibição de telas
- O menu é composto de itens principais e itens inferiores
- Itens podem ter subitens para organizar melhor as opções
- A classe `DrawerItem` define as propriedades de cada item do menu (título, ícone, tela, subitens)

## Desenvolvimento e Qualidade

### Comandos Úteis

- **Executar a aplicação:** `flutter run`
- **Executar os testes:** `flutter test`
- **Analisar o código estaticamente:** `flutter analyze`

### Estratégia de Testes

- Os testes unitários e de widget devem ser criados dentro do diretório `test/` na raiz do projeto.
- A estrutura de pastas dentro de `test/` deve espelhar a de `lib/` para facilitar a localização dos testes correspondentes a cada componente.

### Gestão de Assets

- Todos os assets (imagens, fontes, etc.) devem ser adicionados ao diretório `assets/`.
- Para subpastas, utilize nomes que descrevam o conteúdo (ex: `assets/icons`, `assets/images`).
- Declare todos os assets no arquivo `pubspec.yaml` para que fiquem disponíveis na aplicação.

## Dependências Importantes

- `flutter`: SDK principal
- `provider`: Gerenciamento de estado
- `shared_preferences`: Persistência de dados locais (preferência de tema)
- `flutter_lints`: Regras de linting

## Boas Práticas

- Seguir as melhores práticas de desenvolvimento Flutter
- Manter consistência de estilos usando o AppTheme
- Organizar widgets em estruturas modulares com arquivos src e barril
- Utilizar internacionalização mesmo com idioma fixo para facilitar mudanças futuras
- Implementar testes unitários e de widget para garantir qualidade
- Documentar código usando comentários em português do Brasil
