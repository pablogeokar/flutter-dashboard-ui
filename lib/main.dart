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
            // Enhanced header with logo
            Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Theme.of(context).colorScheme.surface,
                    Theme.of(context).colorScheme.surfaceVariant,
                  ],
                ),
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
                      color: Colors.white, // To enhance the white text visibility
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
                    'Admin Panel',
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
                      color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
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
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        title: Text(
          item.title,
          style: TextStyle(
            fontWeight: currentIndex == item.index
                ? FontWeight.w600
                : FontWeight.normal,
            color: currentIndex == item.index
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        selected: currentIndex == item.index,
        selectedTileColor: Theme.of(context)
            .colorScheme
            .primary
            .withOpacity(0.15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: currentIndex == item.index
                ? Theme.of(context).colorScheme.primary.withOpacity(0.5)
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
    return SingleChildScrollView(
      child: Column(
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
          Card(
            child: Container(
              height: 300, // Fixed height for the chart section
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Revenue Overview',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        Text(
                          'Last 30 days',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Theme.of(context).colorScheme.onSurfaceVariant,
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.2),
                        ),
                        child: const Center(
                          child: Text(
                            '📊 Chart would go here',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
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
    const List<List<String>> titles = [
      // Dashboard page
      [
        'Total Revenue',
        'Active Users',
        'Conversion Rate',
        'Performance Metrics',
        'System Status',
        'Recent Activity',
      ],
      // Analytics page
      [
        'Total Revenue',
        'Active Users',
        'Conversion Rate',
        'Performance Metrics',
        'System Status',
        'Recent Activity',
        'Growth Analytics',
        'Engagement Rate',
      ],
      // Reports page
      [
        'Sales Reports',
        'Traffic Analysis',
        'User Demographics',
        'Revenue Growth',
        'Performance Metrics',
        'System Reports',
      ],
      // Projects page
      [
        'Active Projects',
        'Completed Tasks',
        'Team Productivity',
        'Project Timeline',
        'Resource Allocation',
        'Budget Utilization',
      ],
      // Calendar page
      [
        'Upcoming Events',
        'Team Calendar',
        'Project Deadlines',
        'Meeting Schedule',
        'Task Reminders',
        'Time Tracking',
      ],
      // Settings page
      [
        'System Settings',
        'User Preferences',
        'Security Options',
        'Notification Settings',
        'Privacy Controls',
        'Backup & Sync',
      ],
      // Profile page
      [
        'User Profile',
        'Account Settings',
        'Privacy Settings',
        'Connected Apps',
        'Activity Log',
        'Subscription Info',
      ],
    ];
    
    final pageTitles = titles[selectedIndex % titles.length];
    return pageTitles[index % pageTitles.length];
  }

  String _getCardSubtitle(int selectedIndex, int index) {
    const List<List<String>> subtitles = [
      // Dashboard page
      [
        'This Month',
        'Online Now',
        'Last 30 Days',
        'System Health',
        'All Systems Go',
        'Latest Updates',
      ],
      // Analytics page
      [
        'This Month',
        'Online Now',
        'Last 30 Days',
        'System Health',
        'All Systems Go',
        'Latest Updates',
        'Q3 Growth',
        'User Engagement',
      ],
      // Reports page
      [
        'Monthly Report',
        'Traffic Sources',
        'Age Groups',
        'Revenue Analysis',
        'Performance Metrics',
        'System Reports',
      ],
      // Projects page
      [
        'Active Projects',
        'Tasks Completed',
        'Team Efficiency',
        'Timeline Overview',
        'Resource Allocation',
        'Budget Spent',
      ],
      // Calendar page
      [
        'Next 7 Days',
        'Team Schedule',
        'Project Milestones',
        'Upcoming Meetings',
        'Task Deadlines',
        'Time Tracking',
      ],
      // Settings page
      [
        'System Configuration',
        'User Preferences',
        'Security Settings',
        'Notification Preferences',
        'Privacy Controls',
        'Backup Settings',
      ],
      // Profile page
      [
        'Personal Information',
        'Account Details',
        'Privacy Settings',
        'Connected Applications',
        'Recent Activity',
        'Subscription Details',
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

    // Define different colors for different cards based on their index
    final cardColors = [
      Colors.blue.shade300,
      Colors.green.shade300,
      Colors.orange.shade300,
      Colors.purple.shade300,
      Colors.red.shade300,
      Colors.teal.shade300,
      Colors.indigo.shade300,
      Colors.pink.shade300,
    ];
    
    final colorIndex = cardIndex % cardColors.length;
    final cardColor = cardColors[colorIndex];

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
                      color: cardColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      icon,
                      color: cardColor,
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
                        color: cardColor,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
