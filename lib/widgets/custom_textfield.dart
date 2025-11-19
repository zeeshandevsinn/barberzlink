import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final IconData? icon;
  final bool isPasswordField;
  final int maxLines;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final VoidCallback? onTap;
  final bool readOnly;
  final bool isTitle;
  final String? titleName;

  const CustomTextField({
    super.key,
    required this.label,
    this.icon,
    this.isPasswordField = false,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onTap,
    this.readOnly = false,
    this.isTitle = false,
    this.titleName,
    this.maxLines = 1,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPasswordField;
  }

  void _toggleVisibility() {
    setState(() => _obscureText = !_obscureText);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.isTitle && widget.titleName != null) ...[
          Text(
            widget.titleName!,
            style: const TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 6),
        ],
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          cursorColor: Colors.black87,
          maxLines: widget.maxLines,
          controller: widget.controller,
          obscureText: widget.isPasswordField ? _obscureText : false,
          readOnly: widget.readOnly,
          onTap: widget.onTap,
          keyboardType: widget.keyboardType,
          style: const TextStyle(color: Colors.black87),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                // color: AppColors.primaryColor,
                width: 1.5,
              ),
            ),
            prefixIcon: widget.icon == null
                ? null
                : Icon(widget.icon, color: Colors.black),
            suffixIcon: widget.isPasswordField
                ? IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      color: Colors.black,
                    ),
                    onPressed: _toggleVisibility,
                  )
                : null,
            labelText: widget.label,
            alignLabelWithHint: true,
            labelStyle: const TextStyle(color: Colors.black54),
            filled: true,
            fillColor: const Color(0xFFF8F8F8),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Colors.red,
                width: 1.5,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Colors.black,
                width: 1.5,
              ),
            ),
          ),
          validator: widget.validator ??
              (value) => value == null || value.isEmpty
                  ? 'Please enter ${widget.label}'
                  : null,
        ),
      ],
    );
  }
}
