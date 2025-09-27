import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dashboard_ui/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  // Garante um ambiente limpo para SharedPreferences em cada teste
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('Troca de tema funciona ao clicar no botão do AppBar', (
    WidgetTester tester,
  ) async {
    // 1. Constrói a aplicação
    await tester.pumpWidget(const MainApp());

    // O ThemeManager inicializa com o tema claro e notifica os listeners.
    // pumpAndSettle aguarda essas atualizações.
    await tester.pumpAndSettle();

    // 2. Verifica o estado inicial (Tema Claro)
    var materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
    // O estado inicial do ThemeManager é 'light'
    expect(materialApp.themeMode, ThemeMode.light);

    // Verifica se o ícone para ativar o modo escuro está visível
    final darkModeIcon = find.byIcon(Icons.dark_mode);
    expect(darkModeIcon, findsOneWidget);
    expect(find.byIcon(Icons.light_mode), findsNothing);

    // 3. Simula o toque no botão para trocar para o Tema Escuro
    await tester.tap(darkModeIcon);
    await tester.pumpAndSettle();

    // 4. Verifica se o tema mudou para Escuro
    materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
    expect(materialApp.themeMode, ThemeMode.dark);

    // Verifica se o ícone para ativar o modo claro está visível
    final lightModeIcon = find.byIcon(Icons.light_mode);
    expect(lightModeIcon, findsOneWidget);
    expect(find.byIcon(Icons.dark_mode), findsNothing);

    // 5. Simula o toque para voltar ao Tema Claro
    await tester.tap(lightModeIcon);
    await tester.pumpAndSettle();

    // 6. Verifica se o tema voltou para Claro
    materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
    expect(materialApp.themeMode, ThemeMode.light);
    expect(find.byIcon(Icons.dark_mode), findsOneWidget);
    expect(find.byIcon(Icons.light_mode), findsNothing);
  });
}
