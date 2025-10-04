import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../theme/theme.dart';
import '../../../theme/animations.dart';

/// Widget personalizado para entrada de data.
class DateInputField extends StatefulWidget {
  final String label;
  final DateTime? initialValue;
  final Function(DateTime?)? onChanged;
  final String? errorText;
  final bool enabled;

  const DateInputField({
    super.key,
    required this.label,
    this.initialValue,
    this.onChanged,
    this.errorText,
    this.enabled = true,
  });

  @override
  State<DateInputField> createState() => _DateInputFieldState();
}

class _DateInputFieldState extends State<DateInputField> {
  late DateTime? _selectedDate;
  late final TextEditingController _controller;
  bool _isHovered = false;
  bool _isFocused = false;

  String _formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialValue;
    _controller = TextEditingController(
      text: _selectedDate != null ? _formatDate(_selectedDate!) : '',
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _pickDate(BuildContext context) async {
    if (!widget.enabled) return;

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
      builder: (context, child) {
        // Para forçar o tema claro no picker, como no original
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.fromSeed(seedColor: AppTheme.primaryLight),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        _controller.text = _formatDate(pickedDate);
      });
      widget.onChanged?.call(pickedDate);
    }
  }

  Color _getBorderColor(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    if (widget.errorText != null && widget.errorText!.isNotEmpty) {
      return AppTheme.errorLight;
    }
    if (_isFocused) {
      return colorScheme.primary;
    }
    if (_isHovered) {
      return colorScheme.primary.withValues(alpha: 0.6);
    }
    return isDarkMode
        ? AppTheme.formFieldBorderDark
        : AppTheme.formFieldBorderLight;
  }

  Color _getBackgroundColor(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    if (!widget.enabled) {
      return isDarkMode
          ? AppTheme.formFieldBackgroundDark.withValues(alpha: 0.5)
          : AppTheme.formFieldBackgroundLight.withValues(alpha: 0.5);
    }
    if (_isFocused) {
      return isDarkMode
          ? AppTheme.formFieldFocusDark
          : AppTheme.formFieldFocusLight;
    }
    if (_isHovered) {
      return isDarkMode
          ? AppTheme.formFieldHoverDark
          : AppTheme.formFieldHoverLight;
    }
    return isDarkMode
        ? AppTheme.formFieldBackgroundDark
        : AppTheme.formFieldBackgroundLight;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final hasError = widget.errorText != null && widget.errorText!.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedDefaultTextStyle(
          duration: AppAnimations.fast,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: hasError
                ? AppTheme.errorLight
                : _isFocused
                ? colorScheme.primary
                : colorScheme.onSurface.withValues(alpha: 0.8),
          ),
          child: Text(widget.label),
        ),
        const SizedBox(height: AppTheme.spacingS),
        MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: AnimatedContainer(
            duration: AppAnimations.fast,
            curve: AppAnimations.easeOut,
            decoration: BoxDecoration(
              color: _getBackgroundColor(context),
              borderRadius: BorderRadius.circular(AppTheme.borderRadiusM),
              border: Border.all(
                color: _getBorderColor(context),
                width: _isFocused ? 2.0 : 1.0,
              ),
              boxShadow: [
                if (_isFocused || _isHovered) ...[
                  BoxShadow(
                    color: hasError
                        ? AppTheme.errorLight.withValues(alpha: 0.15)
                        : colorScheme.primary.withValues(
                            alpha: _isFocused ? 0.15 : 0.08,
                          ),
                    blurRadius: _isFocused ? 8.0 : 4.0,
                    spreadRadius: _isFocused ? 1.0 : 0.0,
                    offset: const Offset(0, 2),
                  ),
                ],
              ],
            ),
            child: TextFormField(
              controller: _controller,
              readOnly: true,
              onTap: widget.enabled ? () => _pickDate(context) : null,
              decoration: InputDecoration(
                hintText: 'Selecione uma data',
                hintStyle: TextStyle(
                  fontSize: 14,
                  color: colorScheme.onSurface.withValues(alpha: 0.5),
                ),
                prefixIcon: AnimatedContainer(
                  duration: AppAnimations.fast,
                  child: Icon(
                    Icons.calendar_today_outlined,
                    color: hasError
                        ? AppTheme.errorLight
                        : _isFocused
                        ? colorScheme.primary
                        : colorScheme.onSurface.withValues(alpha: 0.6),
                    size: 20,
                  ),
                ),
                suffixIcon: _selectedDate != null
                    ? IconButton(
                        icon: Icon(
                          Icons.clear,
                          color: colorScheme.onSurface.withValues(alpha: 0.6),
                          size: 18,
                        ),
                        onPressed: widget.enabled
                            ? () {
                                setState(() {
                                  _selectedDate = null;
                                  _controller.clear();
                                });
                                widget.onChanged?.call(null);
                              }
                            : null,
                      )
                    : null,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacingM,
                  vertical: AppTheme.spacingM,
                ),
                border: InputBorder.none,
              ),
              style: TextStyle(
                fontSize: 14,
                color: widget.enabled
                    ? colorScheme.onSurface
                    : colorScheme.onSurface.withValues(alpha: 0.5),
                fontWeight: FontWeight.w500,
              ),
              enabled: widget.enabled,
              onTapOutside: (_) => setState(() => _isFocused = false),
            ),
          ),
        ),
        if (hasError)
          Padding(
            padding: const EdgeInsets.only(
              top: AppTheme.spacingS,
              left: AppTheme.spacingS,
            ),
            child: AnimatedOpacity(
              duration: AppAnimations.fast,
              opacity: 1.0,
              child: Text(
                widget.errorText!,
                style: TextStyle(
                  fontSize: 12,
                  color: AppTheme.errorLight,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
