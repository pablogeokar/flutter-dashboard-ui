import 'package:flutter/material.dart';
import '../../../theme/theme.dart';

/// Item individual do breadcrumb
class BreadcrumbItem {
  final String label;
  final IconData? icon;
  final VoidCallback? onTap;
  final bool isActive;

  const BreadcrumbItem({
    required this.label,
    this.icon,
    this.onTap,
    this.isActive = false,
  });
}

/// Widget de navegação breadcrumb profissional
class Breadcrumb extends StatelessWidget {
  final List<BreadcrumbItem> items;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;

  const Breadcrumb({
    super.key,
    required this.items,
    this.padding,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
      padding:
          padding ??
          EdgeInsets.symmetric(
            horizontal: AppTheme.spacingL,
            vertical: AppTheme.spacingM,
          ),
      decoration: BoxDecoration(
        color:
            backgroundColor ??
            (isDarkMode
                ? AppTheme.neutral800.withValues(alpha: 0.3)
                : AppTheme.neutral50.withValues(alpha: 0.7)),
        border: Border(
          bottom: BorderSide(
            color: isDarkMode
                ? AppTheme.neutral700.withValues(alpha: 0.3)
                : AppTheme.neutral200.withValues(alpha: 0.5),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          // Ícone home
          _buildHomeIcon(context, isDarkMode),

          if (items.isNotEmpty) ...[
            SizedBox(width: AppTheme.spacingS),
            _buildSeparator(context, isDarkMode),
            SizedBox(width: AppTheme.spacingS),
          ],

          // Items do breadcrumb
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _buildBreadcrumbItems(
                  context,
                  isDarkMode,
                  screenWidth,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHomeIcon(BuildContext context, bool isDarkMode) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          // Navegar para home/dashboard
          Navigator.of(context).popUntil((route) => route.isFirst);
        },
        borderRadius: BorderRadius.circular(AppTheme.borderRadiusS),
        child: Padding(
          padding: EdgeInsets.all(AppTheme.spacingS),
          child: Icon(
            Icons.home_rounded,
            size: 18,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }

  Widget _buildSeparator(BuildContext context, bool isDarkMode) {
    return Icon(
      Icons.chevron_right_rounded,
      size: 16,
      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.4),
    );
  }

  List<Widget> _buildBreadcrumbItems(
    BuildContext context,
    bool isDarkMode,
    double screenWidth,
  ) {
    List<Widget> widgets = [];

    for (int i = 0; i < items.length; i++) {
      final item = items[i];
      final isLast = i == items.length - 1;

      // Item do breadcrumb
      widgets.add(
        _buildBreadcrumbItem(context, item, isLast, isDarkMode, screenWidth),
      );

      // Separador (exceto no último item)
      if (!isLast) {
        widgets.add(SizedBox(width: AppTheme.spacingS));
        widgets.add(_buildSeparator(context, isDarkMode));
        widgets.add(SizedBox(width: AppTheme.spacingS));
      }
    }

    return widgets;
  }

  Widget _buildBreadcrumbItem(
    BuildContext context,
    BreadcrumbItem item,
    bool isLast,
    bool isDarkMode,
    double screenWidth,
  ) {
    final isClickable = item.onTap != null && !isLast;
    final textColor = isLast
        ? Theme.of(context).colorScheme.primary
        : isClickable
        ? Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.8)
        : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6);

    Widget content = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (item.icon != null) ...[
          Icon(item.icon, size: 16, color: textColor),
          SizedBox(width: AppTheme.spacingXS),
        ],
        Flexible(
          child: Text(
            item.label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: textColor,
              fontWeight: isLast ? FontWeight.w600 : FontWeight.w500,
              fontSize: AppTheme.getResponsiveFontSize(screenWidth, 13),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );

    if (isClickable) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: item.onTap,
          borderRadius: BorderRadius.circular(AppTheme.borderRadiusS),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppTheme.spacingS,
              vertical: AppTheme.spacingXS,
            ),
            child: content,
          ),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppTheme.spacingS,
        vertical: AppTheme.spacingXS,
      ),
      child: content,
    );
  }
}

/// Helper para criar breadcrumbs automaticamente baseado na navegação
class BreadcrumbHelper {
  static List<BreadcrumbItem> fromRoute(String routeName) {
    switch (routeName) {
      case '/dashboard':
        return [
          BreadcrumbItem(
            label: 'Dashboard',
            icon: Icons.dashboard_rounded,
            isActive: true,
          ),
        ];

      case '/cadastros':
        return [
          BreadcrumbItem(
            label: 'Cadastros',
            icon: Icons.edit_document,
            isActive: true,
          ),
        ];

      case '/cadastros/clientes':
        return [
          BreadcrumbItem(
            label: 'Cadastros',
            icon: Icons.edit_document,
            onTap: () {}, // Navegar para cadastros
          ),
          BreadcrumbItem(
            label: 'Clientes',
            icon: Icons.people_rounded,
            isActive: true,
          ),
        ];

      case '/fiscal':
        return [
          BreadcrumbItem(
            label: 'Fiscal',
            icon: Icons.gavel_rounded,
            isActive: true,
          ),
        ];

      case '/fiscal/apuracao-icms':
        return [
          BreadcrumbItem(
            label: 'Fiscal',
            icon: Icons.gavel_rounded,
            onTap: () {}, // Navegar para fiscal
          ),
          BreadcrumbItem(
            label: 'Apuração ICMS',
            icon: Icons.calculate_rounded,
            isActive: true,
          ),
        ];

      case '/relatorios':
        return [
          BreadcrumbItem(
            label: 'Relatórios',
            icon: Icons.analytics_rounded,
            isActive: true,
          ),
        ];

      default:
        return [];
    }
  }
}
