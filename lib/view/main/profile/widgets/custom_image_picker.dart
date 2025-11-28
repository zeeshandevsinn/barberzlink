import 'dart:io';
import 'package:barberzlink/core/theme/app_theme.dart';
import 'package:barberzlink/widgets/dotted_container.dart';
import 'package:flutter/material.dart';

class CustomImagePicker extends StatelessWidget {
  final String title;
  final File? file;
  final VoidCallback onTap;
  final String helper;

  const CustomImagePicker({
    super.key,
    required this.title,
    required this.file,
    required this.onTap,
    this.helper = '',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyle.semiBold(fontSize: 14)),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: onTap,
          child: file == null
              ? const DottedBorderContainer(text: 'Tap to upload')
              : ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(
                    file!,
                    height: 160,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
        ),
        if (helper.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(helper,
                style: const TextStyle(fontSize: 12, color: Colors.black54)),
          ),
      ],
    );
  }
}
