import 'package:flutter/material.dart';
import '../../../theme/theme.dart';

class CommandPalette extends StatefulWidget {
  const CommandPalette({super.key});

  @override
  State<CommandPalette> createState() => _CommandPaletteState();
}

class _CommandPaletteState extends State<CommandPalette> {
  final TextEditingController _searchController = TextEditingController();
  String _searchText = '';

  // Placeholder data with groups
  final List<Map<String, dynamic>> _allItems = [
    {
      'group': 'Navegação',
      'title': 'Dashboard',
      'icon': Icons.dashboard_rounded,
      'onTap': () {},
    },
    {
      'group': 'Cadastros',
      'title': 'Clientes',
      'icon': Icons.people_rounded,
      'onTap': () {},
    },
    {
      'group': 'Cadastros',
      'title': 'Fornecedores',
      'icon': Icons.business_rounded,
      'onTap': () {},
    },
    {
      'group': 'Fiscal',
      'title': 'Apuração ICMS',
      'icon': Icons.calculate_rounded,
      'onTap': () {},
    },
    {
      'group': 'Fiscal',
      'title': 'SPED Fiscal',
      'icon': Icons.description_rounded,
      'onTap': () {},
    },
    {
      'group': 'Relatórios',
      'title': 'Balancetes',
      'icon': Icons.balance_rounded,
      'onTap': () {},
    },
    {
      'group': 'Relatórios',
      'title': 'DRE',
      'icon': Icons.trending_up_rounded,
      'onTap': () {},
    },
    {
      'group': 'Ações',
      'title': 'Lançar Nota Fiscal',
      'icon': Icons.add_circle_outline_rounded,
      'onTap': () {},
    },
    {
      'group': 'Ações',
      'title': 'Configurações',
      'icon': Icons.settings_rounded,
      'onTap': () {},
    },
  ];

  List<Map<String, dynamic>> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    _filteredItems = _allItems;
    _searchController.addListener(() {
      setState(() {
        _searchText = _searchController.text;
        _filterItems();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterItems() {
    if (_searchText.isEmpty) {
      _filteredItems = _allItems;
    } else {
      _filteredItems = _allItems
          .where(
            (item) =>
                item['title'].toLowerCase().contains(_searchText.toLowerCase()),
          )
          .toList();
    }
    setState(() {});
  }

  Map<String, List<Map<String, dynamic>>> _groupItems(
    List<Map<String, dynamic>> items,
  ) {
    final Map<String, List<Map<String, dynamic>>> grouped = {};
    for (var item in items) {
      final groupName = item['group'] as String;
      if (grouped[groupName] == null) {
        grouped[groupName] = [];
      }
      grouped[groupName]!.add(item);
    }
    return grouped;
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final groupedItems = _groupItems(_filteredItems);
    final groupKeys = groupedItems.keys.toList();

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(20),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600, maxHeight: 450),
          child: Container(
            decoration: BoxDecoration(
              color: isDarkMode
                  ? AppTheme.cardBackgroundDark
                  : AppTheme.cardBackgroundLight,
              borderRadius: BorderRadius.circular(AppTheme.borderRadiusL),
              border: isDarkMode
                  ? Border.all(color: AppTheme.cardBorderDark)
                  : null,
            ),
            child: Column(
              children: [
                _buildSearchField(context, isDarkMode),
                const Divider(height: 1),
                Expanded(
                  child: ListView.builder(
                    itemCount: _searchText.isEmpty ? groupKeys.length : 1,
                    itemBuilder: (context, index) {
                      if (_searchText.isEmpty) {
                        final groupName = groupKeys[index];
                        final items = groupedItems[groupName]!;
                        return _buildGroup(context, groupName, items);
                      } else {
                        return Column(
                          children: _filteredItems
                              .map((item) => _buildItem(context, item))
                              .toList(),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchField(BuildContext context, bool isDarkMode) {
    return TextField(
      controller: _searchController,
      autofocus: true,
      style: Theme.of(context).textTheme.bodyLarge,
      decoration: InputDecoration(
        hintText: 'Digite um comando ou busque...',
        prefixIcon: Icon(
          Icons.search_rounded,
          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
        ),
        border: InputBorder.none,
        contentPadding: const EdgeInsets.all(AppTheme.spacingL),
      ),
    );
  }

  Widget _buildGroup(
    BuildContext context,
    String title,
    List<Map<String, dynamic>> items,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacingM,
        vertical: AppTheme.spacingS,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppTheme.spacingS),
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.5),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ...items.map((item) => _buildItem(context, item)),
        ],
      ),
    );
  }

  Widget _buildItem(BuildContext context, Map<String, dynamic> item) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop(); // Close the palette
          (item['onTap'] as VoidCallback)(); // Execute the action
        },
        borderRadius: BorderRadius.circular(AppTheme.borderRadiusS),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppTheme.spacingM,
            vertical: AppTheme.spacingS,
          ),
          child: Row(
            children: [
              Icon(
                item['icon'] as IconData,
                size: 20,
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.8),
              ),
              const SizedBox(width: AppTheme.spacingM),
              Text(
                item['title'] as String,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
