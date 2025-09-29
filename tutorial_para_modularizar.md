# Tutorial: Transformando Widgets em um Pacote Privado do GitHub

Este tutorial explica passo a passo como modularizar os widgets da pasta `lib/widgets` em um pacote privado do GitHub, para separar os widgets visuais da aplicação Flutter.

## 1. Benefícios da Modularização em Pacotes Privados

Antes de tudo, vale entender por que modularizar os widgets pode ser vantajoso:

- **Reusabilidade**: Pacotes podem ser usados em múltiplos projetos.
- **Manutenção**: Centralização de widgets facilita atualizações e correções.
- **Separação de Responsabilidades**: Separa os componentes visuais da lógica de negócio da aplicação.
- **Controle de Versão Isolado**: Cada pacote pode evoluir independentemente.
- **Compartilhamento**: Facilita o compartilhamento de componentes entre times ou projetos.

## 2. Geração e Configuração de Chave SSH

Para autenticar-se com o GitHub sem precisar digitar usuário e senha a cada operação Git, você pode usar chaves SSH. Siga os passos abaixo para gerar e configurar uma chave SSH:

1. Abra o Git Bash ou PowerShell (como administrador é recomendado).
2. Execute o seguinte comando para gerar uma nova chave SSH, substituindo \"seu_email@exemplo.com\" pelo e-mail associado à sua conta GitHub:

```bash
ssh-keygen -t rsa -b 4096 -C \"seu_email@exemplo.com\"
```

3. Quando solicitado, especifique o local para salvar a chave (pressione Enter para aceitar o local padrão).
4. Digite uma senha segura (passphrase) quando solicitado (opcional, mas recomendado).

A chave pública será salva como `id_rsa.pub` (ou `id_ed25519.pub` se usar o algoritmo Ed25519) e a chave privada como `id_rsa` (ou `id_ed25519`) no diretório `.ssh` dentro do seu diretório home (ex: `C:\\Users\\SeuNome\\.ssh\\` no Windows).

5. Para adicionar a chave SSH ao ssh-agent, execute os seguintes comandos:

```bash
eval \"$(ssh-agent -s)\"
ssh-add ~/.ssh/id_rsa
```

6. Copie o conteúdo da chave pública para a área de transferência:

```bash
cat ~/.ssh/id_rsa.pub
```

Ou, no Windows com Git Bash:

```bash
clip < ~/.ssh/id_rsa.pub
```

