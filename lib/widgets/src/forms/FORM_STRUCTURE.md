# 🏗️ Estrutura Padronizada de Formulários - Domani Fiscal

## 📁 Organização das Pastas

### **lib/widgets/src/form_layout/** - Widgets Individuais

Widgets de formulário especializados e reutilizáveis:

```
form_layout/
├── text_input_field.dart          # Campo de texto
├── select_input_field.dart        # Dropdown/Select ✅ PADRÃO
├── date_input_field.dart          # Campo de data
├── monetary_input_field.dart      # Campo monetário
├── textarea_field.dart            # Área de texto
├── custom_button.dart             # Botões customizados
└── currency_pt_br_input_formatter.dart # Formatadores
```

### **lib/widgets/src/forms/** - Sistema de Layout e Validação

Sistema de alto nível para organização e validação:

```
forms/
├── form_components.dart           # Exportações e aliases
├── form_row.dart                 # Sistema de alinhamento
├── form_validators.dart          # Validações
└── README.md                     # Documentação
```

## 🎯 Padronização Implementada

### ✅ **SelectInputField - Widget Padrão para Dropdowns**

**Localização:** `lib/widgets/src/form_layout/select_input_field.dart`

**Características:**

- ✅ API moderna (não usa DropdownButtonFormField deprecated)
- ✅ Estados visuais consistentes (hover, focus, error)
- ✅ Animações suaves
- ✅ Validação integrada
- ✅ Altura fixa consistente (48px)
- ✅ Suporte a temas claro/escuro

**Uso Recomendado:**

```dart
import '../form_layout/select_input_field.dart';

SelectInputField<String>(
  labelText: 'Tipo de Pessoa',
  hintText: 'Selecione o tipo',
  value: selectedType,
  onChanged: (value) => setState(() => selectedType = value),
  options: [
    SelectOption(value: 'PF', label: 'Pessoa Física'),
    SelectOption(value: 'PJ', label: 'Pessoa Jurídica'),
  ],
  validator: (value) => value == null ? 'Campo obrigatório' : null,
)
```

### 🔄 **DomaniDropdown - Alias para Compatibilidade**

**Localização:** `lib/widgets/src/forms/form_components.dart`

**Propósito:** Manter compatibilidade com código existente

**Status:** ⚠️ **DEPRECATED** - Use `SelectInputField` em novos códigos

```dart
// ❌ EVITAR em novos códigos (apenas para compatibilidade)
DomaniDropdown<String>(
  label: 'Tipo',
  hint: 'Selecione',
  items: [
    DropdownMenuItem(value: 'PF', child: Text('Pessoa Física')),
  ],
  onChanged: (value) => setState(() => selectedType = value),
)

// ✅ USAR em novos códigos
SelectInputField<String>(
  labelText: 'Tipo',
  hintText: 'Selecione',
  options: [
    SelectOption(value: 'PF', label: 'Pessoa Física'),
  ],
  onChanged: (value) => setState(() => selectedType = value),
)
```

## 🔧 Migração Gradual

### Fase 1: ✅ **Concluída**

- [x] Remoção do `DomaniDropdown` duplicado
- [x] Criação do alias para compatibilidade
- [x] Exportação do `SelectInputField` em `form_components.dart`
- [x] Correção de imports e dependências

### Fase 2: 🔄 **Em Andamento**

- [ ] Migração gradual dos formulários existentes
- [ ] Atualização da documentação
- [ ] Testes de compatibilidade

### Fase 3: 📋 **Planejada**

- [ ] Remoção do alias `DomaniDropdown`
- [ ] Padronização completa de todos os widgets de formulário
- [ ] Documentação final

## 📖 Guia de Boas Práticas

### ✅ **Para Novos Desenvolvimentos:**

1. **Use widgets da pasta `form_layout/`** diretamente
2. **Importe especificamente** o que precisa
3. **Siga a API do `SelectInputField`** para dropdowns
4. **Use `FormRow`** para alinhamento

```dart
// ✅ CORRETO
import '../form_layout/select_input_field.dart';
import '../form_layout/text_input_field.dart';

// ✅ CORRETO - Para múltiplos widgets
import '../../widgets/src/forms/form_components.dart'; // Exporta tudo
```

### ✅ **Para Código Existente:**

1. **Mantenha funcionando** com o alias `DomaniDropdown`
2. **Migre gradualmente** quando possível
3. **Teste bem** após migração

### ❌ **Evitar:**

1. **Não criar** novos widgets de dropdown
2. **Não duplicar** funcionalidades existentes
3. **Não quebrar** compatibilidade sem aviso

## 🎨 Consistência Visual

### **Altura Padrão:** 48px

Todos os campos de formulário têm altura consistente:

- `TextInputField`: 48px
- `SelectInputField`: 48px
- `DateInputField`: 48px
- `MonetaryInputField`: 48px

### **Estados Visuais:**

- **Normal**: Borda cinza, fundo claro/escuro
- **Hover**: Borda azul clara, sombra sutil
- **Focus**: Borda azul, sombra mais intensa
- **Error**: Borda vermelha, texto de erro

### **Animações:**

- **Duração**: 200ms (AppAnimations.fast)
- **Curva**: easeOut
- **Propriedades**: cor da borda, sombra, rotação do ícone

## 🔍 Troubleshooting

### **Problema: Import não encontrado**

```dart
// ❌ ERRO
import 'widgets/dropdown.dart'; // Não existe

// ✅ SOLUÇÃO
import '../form_layout/select_input_field.dart';
```

### **Problema: API diferente**

```dart
// ❌ API antiga (DomaniDropdown)
items: [DropdownMenuItem(value: 'x', child: Text('X'))]

// ✅ API nova (SelectInputField)
options: [SelectOption(value: 'x', label: 'X')]
```

### **Problema: Validação não funciona**

```dart
// ✅ SOLUÇÃO - Usar validator do SelectInputField
SelectInputField<String>(
  validator: (value) => value == null ? 'Obrigatório' : null,
  // ...
)
```

---

**Padronização implementada**: Dezembro 2024  
**Status**: ✅ Funcional e compatível  
**Próximo passo**: Migração gradual dos formulários existentes
