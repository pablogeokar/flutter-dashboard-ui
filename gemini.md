# Contexto do Projeto - Dashboard UI

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

## Diretrizes de Codificação

- **Método de opacidade:** O método `.withOpacity()` está depreciado e deve ser substituído por `.withValues()` para evitar perda de precisão
- **Cores do tema:** O atributo `surfaceVariant` está depreciado e deve ser substituído por `surfaceContainerLowest`, `surfaceContainerLow`, `surfaceContainer`, `surfaceContainerHigh` ou `surfaceContainerHighest` dependendo do contexto
- **Nomenclatura de variáveis:** Sempre usar nomes descritivos em português do Brasil
- **Boas práticas:** Seguir as melhores práticas de desenvolvimento Flutter
- **Uso do theme.dart:** Sempre que possível, os widgets devem utilizar as constantes definidas no arquivo theme.dart para manter consistência visual e facilitar a manutenção e personalização do layout. Isso inclui:
  - Utilizar constantes de espaçamento (AppTheme.spacingS, AppTheme.spacingM, etc.)
  - Utilizar constantes de bordas arredondadas (AppTheme.borderRadiusS, AppTheme.borderRadiusM, etc.)
  - Utilizar constantes de dimensões específicas (AppTheme.drawerWidth, AppTheme.appBarHeight, etc.)
  - Sempre que um novo valor de estilo for necessário em um widget, deve-se verificar se já existe uma constante adequada no theme.dart ou adicionar uma nova constante ao arquivo antes de usar um valor fixo no widget
