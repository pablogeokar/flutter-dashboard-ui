# 🚀 Exemplo de Uso - Widgets de Dialog Genéricos

Este arquivo mostra como usar os widgets de dialog em **qualquer projeto Flutter** após copiar a pasta `lib/widgets/`.

## 📋 Pré-requisitos

1. Copie a pasta `lib/widgets/` para seu projeto
2. Certifique-se de ter o Flutter instalado
3. Importe os widgets necessários

## 🎯 Exemplo Completo - Sistema de Tarefas

### 1. **Importações Necessárias**

```dart
import 'package:flutter/material.dart';
import 'widgets/src/dialog/dialog_service.dart';
import 'widgets/src/dialog/dialog_callbacks.dart';
import 'widgets/src/forms/form_components.dart';
```

### 2. **Tela Principal com Menu**

```dart
class TaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Task Manager')),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Text('Task Manager'),
              decoration: BoxDecoration(color: Colors.blue),
            ),

            // Usar callback genérico para adicionar tarefa
            ListTile(
              leading: Icon(Icons.add_task),
              title: Text('Add Task'),
              onTap: DialogCallbacks.showFormCallback(
                context: context,
                title: 'New Task',
                subtitle: 'Create a new task',
                icon: Icons.add_task,
                form: _buildTaskForm(),
                onConfirm: () => _saveTask(),
                successMessage: 'Task created successfully!',
                cancelMessage: 'Task creation cancelled',
              ),
            ),

            // Usar callback genérico para buscar tarefas
            ListTile(
              leading: Icon(Icons.search),
              title: Text('Search Tasks'),
              onTap: DialogCallbacks.showSearchCallback(
                context: context,
                title: 'Search Tasks',
                searchForm: _buildSearchForm(),
                onSearch: () => _performSearch(),
                successMessage: 'Search completed!',
              ),
            ),

            // Usar callback genérico para configurações
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: DialogCallbacks.showFormCallback(
                context: context,
                title: 'Settings',
                subtitle: 'Configure your preferences',
                icon: Icons.settings,
                form: _buildSettingsForm(),
                onConfirm: () => _saveSettings(),
                successMessage: 'Settings saved!',
              ),
            ),
          ],
        ),
      ),

      body: _buildTaskList(),

      floatingActionButton: FloatingActionButton(
        onPressed: DialogCallbacks.showFormCallback(
          context: context,
          title: 'Quick Add',
          subtitle: 'Add a task quickly',
          icon: Icons.flash_on,
          form: _buildQuickTaskForm(),
          onConfirm: () => _saveQuickTask(),
          successMessage: 'Task added!',
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}
```

### 3. **Formulários Customizados**

```dart
// Formulário de tarefa completo
Widget _buildTaskForm() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      DomaniTextField(
        label: 'Task Title',
        hint: 'Enter task title',
        prefixIcon: Icons.title,
        required: true,
        validator: FormValidators.required('Title is required'),
      ),
      SizedBox(height: 16),

      FormRow.top(
        children: [
          DomaniDropdown<String>(
            label: 'Priority',
            hint: 'Select priority',
            items: [
              DropdownMenuItem(value: 'low', child: Text('Low')),
              DropdownMenuItem(value: 'medium', child: Text('Medium')),
              DropdownMenuItem(value: 'high', child: Text('High')),
            ],
          ),
          DomaniDropdown<String>(
            label: 'Category',
            hint: 'Select category',
            items: [
              DropdownMenuItem(value: 'work', child: Text('Work')),
              DropdownMenuItem(value: 'personal', child: Text('Personal')),
              DropdownMenuItem(value: 'shopping', child: Text('Shopping')),
            ],
          ),
        ],
      ),
      SizedBox(height: 16),

      DomaniTextField(
        label: 'Description',
        hint: 'Enter task description',
        maxLines: 3,
        helperText: 'Optional detailed description',
      ),
      SizedBox(height: 16),

      FormRow.top(
        children: [
          DomaniTextField(
            label: 'Due Date',
            hint: 'DD/MM/YYYY',
            prefixIcon: Icons.calendar_today,
            keyboardType: TextInputType.datetime,
          ),
          DomaniTextField(
            label: 'Estimated Hours',
            hint: '0.0',
            prefixIcon: Icons.access_time,
            keyboardType: TextInputType.number,
          ),
        ],
      ),
    ],
  );
}

// Formulário de busca
Widget _buildSearchForm() {
  return Column(
    children: [
      DomaniTextField(
        label: 'Search Term',
        hint: 'Enter keywords',
        prefixIcon: Icons.search,
      ),
      SizedBox(height: 16),

      FormRow.top(
        children: [
          DomaniDropdown<String>(
            label: 'Status',
            hint: 'Any status',
            items: [
              DropdownMenuItem(value: 'pending', child: Text('Pending')),
              DropdownMenuItem(value: 'completed', child: Text('Completed')),
              DropdownMenuItem(value: 'cancelled', child: Text('Cancelled')),
            ],
          ),
          DomaniDropdown<String>(
            label: 'Priority',
            hint: 'Any priority',
            items: [
              DropdownMenuItem(value: 'low', child: Text('Low')),
              DropdownMenuItem(value: 'medium', child: Text('Medium')),
              DropdownMenuItem(value: 'high', child: Text('High')),
            ],
          ),
        ],
      ),
    ],
  );
}

// Formulário rápido
Widget _buildQuickTaskForm() {
  return DomaniTextField(
    label: 'Quick Task',
    hint: 'What needs to be done?',
    prefixIcon: Icons.flash_on,
    required: true,
    autofocus: true,
    validator: FormValidators.required('Task is required'),
  );
}
```

