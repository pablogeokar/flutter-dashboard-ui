import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/theme.dart';

/// Widget personalizado para entrada de data.
/// 
/// Este widget fornece uma interface visualmente consistente com o tema do aplicativo,
/// incluindo bordas arredondadas, sombras sutis e suporte a temas claro/escuro.
/// Ele exibe um campo de texto com um ícone de calendário à direita e abre um seletor de data
/// quando pressionado.
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

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final backgroundColor = isDarkMode ? AppTheme.surfaceDark : AppTheme.surfaceLight;
    final borderColor = isDarkMode ? AppTheme.neutral1 : AppTheme.neutral2;
    final textColor = isDarkMode ? AppTheme.secondaryDark : AppTheme.secondaryLight;
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
            border: Border.all(color: widget.errorText != null ? errorColor : borderColor),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TextFormField(
            readOnly: true, // O campo é somente leitura; a data é selecionada via picker
            onTap: () async {
              if (!widget.enabled) return;
              final pickedDate = await showDatePicker(
                context: context,
                initialDate: _selectedDate ?? DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
                builder: (context, child) {
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
                });
                widget.onChanged?.call(pickedDate);
              }
            },
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
              suffixIcon: widget.enabled
                  ? IconButton(
                      onPressed: () async {
                        if (!widget.enabled) return;
                        final pickedDate = await showDatePicker(
                          context: context,
                          initialDate: _selectedDate ?? DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                          builder: (context, child) {
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
                          });
                          widget.onChanged?.call(pickedDate);
                        }
                      },
                      icon: const Icon(Icons.arrow_drop_down),
                      color: textColor,
                      padding: EdgeInsets.zero,
                    )
                  : null,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppTheme.spacingM,
                vertical: AppTheme.spacingS,
              ),
              border: InputBorder.none,
              errorText: widget.errorText,
              errorStyle: GoogleFonts.inter(
                fontSize: 12,
                color: errorColor,
              ),
            ),
            style: GoogleFonts.inter(
              fontSize: 14,
              color: textColor,
            ),
            enabled: widget.enabled,
          ),
        ),
        if (widget.errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: AppTheme.spacingS),
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