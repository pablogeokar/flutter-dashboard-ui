import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../theme/theme.dart';

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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final backgroundColor = isDarkMode
        ? AppTheme.surfaceDark
        : AppTheme.surfaceLight;
    final borderColor = isDarkMode ? AppTheme.neutral1 : AppTheme.neutral2;
    final textColor = isDarkMode
        ? AppTheme.secondaryDark
        : AppTheme.secondaryLight;
    final errorColor = Colors.red;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
        const SizedBox(height: AppTheme.spacingS),
        Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(AppTheme.borderRadiusL),
            border: Border.all(
              color: widget.errorText != null && widget.errorText!.isNotEmpty
                  ? errorColor
                  : borderColor,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TextFormField(
            controller: _controller,
            readOnly: true,
            onTap: () => _pickDate(context),
            decoration: InputDecoration(
              hintText: 'Selecione uma data',
              hintStyle: GoogleFonts.inter(
                fontSize: 14,
                color: AppTheme.neutral1,
              ),
              prefixIcon: Icon(
                Icons.calendar_today,
                color: textColor,
                size: 18,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppTheme.spacingM,
                vertical: AppTheme.spacingS,
              ),
              border: InputBorder.none,
              errorText: widget.errorText,
              errorStyle: const TextStyle(height: 0, fontSize: 0),
            ),
            style: GoogleFonts.inter(fontSize: 14, color: textColor),
            enabled: widget.enabled,
          ),
        ),
        if (widget.errorText != null && widget.errorText!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(
              top: AppTheme.spacingS,
              left: AppTheme.spacingS,
            ),
            child: Text(
              widget.errorText!,
              style: GoogleFonts.inter(
                fontSize: 12,
                color: errorColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
      ],
    );
  }
}