### 4. **Lista de Tarefas com Ações**

```dart
Widget _buildTaskList() {
  return ListView.builder(
    itemCount: tasks.length,
    itemBuilder: (context, index) {
      final task = tasks[index];
      return Card(
        margin: EdgeInsets.all(8),
        child: ListTile(
          leading: Icon(
            task.isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
            color: task.isCompleted ? Colors.green : Colors.grey,
          ),
          title: Text(task.title),
          subtitle: Text(task.description ?? 'No description'),
          trailing: PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text('Edit'),
                value: 'edit',
              ),
              PopupMenuItem(
                child: Text('Delete'),
                value: 'delete',
              ),
            ],
            onSelected: (value) {
              if (value == 'edit') {
                // Usar dialog genérico para editar
                DialogCallbacks.showFormCallback(
                  context: context,
                  title: 'Edit Task',
                  subtitle: 'Update task information',
                  icon: Icons.edit,
                  form: _buildEditTaskForm(task),
                  onConfirm: () => _updateTask(task),
                  successMessage: 'Task updated!',
                )();
              } else if (value == 'delete') {
                // Usar dialog genérico para confirmar exclusão
                DialogCallbacks.showConfirmationCallback(
                  context: context,
                  title: 'Delete Task',
                  message: 'Are you sure you want to delete "${task.title}"?',
                  confirmText: 'Delete',
                  icon: Icons.warning,
                  onConfirm: () => _deleteTask(task),
                  successMessage: 'Task deleted!',
                )();
              }
            },
          ),
        ),
      );
    },
  );
}
```

### 5. **Métodos de Ação**

```dart
void _saveTask() {
  // Implementar lógica de salvamento
  print('Saving new task...');
}

void _saveQuickTask() {
  // Implementar lógica de salvamento rápido
  print('Saving quick task...');
}

void _updateTask(Task task) {
  // Implementar lógica de atualização
  print('Updating task: ${task.title}');
}

void _deleteTask(Task task) {
  // Implementar lógica de exclusão
  print('Deleting task: ${task.title}');
}

void _performSearch() {
  // Implementar lógica de busca
  print('Performing search...');
}

void _saveSettings() {
  // Implementar lógica de configurações
  print('Saving settings...');
}
```

## 🎨 Customização Visual

### Temas Personalizados

```dart
// No seu main.dart
MaterialApp(
  theme: ThemeData(
    primarySwatch: Colors.blue,
    // Os dialogs herdarão automaticamente o tema
  ),
  home: TaskScreen(),
)
```

### Cores Customizadas

```dart
// Usar cores específicas nos callbacks
DialogCallbacks.showFormCallback(
  context: context,
  title: 'Custom Dialog',
  form: MyForm(),
  successMessage: 'Success!',
  // O SnackBar usará as cores padrão do tema
)
```

## 🔧 Validação de Formulários

```dart
DomaniTextField(
  label: 'Email',
  validator: FormValidators.combine([
    FormValidators.required('Email is required'),
    FormValidators.email('Enter a valid email'),
  ]),
)

DomaniTextField(
  label: 'Phone',
  inputFormatters: [FormFormatters.telefone()],
  validator: FormValidators.telefone('Enter a valid phone'),
)
```

## 📱 Responsividade

Os dialogs são automaticamente responsivos:

- **Mobile**: Largura máxima 90% da tela
- **Tablet**: Largura máxima 600px
- **Desktop**: Largura máxima 800px

```dart
DialogService.showFormDialog(
  context: context,
  title: 'Responsive Dialog',
  maxWidth: 700, // Customizar se necessário
  form: MyForm(),
)
```

## ✅ Vantagens dos Widgets Genéricos

1. **🔄 Reutilizáveis**: Copie e use em qualquer projeto
2. **🎨 Consistentes**: Visual uniforme em toda aplicação
3. **📱 Responsivos**: Funcionam em mobile, tablet e desktop
4. **♿ Acessíveis**: Suporte completo a acessibilidade
5. **🔧 Customizáveis**: Fácil personalização sem quebrar funcionalidade
6. **📖 Documentados**: Exemplos claros e documentação completa

## 🚀 Próximos Passos

1. Copie a pasta `lib/widgets/` para seu projeto
2. Adapte os exemplos acima para suas necessidades
3. Customize os temas e cores conforme seu design
4. Implemente a lógica de negócio específica do seu projeto
5. Aproveite a consistência e produtividade!
