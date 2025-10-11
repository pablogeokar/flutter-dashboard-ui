# Módulo de Formulários

Este módulo centraliza todos os widgets e utilitários relacionados à criação de formulários no sistema. A estrutura foi desenhada para ser modular, organizada e de fácil manutenção.

## Estrutura de Pastas

A pasta `forms` está organizada da seguinte maneira:

```
lib/widgets/src/forms/
├── button.dart                 # Widget de botão padrão (FormButton)
├── inputs/                     # Widgets de campo de entrada
│   ├── text_input_field.dart
│   ├── select_input_field.dart
│   ├── date_input_field.dart
│   └── ...
├── layout/                     # Widgets para estrutura e alinhamento de formulários
│   └── form_row.dart
├── validators/                 # Funções e classes de validação
│   └── form_validators.dart
└── formatters/                 # Formatadores de texto para inputs
    └── currency_input_formatter.dart
```

## Componentes Principais

### `FormButton`
O `FormButton` é o botão padrão para todas as ações de formulário (Salvar, Cancelar, etc.). Ele é altamente customizável através das propriedades `variant` e `size`.

### `inputs/`
Contém todos os widgets de campo de formulário, como `TextInputField`, `SelectInputField`, `DateInputField`, etc. Estes são os blocos de construção para qualquer formulário.

### `layout/`
Widgets que ajudam a estruturar os formulários, como o `FormRow`, que garante o alinhamento correto dos campos.

### `validators/`
Contém a lógica de validação, como `FormValidators.required`, `FormValidators.email`, etc., para garantir a consistência e a integridade dos dados.

### `formatters/`
Inclui `TextInputFormatter` para mascarar e formatar a entrada do usuário, como o `CurrencyInputFormatter` para valores monetários.

## Como Usar

Para criar um formulário, combine os widgets das pastas `inputs` e `layout`. Aplique validações usando os `FormValidators`.

**Exemplo:**
```dart
import 'package:dashboard_ui/widgets/form.dart'; // Barrel file for inputs
import 'package:dashboard_ui/widgets/src/forms/layout/form_row.dart';
import 'package:dashboard_ui/widgets/src/forms/validators/form_validators.dart';

// ...

Form(
  key: _formKey,
  child: Column(
    children: [
      FormRow.top(
        children: [
          TextInputField(
            labelText: 'Nome',
            validator: FormValidators.required('O nome é obrigatório.'),
          ),
          SelectInputField(
            labelText: 'Tipo',
            options: [...],
            validator: FormValidators.required('O tipo é obrigatório.'),
          ),
        ],
      ),
      SizedBox(height: 24),
      FormButton(
        text: 'Salvar',
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            // Processar dados
          }
        },
      ),
    ],
  ),
)
```