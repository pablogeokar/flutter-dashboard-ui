import 'package:flutter/material.dart';

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
          seedColor: Colors.blue,
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
    'Dashboard',
    'Analytics',
    'Reports',
    'Projects',
    'Calendar',
    'Settings',
    'Profile',
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
                Expanded(
                  child: _buildMainContent(),
                ),
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
              actions: [
                IconButton(
                  icon: const Icon(Icons.notifications),
                  onPressed: () {},
                ),
                const CircleAvatar(
                  backgroundImage: AssetImage('assets/eikos.png'),
                ),
                const SizedBox(width: 16),
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
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
          const CircleAvatar(
            backgroundImage: AssetImage('assets/eikos.png'),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: _buildBodyContent(),
    );
  }

  Widget _buildBodyContent() {
    // Placeholder content - will replace with actual dashboard cards
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ResponsiveDashboard(
        selectedIndex: _selectedIndex,
      ),
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
      const DrawerItem(
        title: 'Dashboard',
        icon: Icons.dashboard,
        index: 0,
      ),
      const DrawerItem(
        title: 'Analytics',
        icon: Icons.analytics,
        index: 1,
      ),
      const DrawerItem(
        title: 'Reports',
        icon: Icons.insert_drive_file,
        index: 2,
      ),
      const DrawerItem(
        title: 'Projects',
        icon: Icons.folder,
        index: 3,
      ),
      const DrawerItem(
        title: 'Calendar',
        icon: Icons.calendar_today,
        index: 4,
      ),
    ];

    final List<DrawerItem> bottomItems = [
      const DrawerItem(
        title: 'Settings',
        icon: Icons.settings,
        index: 5,
      ),
      const DrawerItem(
        title: 'Profile',
        icon: Icons.person,
        index: 6,
      ),
    ];

    return Drawer(
      child: Container(
        color: Theme.of(context).colorScheme.surface, // Dark background for drawer
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/eikos.png'),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Dashboard UI',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Colors.white,
                        ),
                  ),
                  Text(
                    'Admin Panel',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white70,
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.zero,
                itemCount: items.length + 1, // +1 for the separator
                separatorBuilder: (context, index) {
                  if (index == items.length) {
                    // Add a separator before the bottom items
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: Divider(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                    );
                  }
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Divider(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                  );
                },
                itemBuilder: (context, index) {
                  if (index < items.length) {
                    final item = items[index];
                    return _buildDrawerItem(context, item);
                  } else {
                    // Render the bottom items
                    return Column(
                      children: bottomItems
                          .map((item) => _buildDrawerItem(context, item))
                          .toList(),
                    );
                  }
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'v1.0.0',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(BuildContext context, DrawerItem item) {
    return ListTile(
      leading: Icon(item.icon),
      title: Text(item.title),
      selected: currentIndex == item.index,
      selectedTileColor: Theme.of(context)
          .colorScheme
          .primary
          .withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      onTap: () => onTap(item.index),
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

  const ResponsiveDashboard({
    super.key,
    required this.selectedIndex,
  });

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
      'Dashboard Overview',
      'Analytics Report',
      'Performance Metrics',
      'Project Management',
      'Calendar View',
      'System Settings',
      'User Profile',
    ];
    return titles[index];
  }

  Widget _buildDashboardOverview(BuildContext context) {
    // Create a specific layout for the dashboard overview page
    return Column(
      children: [
        // Top metrics row
        Row(
          children: [
            Expanded(
              child: DashboardCard(
                title: 'Total Revenue',
                subtitle: 'This Month',
                icon: Icons.monetization_on,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: DashboardCard(
                title: 'Active Users',
                subtitle: 'Online Now',
                icon: Icons.people,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: DashboardCard(
                title: 'Conversion Rate',
                subtitle: 'Last 30 Days',
                icon: Icons.trending_up,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: DashboardCard(
                title: 'Performance',
                subtitle: 'System Health',
                icon: Icons.speed,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Charts section
        Expanded(
          flex: 2,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Revenue Overview',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).colorScheme.outline,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Text('Chart would go here'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPageContent(BuildContext context) {
    // For other pages, use a grid layout
    final cardCount = selectedIndex == 1 ? 8 : 6; // Analytics has more cards
    
    return GridView.count(
      crossAxisCount: _getCrossAxisCount(context),
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      children: _generateDashboardCards(context, cardCount),
    );
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
    const titles = [
      'Total Revenue',
      'Active Users',
      'Conversion Rate',
      'Performance Metrics',
      'System Status',
      'Recent Activity',
      'Growth Analytics',
      'Engagement Rate',
    ];
    return titles[index % titles.length];
  }

  String _getCardSubtitle(int selectedIndex, int index) {
    const subtitles = [
      'This Month',
      'Online Now',
      'Last 30 Days',
      'System Health',
      'All Systems Go',
      'Latest Updates',
      'Q3 Growth',
      'User Engagement',
    ];
    return subtitles[index % subtitles.length];
  }

  IconData _getCardIcon(int selectedIndex, int index) {
    const icons = [
      Icons.monetization_on,
      Icons.people,
      Icons.trending_up,
      Icons.speed,
      Icons.check_circle,
      Icons.notifications,
      Icons.show_chart,
      Icons.thumb_up,
    ];
    return icons[index % icons.length];
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

    return Card(
      elevation: 4,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: Theme.of(context).colorScheme.primary,
                  size: 28,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
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
            ),
            const SizedBox(height: 8),
            Container(
              alignment: Alignment.centerRight,
              child: Text(
                '${(cardIndex * 100 + 50).toStringAsFixed(0)}',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
