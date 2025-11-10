import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final IconData? icon;
  final bool obscure;
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
    this.obscure = false,
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
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isTitle && titleName != null) ...[
          Text(
            titleName!,
            style: const TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 6),
        ],
        TextFormField(
          maxLines: maxLines,
          controller: controller,
          obscureText: obscure,
          readOnly: readOnly,
          onTap: onTap,
          keyboardType: keyboardType,
          style: const TextStyle(color: Colors.black87),
          decoration: InputDecoration(
            prefixIcon:
                icon == null ? null : Icon(icon, color: Colors.amber[800]),
            labelText: label,
            alignLabelWithHint: true,
            labelStyle: const TextStyle(color: Colors.black54),
            filled: true,
            fillColor: const Color(0xFFF8F8F8),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.black12),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Colors.amber[800] ?? Colors.amber,
                width: 1.5,
              ),
            ),
          ),
          validator: validator ??
              (value) =>
                  value == null || value.isEmpty ? 'Please enter $label' : null,
        ),
      ],
    );
  }
}
