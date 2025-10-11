# 📋 Widgets de Formulário - Domani Fiscal

Este diretório contém todos os widgets especializados para criação de formulários profissionais e consistentes.

## 📁 Estrutura de Arquivos

```
forms/
├── README.md              # Esta documentação
├── form_components.dart   # Componentes básicos (TextField, Dropdown, etc.)
├── form_row.dart         # Sistema de alinhamento para linhas de formulário
└── form_layout.dart      # Layouts e containers para formulários
```

## 🎯 Widgets Principais

### 1. **FormRow** - Alinhamento Automático

Resolve problemas de desalinhamento em linhas de formulário.

```dart
FormRow.top(
  children: [
    DomaniTextField(label: 'Email', helperText: 'Para documentos'),
    DomaniTextField(label: 'Telefone'), // Alinha automaticamente
  ],
)
```

**Quando usar:**

- ✅ Campos com distribuição igual
- ✅ Formulários simples
- ✅ Alinhamento automático

### 2. **FormRowFlex** - Proporções Customizadas

Controle granular sobre proporções de cada campo.

```dart
FormRowFlex.top(
  items: [
    FormRowItem(flex: 2, child: DomaniTextField(label: 'Endereço')),
    FormRowItem(flex: 1, child: DomaniTextField(label: 'Número')),
  ],
)
```

**Quando usar:**

- ✅ Proporções específicas (2:1, 3:2:1, etc.)
- ✅ Campos com importâncias diferentes
- ✅ Layouts complexos

### 3. **DomaniTextField** - Campo de Texto Padrão

Campo de texto com design consistente do sistema.

```dart
DomaniTextField(
  label: 'Nome Completo',
  hint: 'Digite seu nome',
  prefixIcon: Icons.person,
  required: true,
  helperText: 'Nome como aparece nos documentos',
)
```

### 4. **DomaniDropdown** - Seleção Padrão

Dropdown com design consistente do sistema.

```dart
DomaniDropdown<String>(
  label: 'Estado',
  hint: 'Selecione',
  items: [
    DropdownMenuItem(value: 'SP', child: Text('São Paulo')),
    DropdownMenuItem(value: 'RJ', child: Text('Rio de Janeiro')),
  ],
)
```

## 🎨 Padrões de Design

### Espaçamento Padrão

- **Entre campos na mesma linha:** 16px
- **Entre linhas de formulário:** 20px
- **Padding interno dos campos:** 16px

### Alinhamento

- **Padrão:** `FormRow.top()` - alinha no topo
- **Campos com botões:** `FormRow.center()` - alinha no centro
- **Casos especiais:** `FormRow.bottom()` - alinha na base

### Proporções Comuns

- **2:1** - Campo principal + secundário
- **1:1:1** - Três campos iguais
- **3:2:1** - Degradê de importância
- **1:2** - Código + descrição

## 📖 Exemplos Práticos

### Formulário de Cliente

```dart
Column(
  children: [
    // Campo único - nome completo
    DomaniTextField(
      label: 'Nome Completo',
      required: true,
      helperText: 'Nome como deve aparecer nos documentos',
    ),

    SizedBox(height: 20),

    // Linha com proporção 2:1 - CPF maior que tipo
    FormRowFlex.top(
      items: [
        FormRowItem(
          flex: 2,
          child: DomaniTextField(label: 'CPF/CNPJ', required: true),
        ),
        FormRowItem(
          flex: 1,
          child: DomaniDropdown(label: 'Tipo', required: true),
        ),
      ],
    ),

    SizedBox(height: 20),

    // Linha com distribuição igual - email e telefone
    FormRow.top(
      children: [
        DomaniTextField(
          label: 'Email',
          helperText: 'Para envio de documentos',
        ),
        DomaniTextField(label: 'Telefone'),
      ],
    ),
  ],
)
```

### Formulário de Endereço

```dart
Column(
  children: [
    // Endereço completo
    DomaniTextField(
      label: 'Endereço',
      helperText: 'Rua, avenida, número e complemento',
    ),

    SizedBox(height: 20),

    // CEP, Cidade e UF com proporções 1:2:1
    FormRowFlex.top(
      items: [
        FormRowItem(flex: 1, child: DomaniTextField(label: 'CEP')),
        FormRowItem(flex: 2, child: DomaniTextField(label: 'Cidade')),
        FormRowItem(flex: 1, child: DomaniDropdown(label: 'UF')),
      ],
    ),
  ],
)
```

## 🔧 Extensões de Conveniência

Para código mais conciso, use as extensões:

```dart
// Ao invés de:
FormRow.top(
  children: [
    DomaniTextField(label: 'Nome'),
    DomaniTextField(label: 'Sobrenome'),
  ],
)

// Use:
[
  DomaniTextField(label: 'Nome'),
  DomaniTextField(label: 'Sobrenome'),
].toFormRow()
```

## 🚀 Melhores Práticas

### ✅ Faça

- Use `FormRow.top()` como padrão
- Mantenha espaçamento consistente (16px entre campos, 20px entre linhas)
- Use `FormRowFlex` quando precisar de proporções específicas
- Documente proporções complexas com comentários
- Teste em diferentes tamanhos de tela

### ❌ Evite

- Misturar `Row` manual com `FormRow` no mesmo formulário
- Usar mais de 4 campos na mesma linha
- Proporções muito desbalanceadas (ex: 10:1)
- Espaçamentos inconsistentes
- Campos muito pequenos em telas grandes

## 🐛 Solução de Problemas

### Campos Desalinhados

**Problema:** Campos ficam em alturas diferentes
**Solução:** Use `FormRow` ao invés de `Row` manual

### Proporções Erradas

**Problema:** Campos não têm o tamanho esperado
**Solução:** Verifique os valores de `flex` no `FormRowFlex`

### Espaçamento Inconsistente

**Problema:** Espaços diferentes entre campos
**Solução:** Use o parâmetro `spacing` padrão (16px)

### Performance

**Problema:** Formulários lentos para renderizar
**Solução:** Evite `IntrinsicHeight` desnecessário - use apenas quando há desalinhamento

## 📚 Referências

- [Flutter Layout Widgets](https://flutter.dev/docs/development/ui/widgets/layout)
- [Material Design Forms](https://material.io/components/text-fields)
- [Accessibility Guidelines](https://flutter.dev/docs/development/accessibility-and-localization/accessibility)

---

**Última atualização:** Dezembro 2024  
**Versão:** 1.0.0  
**Mantido por:** Equipe Domani Fiscal
