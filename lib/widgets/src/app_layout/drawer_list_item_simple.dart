import 'package:flutter/material.dart';
import 'drawer_item.dart';

class DrawerListItemSimple extends StatefulWidget {
  final DrawerItem item;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isSubItem;
  final bool isFooterItem;

  const DrawerListItemSimple({
    super.key,
    required this.item,
    required this.isSelected,
    required this.onTap,
    this.isSubItem = false,
    this.isFooterItem = false,
  });

  @override
  State<DrawerListItemSimple> createState() => _DrawerListItemSimpleState();
}

class _DrawerListItemSimpleState extends State<DrawerListItemSimple> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final bool hasSubItems = widget.item.subItems?.isNotEmpty ?? false;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = isDarkMode
        ? const Color(0xFF1565C0)
        : Theme.of(context).colorScheme.primary;

    Widget content = MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 2),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: widget.isSelected
              ? primaryColor.withValues(alpha: 0.15)
              : _isHovered
              ? (isDarkMode
                    ? const Color(0xFF4A5568).withValues(
                        alpha: 0.4,
                      ) // Cinza azulado para modo dark
                    : primaryColor.withValues(alpha: 0.08))
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: widget.isSelected
              ? Border(left: BorderSide(color: primaryColor, width: 3))
              : null,
        ),
        child: hasSubItems
            ? _buildItemContent()
            : InkWell(
                onTap: widget.onTap,
                borderRadius: BorderRadius.circular(8),
                child: _buildItemContent(),
              ),
      ),
    );

    if (widget.isSubItem) {
      return Padding(padding: const EdgeInsets.only(left: 16), child: content);
    }

    return content;
  }

  Widget _buildItemContent() {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = isDarkMode
        ? const Color(0xFF1565C0)
        : Theme.of(context).colorScheme.primary;

    Color iconColor;
    Color textColor;
    FontWeight fontWeight;

    if (widget.isSelected) {
      iconColor = Colors.white;
      textColor = isDarkMode ? Colors.white : primaryColor;
      fontWeight = FontWeight.w600;
    } else if (_isHovered) {
      iconColor = isDarkMode
          ? const Color(0xFFE5E7EB) // Cinza claro para ícone no modo dark
          : primaryColor;
      textColor = isDarkMode
          ? const Color(0xFFE5E7EB) // Cinza claro para texto no modo dark
          : primaryColor;
      fontWeight = FontWeight.w500;
    } else {
      iconColor = Theme.of(
        context,
      ).colorScheme.onSurface.withValues(alpha: 0.7);
      textColor = Theme.of(context).colorScheme.onSurface;
      fontWeight = FontWeight.w400;
    }

    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: widget.isSelected
                ? primaryColor
                : _isHovered
                ? (isDarkMode
                      ? const Color(0xFF6B7280).withValues(
                          alpha: 0.3,
                        ) // Cinza neutro para modo dark
                      : primaryColor.withValues(alpha: 0.1))
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(widget.item.icon, size: 18, color: iconColor),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            widget.item.title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: fontWeight,
              color: textColor,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
