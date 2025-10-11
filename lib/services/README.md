# 🔧 Serviços - Domani Fiscal

## Visão Geral

A pasta `lib/services/` contém todos os **serviços** da aplicação - lógica de negócio, utilitários e funcionalidades que não são componentes visuais.

## 🏗️ Arquitetura de Separação

### ✅ **lib/services/** - SERVIÇOS

- **Propósito:** Lógica de negócio, APIs, utilitários
- **Características:** Sem dependência de widgets específicos
- **Exemplos:** FormDialogService, ApiService, DatabaseService

### ✅ **lib/widgets/** - WIDGETS

- **Propósito:** Componentes visuais reutilizáveis
- **Características:** Focados apenas na apresentação
- **Exemplos:** FormDialog, DomaniTextField, AppLayout

### ✅ **lib/screens/** - TELAS

- **Propósito:** Páginas da aplicação
- **Características:** Combinam widgets e serviços
- **Exemplos:** DashboardScreen, EmConstrucaoScreen

## 📁 Estrutura Atual

```
lib/services/
└── dialog/
    └── form_dialog_service.dart  # Serviços de dialog
```

## 🎯 FormDialogService

### Localização

```
lib/services/dialog/form_dialog_service.dart
```

### Import Correto

```dart
import '../../services/dialog/form_dialog_service.dart';
```

### Métodos Disponíveis

#### 🔹 Método Base

```dart
FormDialogService.mostrarFormulario({
  required BuildContext context,
  required String titulo,
  String? subtitulo,
  required Widget formulario,
  // ... outros parâmetros
});
```

#### 🔹 Métodos Específicos

```dart
// Cadastro de cliente
FormDialogService.mostrarCadastroCliente(
  context: context,
  onConfirmar: () => _salvarCliente(),
);

// Cadastro de fornecedor
FormDialogService.mostrarCadastroFornecedor(
  context: context,
  onConfirmar: () => _salvarFornecedor(),
);

// Configurações do sistema
FormDialogService.mostrarConfiguracoes(
  context: context,
  onConfirmar: () => _salvarConfiguracoes(),
);

// Dialog de confirmação
FormDialogService.mostrarConfirmacao(
  context: context,
  titulo: 'Confirmar Ação',
  mensagem: 'Deseja realmente continuar?',
  onConfirmar: () => _executarAcao(),
);

// Dialog de busca
FormDialogService.mostrarBusca(
  context: context,
  titulo: 'Buscar Itens',
  formularioBusca: _buildFormularioBusca(),
  onConfirmar: () => _executarBusca(),
);
```

## ✅ Benefícios da Nova Arquitetura

### 🎯 **Separação Clara de Responsabilidades**

- **Serviços:** Lógica de negócio centralizada
- **Widgets:** Componentes visuais reutilizáveis
- **Telas:** Orquestração de widgets e serviços

### 🔧 **Manutenibilidade**

- Mudanças em serviços não afetam widgets
- Widgets podem ser reutilizados independentemente
- Código mais organizado e fácil de encontrar

### 📈 **Escalabilidade**

- Fácil adicionar novos serviços
- Estrutura preparada para crescimento
- Padrões consistentes

### 🧪 **Testabilidade**

- Serviços podem ser testados independentemente
- Widgets podem ser testados isoladamente
- Mocks mais simples de implementar

## 🚀 Próximos Serviços

### 📊 **ApiService**

```
lib/services/api/
├── api_service.dart          # Cliente HTTP base
├── fiscal_api_service.dart   # APIs fiscais específicas
└── auth_service.dart         # Autenticação
```

### 💾 **DatabaseService**

```
lib/services/database/
├── database_service.dart     # Conexão e operações base
├── cliente_repository.dart   # Repositório de clientes
└── fornecedor_repository.dart # Repositório de fornecedores
```

### 📧 **NotificationService**

```
lib/services/notification/
├── notification_service.dart # Notificações do sistema
├── email_service.dart       # Envio de emails
└── sms_service.dart         # Envio de SMS
```

### 📄 **ReportService**

```
lib/services/report/
├── report_service.dart      # Geração de relatórios
├── pdf_service.dart        # Geração de PDFs
└── excel_service.dart      # Geração de planilhas
```

## 📝 Padrões de Código

### ✅ **Nomenclatura**

- **Serviços:** Sempre terminar com `Service`
- **Métodos:** Verbos em português (mostrar, salvar, buscar)
- **Parâmetros:** Nomes descritivos em português

### ✅ **Estrutura**

```dart
class MeuService {
  /// Método público principal
  static Future<void> metodoPublico({
    required BuildContext context,
    // parâmetros obrigatórios primeiro
    VoidCallback? onSuccess,
    VoidCallback? onError,
  }) {
    // implementação
  }

  /// Métodos privados de apoio
  static Widget _buildComponentePrivado() {
    // implementação
  }
}
```

### ✅ **Documentação**

- Comentários em português
- Explicar propósito e uso
- Exemplos práticos quando necessário

## 🔍 Troubleshooting

### ❌ **Import Incorreto**

```dart
// INCORRETO - local antigo
import '../widgets/src/dialog/form_dialog_service.dart';
```

### ✅ **Import Correto**

```dart
// CORRETO - nova localização
import '../../services/dialog/form_dialog_service.dart';
```

### ❌ **Misturar Responsabilidades**

```dart
// INCORRETO - widget com lógica de negócio
class MeuWidget extends StatelessWidget {
  void _salvarNoBanco() { /* lógica de negócio */ }
}
```

### ✅ **Separação Correta**

```dart
// CORRETO - widget apenas visual
class MeuWidget extends StatelessWidget {
  final VoidCallback onSalvar;
  // widget focado apenas na apresentação
}

// CORRETO - serviço com lógica
class MeuService {
  static void salvarNoBanco() { /* lógica de negócio */ }
}
```

---

**Última atualização:** Dezembro 2024  
**Status:** Implementado e funcional  
**Próxima evolução:** Implementação de ApiService e DatabaseService
