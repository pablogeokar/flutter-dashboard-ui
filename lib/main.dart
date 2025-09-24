import 'package:flutter/material.dart';
import 'theme.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dashboard UI',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppTheme.primary, // Your primary color from theme file
          brightness: Brightness.dark, // Material 3 dark theme
        ),
        // Additional Material 3 styling
        navigationRailTheme: NavigationRailThemeData(
          backgroundColor: Theme.of(context).colorScheme.surface,
          indicatorColor: Theme.of(context).colorScheme.primaryContainer,
        ),
        drawerTheme: DrawerThemeData(
          backgroundColor: Theme.of(context).colorScheme.surface,
        ),
      ),
      home: const DashboardPage(),
    );
  }
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;

  static const List<String> _titles = [
    'Painel Principal',
    'Análises',
    'Relatórios',
    'Projetos',
    'Calendário',
    'Configurações',
    'Perfil',
  ];

  @override
  Widget build(BuildContext context) {
    // Determine screen type based on width
    final screenWidth = MediaQuery.of(context).size.width;
    final isLargeScreen = screenWidth >= 768;

    return LayoutBuilder(
      builder: (context, constraints) {
        if (isLargeScreen) {
          // For large screens, show sidebar and content side by side
          return Scaffold(
            body: Row(
              children: [
                // Sidebar that's always visible on large screens
                SizedBox(
                  width: 280,
                  child: ResponsiveDrawer(
                    currentIndex: _selectedIndex,
                    onTap: (int index) {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                  ),
                ),
                // Main content area
                Expanded(child: _buildMainContent()),
              ],
            ),
          );
        } else {
          // For small screens, use traditional drawer
          return Scaffold(
            appBar: AppBar(
              leading: Builder(
                builder: (context) {
                  return IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  );
                },
              ),
              title: Text(_titles[_selectedIndex]),
              surfaceTintColor: Colors.transparent,
              shadowColor: Colors.transparent,
              actions: [
                IconButton(
                  icon: const Icon(Icons.notifications),
                  onPressed: () {},
                ),
                const SizedBox(width: 8),
                Container(
                  margin: const EdgeInsets.only(right: 16),
                  child: const CircleAvatar(
                    radius: 18,
                    backgroundImage: AssetImage('assets/eikos.png'),
                  ),
                ),
              ],
            ),
            drawer: ResponsiveDrawer(
              currentIndex: _selectedIndex,
              onTap: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
                if (context.mounted) {
                  Navigator.pop(context);
                }
              },
            ),
            body: _buildBodyContent(),
          );
        }
      },
    );
  }

  Widget _buildMainContent() {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Don't show back button
        title: Text(_titles[_selectedIndex]),
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        actions: [
          IconButton(icon: const Icon(Icons.notifications), onPressed: () {}),
          const SizedBox(width: 8),
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: const CircleAvatar(
              radius: 18,
              backgroundImage: AssetImage('assets/eikos.png'),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.surface,
              Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
            ],
          ),
        ),
        child: _buildBodyContent(),
      ),
    );
  }

  Widget _buildBodyContent() {
    // Placeholder content - will replace with actual dashboard cards
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ResponsiveDashboard(selectedIndex: _selectedIndex),
    );
  }
}

