import 'package:flutter/material.dart';
import '../../theme/theme.dart';

class TextInputField extends StatefulWidget {
  final String hintText;
  final String? labelText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final void Function(String)? onChanged;
  final void Function()? onEditingComplete;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;

  const TextInputField({
    super.key,
    required this.hintText,
    this.labelText,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.onChanged,
    this.onEditingComplete,
    this.focusNode,
    this.validator,
  });

  @override
  State<TextInputField> createState() => _TextInputFieldState();
}

class _TextInputFieldState extends State<TextInputField> {
  late final FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    // Se o focus node foi criado internamente, faça o dispose.
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  void _onFocusChange() {
    if (mounted) {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.labelText != null) ...[
          Text(
            widget.labelText!,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: AppTheme.spacingS),
        ],
        Container(
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(AppTheme.borderRadiusM),
            border: Border.all(
              color: _isFocused ? colorScheme.primary : colorScheme.tertiary,
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: colorScheme.primary.withOpacity(0.1),
                blurRadius: 4.0,
                spreadRadius: 1.0,
              ),
            ],
          ),
          child: TextFormField(
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            obscureText: widget.obscureText,
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: TextStyle(
                color: colorScheme.secondary,
                fontSize: AppTheme.textTheme.bodyMedium?.fontSize,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppTheme.spacingM,
                vertical: AppTheme.spacingS,
              ),
            ),
            style: TextStyle(
              color: colorScheme.secondary,
              fontSize: AppTheme.textTheme.bodyMedium?.fontSize,
            ),
            onChanged: widget.onChanged,
            onEditingComplete: widget.onEditingComplete,
            focusNode: _focusNode,
            validator: widget.validator,
          ),
        ),
      ],
    );
  }
}

