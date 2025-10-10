# Contexto do Projeto - Domani Fiscal

## Visão Geral

Sistema de Gestão Fiscal desenvolvido em Flutter para a **Domani Fiscal**. Interface de dashboard profissional com tema claro/escuro, sidebar responsiva e tela de splash.

## Diretrizes Essenciais

- **Idioma:** Português do Brasil (pt-BR) em todo código, comentários e interface
- **Nomenclatura:** Funções, variáveis e componentes em português
- **Branding:** Sempre usar "Domani Fiscal" (nunca "Dashboard UI")
- **Cores:** Azul primário #2563EB (claro) / #3B82F6 (escuro)

## Arquitetura Atual

```
lib/
├── config/sidebar_config.dart
├── screens/ (splash_screen.dart, em_construcao_screen.dart, teste_screen.dart)
├── theme/ (theme.dart, theme_manager.dart, animations.dart, dark.dart, light.dart)
├── widgets/
│   ├── app_initializer.dart, app_layout.dart, dialog.dart, form_layout.dart
│   └── src/app_layout/ (app_shell.dart, responsive_drawer.dart, drawer_list_item.dart, etc.)
└── assets/ (logo_light.png, logo_dark.png)
```

## Padrões de Código

- **Responsividade:** Use `AppTheme.getResponsive*()` para tamanhos adaptativos
- **Cores:** Sempre usar `AppTheme.primaryLight/primaryDark` para consistência
- **Animações:** Durações padronizadas (100ms, 200ms, 300ms)
- **Widgets:** Preferir simplicidade e performance sobre complexidade

## Estado Atual

- **Funcional:** Splash screen, navegação, temas, layouts responsivos
- **Em desenvolvimento:** Telas principais (usam EmConstrucaoPlaceholder)
- **Dialogs:** Cadastros de clientes/fornecedores funcionais
- **Performance:** Estável, sem travamentos

## Próximas Implementações

1. Dashboard com métricas fiscais
2. Relatórios e análises
3. Calendário fiscal
4. Integrações com APIs fiscais