7. Acesse as configurações da sua conta GitHub:
   - Vá para `Settings` (Configurações)
   - Clique em `SSH and GPG keys`
   - Clique em `New SSH key`
   - Cole o conteúdo da chave pública no campo \"Key\"
   - Dê um título descritivo (ex: \"Meu computador Windows\")
   - Clique em `Add SSH key`

Agora você pode usar URLs SSH para acessar repositórios privados via Git, como `git@github.com:seu_usuario/seu_repositorio.git`.

Observação: Se o seu sistema operacional for Windows, você pode usar o Git Bash que vem com o Git for Windows, ou o próprio PowerShell para executar os comandos acima.

## 3. Criação de um Novo Pacote Flutter

Para criar um novo pacote Flutter, você pode usar o comando `flutter create` com a opção `--template=package`:

```bash
flutter create --template=package nome_do_pacote
```

**Exemplo com base na sua estrutura**:

```bash
flutter create --template=package dashboard_ui_widgets
```

## 4. Estrutura do Projeto do Pacote

A estrutura do novo pacote será semelhante a esta:

```
dashboard_ui_widgets/
├── lib/
│   ├── src/              # Código-fonte dos widgets (análogo ao seu lib/widgets/src)
│   │   ├── layout/
│   │   └── form_fields/
│   ├── dashboard_ui_widgets.dart  # Arquivo barril (análogo ao seu lib/widgets/app_layout.dart)
│   └── widgets/          # (Opcional) Outra forma de organizar, mas siga o padrão src/
├── test/
├── example/              # Exemplo de uso do pacote
├── pubspec.yaml
└── README.md
```

Você deve adaptar esta estrutura para refletir a organização atual dos seus widgets. No seu caso, os widgets estão em `lib/widgets/src/layout` e `lib/widgets/src/form_fields`. Mantenha essa estrutura dentro do pacote.

## 5. Movendo os Widgets para o Novo Pacote

- Copie os diretórios `lib/widgets/src/layout` e `lib/widgets/src/form_fields` para `dashboard_ui_widgets/lib/src/`.
- Mantenha a mesma estrutura de diretórios e nomes de arquivos.
- Verifique se todas as importações internas do pacote são ajustadas para o novo caminho (ex: `import 'src/layout/app_shell.dart';`).

## 6. Configuração do `pubspec.yaml` do Pacote

O `pubspec.yaml` do pacote deve conter metadados e dependências necessárias. Exemplo:

```yaml
name: dashboard_ui_widgets
description: Pacote de widgets para o dashboard UI
version: 0.0.1
homepage: https://github.com/seu_usuario/dashboard_ui_widgets

environment:
  sdk: '>=3.0.0 <4.0.0'
  flutter: \">=3.0.0\"

dependencies:
  flutter:
    sdk: flutter
  # Adicione quaisquer outras dependências que os widgets utilizem
  # Ex: google_fonts, provider, etc.

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^2.0.0

# Para indicar que é um pacote Flutter
flutter:
  # Se o pacote incluir ativos (assets), declare-os aqui
  # assets:
  #   - assets/
```

## 7. Publicação no GitHub como Repositório Privado

- Crie um novo repositório no GitHub com o nome `dashboard_ui_widgets` e marque como privado.
- Navegue até a pasta `dashboard_ui_widgets` no terminal.
- Inicialize o repositório Git: `git init`
- Adicione os arquivos: `git add .`
- Faça o commit: `git commit -m \"Initial commit\"`
- Adicione o repositório remoto: `git remote add origin git@github.com:seu_usuario/dashboard_ui_widgets.git`
- Faça o push: `git push -u origin main`

## 8. Adicionando o Pacote Privado como Dependência

No `pubspec.yaml` do projeto original (`dashboard_ui`), adicione a dependência do pacote como um módulo Git:

```yaml
dependencies:
  flutter:
    sdk: flutter
  dashboard_ui_widgets:
    git:
      url: git@github.com:seu_usuario/dashboard_ui_widgets.git
      # Se quiser especificar uma branch ou tag específica:
      # ref: main
      # ref: v0.0.1

  # Suas outras dependências...
```

### Configuração de Acesso ao Repositório Privado

Para que o Flutter consiga acessar o repositório privado do GitHub, é necessário configurar as credenciais de acesso:

1. **Chave SSH** (recomendado):
   - Certifique-se de que você já tenha uma chave SSH configurada em sua máquina
   - Adicione a chave pública SSH à sua conta do GitHub em `Settings > SSH and GPG keys`
   - Use o formato SSH no `pubspec.yaml` como mostrado acima (`git@github.com:...`)
2. **Token de Acesso Pessoal (PAT)**:
   - Se preferir usar HTTPS, gere um token de acesso pessoal no GitHub
   - Substitua a URL no `pubspec.yaml` por: `https://seu_usuario:seu_token@github.com/seu_usuario/dashboard_ui_widgets.git`

## 9. Configuração de Permissões no GitHub

Para garantir que todos os colaboradores tenham acesso ao repositório privado:

1. Acesse o repositório `dashboard_ui_widgets` no GitHub
2. Vá para a aba `Settings`
3. Clique em `Manage access` na seção `Access`
4. Clique em `Invite teams or people` para adicionar colaboradores individuais ou times
5. Defina as permissões adequadas (normalmente `Read` é suficiente para que possam acessar o pacote)

Se estiver usando uma organização no GitHub, você também pode adicionar o repositório ao time responsável pelo desenvolvimento do projeto principal.

## 10. Importando e Usando os Widgets no Projeto Principal

Depois de adicionar a dependência e executar `flutter pub get`, você pode importar os widgets do pacote no seu projeto principal:

```dart
import 'package:dashboard_ui_widgets/dashboard_ui_widgets.dart';

// Ou, se quiser importar um widget específico:
import 'package:dashboard_ui_widgets/src/layout/app_shell.dart';
```

Agora você pode usar os widgets do pacote normalmente na sua aplicação.

## 11. Boas Práticas e Cuidados Importantes

- **Versionamento Semântico**: Use tags para versionar o pacote no GitHub (ex: `v0.0.1`, `v0.1.0`).
- **Documentação**: Atualize o `README.md` do pacote com instruções de uso e exemplos.
- **Testes**: Adicione testes unitários e de widget para os componentes do pacote.
- **Análise Estática**: Configure `analysis_options.yaml` no pacote para manter a qualidade do código.
- **Controle de Acesso**: Verifique as permissões do repositório privado no GitHub para garantir que os colaboradores tenham acesso.
- **Atualizações**: Lembre-se de atualizar a dependência no projeto principal quando fizer alterações no pacote (executando `flutter pub get` novamente).
- **Organização**: Mantenha a estrutura de diretórios e convenções de nomenclatura consistentes entre o pacote e o projeto principal.
- **Dependências Compatíveis**: Verifique que as versões das dependências usadas no pacote são compatíveis com as do projeto principal.