class ResponsiveDrawer extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const ResponsiveDrawer({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final List<DrawerItem> items = [
      const DrawerItem(title: 'Painel Principal', icon: Icons.dashboard, index: 0),
      const DrawerItem(title: 'Análises', icon: Icons.analytics, index: 1),
      const DrawerItem(
        title: 'Relatórios',
        icon: Icons.insert_drive_file,
        index: 2,
      ),
      const DrawerItem(title: 'Projetos', icon: Icons.folder, index: 3),
      const DrawerItem(title: 'Calendário', icon: Icons.calendar_today, index: 4),
    ];

    final List<DrawerItem> bottomItems = [
      const DrawerItem(title: 'Configurações', icon: Icons.settings, index: 5),
      const DrawerItem(title: 'Perfil', icon: Icons.person, index: 6),
    ];

    return Drawer(
      child: Container(
        color: Theme.of(
          context,
        ).colorScheme.surface, // Dark background for drawer
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Enhanced header with logo
            Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Theme.of(
                  context,
                ).colorScheme.surface, // Match sidebar background
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Logo area - using image instead of CircleAvatar for rectangular logo
                  Container(
                    height: 60,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Image.asset(
                      'assets/eikos.png',
                      fit: BoxFit.contain,
                      // Remove color property to show logo in original colors
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    height: 1,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Painel Administrativo',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.only(left: 16, right: 16),
                itemCount: items.length + 1, // +1 for the separator
                separatorBuilder: (context, index) {
                  if (index == items.length) {
                    // Add a separator before the bottom items
                    return Container(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Divider(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                    );
                  }
                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                    child: Divider(
                      color: Theme.of(
                        context,
                      ).colorScheme.outline.withOpacity(0.3),
                    ),
                  );
                },
                itemBuilder: (context, index) {
                  if (index < items.length) {
                    final item = items[index];
                    return _buildDrawerItem(context, item);
                  } else {
                    // Render the bottom items
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Column(
                        children: bottomItems
                            .map((item) => _buildDrawerItem(context, item))
                            .toList(),
                      ),
                    );
                  }
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    size: 16,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'v1.0.0',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

    Widget _buildDrawerItem(BuildContext context, DrawerItem item) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Icon(
          item.icon,
          color: currentIndex == item.index
              ? AppTheme.primary // Your primary color from theme file
              : Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        title: Text(
          item.title,
          style: TextStyle(
            fontWeight: currentIndex == item.index
                ? FontWeight.w600
                : FontWeight.normal,
            color: currentIndex == item.index
                ? AppTheme.primary // Your primary color from theme file
                : Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        selected: currentIndex == item.index,
        selectedTileColor: AppTheme.primary.withOpacity(0.15), // Your primary color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: currentIndex == item.index
                ? AppTheme.primary.withOpacity(0.5) // Your primary color
                : Colors.transparent,
            width: 0.5,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        onTap: () => onTap(item.index),
      ),
    );
  }
}

class DrawerItem {
  final String title;
  final IconData icon;
  final int index;

  const DrawerItem({
    required this.title,
    required this.icon,
    required this.index,
  });
}

class ResponsiveDashboard extends StatelessWidget {
  final int selectedIndex;

  const ResponsiveDashboard({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _getPageTitle(selectedIndex),
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 16),
        Expanded(
          child: selectedIndex == 0
              ? _buildDashboardOverview(context)
              : _buildPageContent(context),
        ),
      ],
    );
  }

  String _getPageTitle(int index) {
    const titles = [
      'Visão Geral do Painel',
      'Relatório de Análises',
      'Métricas de Desempenho',
      'Gestão de Projetos',
      'Visualização de Calendário',
      'Configurações do Sistema',
      'Perfil do Usuário',
    ];
    return titles[index];
  }

  Widget _buildDashboardOverview(BuildContext context) {
    // Return a placeholder for the dashboard page while under construction
    return const EmConstrucaoPlaceholder();
  }

  Widget _buildPageContent(BuildContext context) {
    // Return a placeholder for all pages under construction
    return const EmConstrucaoPlaceholder();
  }

  int _getCrossAxisCount(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth >= 1200) {
      return 4; // 4 columns on large screens
    } else if (screenWidth >= 768) {
      return 2; // 2 columns on medium screens
    } else {
      return 1; // 1 column on small screens
    }
  }

  List<Widget> _generateDashboardCards(BuildContext context, int cardCount) {
    // Create a list of dashboard cards based on the selected page
    return List.generate(
      cardCount,
      (index) => DashboardCard(
        title: _getCardTitle(selectedIndex, index),
        subtitle: _getCardSubtitle(selectedIndex, index),
        icon: _getCardIcon(selectedIndex, index),
      ),
    );
  }

  String _getCardTitle(int selectedIndex, int index) {
    const List<List<String>> titles = [
      // Página do Painel Principal
      [
        'Receita Total',
        'Usuários Ativos',
        'Taxa de Conversão',
        'Métricas de Desempenho',
        'Status do Sistema',
        'Atividade Recente',
      ],
      // Página de Análises
      [
        'Receita Total',
        'Usuários Ativos',
        'Taxa de Conversão',
        'Métricas de Desempenho',
        'Status do Sistema',
        'Atividade Recente',
        'Análises de Crescimento',
        'Taxa de Engajamento',
      ],
      // Página de Relatórios
      [
        'Relatórios de Vendas',
        'Análise de Tráfego',
        'Demografia dos Usuários',
        'Crescimento de Receita',
        'Métricas de Desempenho',
        'Relatórios do Sistema',
      ],
      // Página de Projetos
      [
        'Projetos Ativos',
        'Tarefas Concluídas',
        'Produtividade da Equipe',
        'Linha do Tempo do Projeto',
        'Alocação de Recursos',
        'Utilização de Orçamento',
      ],
      // Página de Calendário
      [
        'Eventos Futuros',
        'Calendário da Equipe',
        'Milestones de Projetos',
        'Agenda de Reuniões',
        'Lembretes de Tarefas',
        'Acompanhamento de Tempo',
      ],
      // Página de Configurações
      [
        'Configurações do Sistema',
        'Preferências do Usuário',
        'Opções de Segurança',
        'Configurações de Notificação',
        'Controles de Privacidade',
        'Backup & Sincronização',
      ],
      // Página de Perfil
      [
        'Perfil do Usuário',
        'Configurações da Conta',
        'Configurações de Privacidade',
        'Aplicativos Conectados',
        'Registro de Atividade',
        'Informações de Assinatura',
      ],
    ];

    final pageTitles = titles[selectedIndex % titles.length];
    return pageTitles[index % pageTitles.length];
  }

  String _getCardSubtitle(int selectedIndex, int index) {
    const List<List<String>> subtitles = [
      // Página do Painel Principal
      [
        'Este Mês',
        'Online Agora',
        'Últimos 30 Dias',
        'Saúde do Sistema',
        'Todos os Sistemas Ativos',
        'Atualizações Recentes',
      ],
      // Página de Análises
      [
        'Este Mês',
        'Online Agora',
        'Últimos 30 Dias',
        'Saúde do Sistema',
        'Todos os Sistemas Ativos',
        'Atualizações Recentes',
        'Crescimento no 3º Trimestre',
        'Engajamento do Usuário',
      ],
      // Página de Relatórios
      [
        'Relatório Mensal',
        'Fontes de Tráfego',
        'Grupos de Idade',
        'Análise de Receita',
        'Métricas de Desempenho',
        'Relatórios do Sistema',
      ],
      // Página de Projetos
      [
        'Projetos Ativos',
        'Tarefas Concluídas',
        'Eficiência da Equipe',
        'Visão Geral da Linha do Tempo',
        'Alocação de Recursos',
        'Orçamento Utilizado',
      ],
      // Página de Calendário
      [
        'Próximos 7 Dias',
        'Agenda da Equipe',
        'Marcos de Projeto',
        'Próximas Reuniões',
        'Prazos de Tarefas',
        'Acompanhamento de Tempo',
      ],
      // Página de Configurações
      [
        'Configuração do Sistema',
        'Preferências do Usuário',
        'Configurações de Segurança',
        'Preferências de Notificação',
        'Controles de Privacidade',
        'Configurações de Backup',
      ],
      // Página de Perfil
      [
        'Informações Pessoais',
        'Detalhes da Conta',
        'Configurações de Privacidade',
        'Aplicações Conectadas',
        'Atividade Recente',
        'Detalhes da Assinatura',
      ],
    ];

    final pageSubtitles = subtitles[selectedIndex % subtitles.length];
    return pageSubtitles[index % pageSubtitles.length];
  }

  IconData _getCardIcon(int selectedIndex, int index) {
    const List<List<IconData>> icons = [
      // Dashboard page
      [
        Icons.monetization_on,
        Icons.people,
        Icons.trending_up,
        Icons.speed,
        Icons.check_circle,
        Icons.notifications,
      ],
      // Analytics page
      [
        Icons.monetization_on,
        Icons.people,
        Icons.trending_up,
        Icons.speed,
        Icons.check_circle,
        Icons.notifications,
        Icons.show_chart,
        Icons.thumb_up,
      ],
      // Reports page
      [
        Icons.bar_chart,
        Icons.traffic,
        Icons.group,
        Icons.attach_money,
        Icons.speed,
        Icons.insert_drive_file,
      ],
      // Projects page
      [
        Icons.folder,
        Icons.check_circle,
        Icons.group_work,
        Icons.timeline,
        Icons.assignment,
        Icons.account_balance_wallet,
      ],
      // Calendar page
      [
        Icons.event,
        Icons.today,
        Icons.flag,
        Icons.calendar_today,
        Icons.alarm,
        Icons.timer,
      ],
      // Settings page
      [
        Icons.settings,
        Icons.person,
        Icons.security,
        Icons.notifications,
        Icons.lock,
        Icons.backup,
      ],
      // Profile page
      [
        Icons.person,
        Icons.settings,
        Icons.lock,
        Icons.apps,
        Icons.history,
        Icons.card_membership,
      ],
    ];

    final pageIcons = icons[selectedIndex % icons.length];
    return pageIcons[index % pageIcons.length];
  }
}

class DashboardCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const DashboardCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    // Extract index from title string (Card 1, Card 2, etc.)
    int getIndex() {
      try {
        return int.parse(title.split(' ')[1]);
      } catch (e) {
        return 1; // default to 1 if parsing fails
      }
    }

    int cardIndex = getIndex();

    // Use your primary color from theme file
    final primaryColor = AppTheme.primary;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
          width: 0.5,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).colorScheme.surface,
              Theme.of(context).colorScheme.surfaceVariant,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: primaryColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      icon,
                      color: primaryColor,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),
              Container(
                alignment: Alignment.centerRight,
                child: Text(
                  '${(cardIndex * 100 + 50).toStringAsFixed(0)}',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: primaryColor,
                      ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EmConstrucaoPlaceholder extends StatelessWidget {
  const EmConstrucaoPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.construction,
              size: 80,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 24),
            Text(
              'Página em Construção',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'Esta página está sendo desenvolvida e estará disponível em breve.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.info_outline,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Volte mais tarde para ver a experiência completa',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
