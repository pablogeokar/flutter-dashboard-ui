import 'package:flutter/material.dart';
import 'drawer_item.dart';
import 'drawer_list_item.dart';
import '../../../theme.dart';

class ResponsiveDrawer extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;
  final List<DrawerItem> itensPrincipais;
  final List<DrawerItem> itensInferiores;

  const ResponsiveDrawer({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.itensPrincipais,
    required this.itensInferiores,
  });

  @override
  State<ResponsiveDrawer> createState() => _ResponsiveDrawerState();
}

class _ResponsiveDrawerState extends State<ResponsiveDrawer> {
  late final List<DrawerItem> _flatNavigableItems;

  @override
  void initState() {
    super.initState();
    _flatNavigableItems = _flattenItems();
  }

  List<DrawerItem> _flattenItems() {
    final List<DrawerItem> flatList = [];
    void processItems(List<DrawerItem> items) {
      for (final item in items) {
        if (item.subItems?.isNotEmpty ?? false) {
          processItems(item.subItems!);
        } else if (item.screen != null) {
          flatList.add(item);
        }
      }
    }

    processItems([...widget.itensPrincipais, ...widget.itensInferiores]);
    return flatList;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: AppTheme.drawerWidth,
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark, // Cor mais escura para o sidebar
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(AppTheme.borderRadiusXL),
          bottomRight: Radius.circular(AppTheme.borderRadiusXL),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 12,
            offset: const Offset(5, 0),
          ),
        ],
        border: Border(
          right: BorderSide(
            color: Theme.of(context).colorScheme.outlineVariant.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
      ),
      child: Drawer(
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: AppTheme.appBarHeight),
            const SizedBox(height: AppTheme.spacingL),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacingM,
                ),
                children: _buildItemList(widget.itensPrincipais),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: AppTheme.spacingS),
              child: Divider(height: 1),
            ),
            Container(
              decoration: BoxDecoration(
                color: AppTheme.surfaceFooter,
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(AppTheme.borderRadiusXL),
                ),
              ),
              child: Column(
                children: [
                  ..._buildItemList(widget.itensInferiores, isFooterList: true),
                  _buildFooter(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildItemList(List<DrawerItem> items, {bool isFooterList = false}) {
    return items.map((item) {
      // Group item
      if (item.subItems?.isNotEmpty ?? false) {
        return _buildExpansionItem(item, isFooterList: isFooterList);
      }
      // Normal item
      else {
        return _buildSingleItem(item, isFooterItem: isFooterList);
      }
    }).toList();
  }

  Widget _buildSingleItem(DrawerItem item, {bool isSubItem = false, bool isFooterItem = false}) {
    final flatIndex = _flatNavigableItems.indexWhere(
      (e) => e.title == item.title,
    );
    return DrawerListItem(
      item: item,
      isSubItem: isSubItem,
      isSelected: widget.currentIndex == flatIndex,
      isFooterItem: isFooterItem,
      onTap: () {
        if (flatIndex != -1) {
          widget.onTap(flatIndex);
        }
      },
    );
  }

  Widget _buildExpansionItem(DrawerItem item, {bool isFooterList = false}) {
    // Check if any sub-item is currently selected
    final bool isGroupSelected = item.subItems!.any((subItem) {
      final flatIndex = _flatNavigableItems.indexWhere(
        (e) => e.title == subItem.title,
      );
      return widget.currentIndex == flatIndex;
    });

    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        key: PageStorageKey(item.title), // Persists expanded state
        initiallyExpanded: isGroupSelected,
        tilePadding: EdgeInsets.zero,
        title: AbsorbPointer(
          child: DrawerListItem(
            item: item,
            isSelected: isGroupSelected,
            isFooterItem: isFooterList,
            onTap: () {}, // The tile itself handles expansion
          ),
        ),
        children: item.subItems!
            .map((subItem) => _buildSingleItem(subItem, isSubItem: true, isFooterItem: isFooterList))
            .toList(),
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingM),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Theme.of(context).colorScheme.outlineVariant.withValues(alpha: 0.3),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(AppTheme.spacingXS),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(AppTheme.borderRadiusS),
            ),
            child: Icon(
              Icons.info_outline,
              size: 14,
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
          const SizedBox(width: AppTheme.spacingS),
          Text(
            'v1.0.0',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }
}
