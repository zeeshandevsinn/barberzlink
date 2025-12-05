import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'composer_field.dart';

class ChipSection extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<String> items;
  final TextEditingController controller;
  final String hint;
  final VoidCallback onAdd;
  final Color color;
  final Color textColor;
  final Function(String) onDeleteItem;

  const ChipSection({
    super.key,
    required this.title,
    required this.subtitle,
    required this.items,
    required this.controller,
    required this.hint,
    required this.onAdd,
    required this.color,
    required this.textColor,
    required this.onDeleteItem,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.grey.shade600,
          ),
        ),
        SizedBox(height: 12.h),
        if (items.isNotEmpty) ...[
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: items
                .map(
                  (item) => Chip(
                    label: Text(
                      item,
                      style: TextStyle(color: textColor),
                    ),
                    backgroundColor: color,
                    onDeleted: () => onDeleteItem,
                    deleteIcon:
                        Icon(Icons.close, size: 16.sp, color: textColor),
                  ),
                )
                .toList(),
          ),
          SizedBox(height: 12.h),
        ],
        ComposerField(
          controller: controller,
          hint: hint,
          onAdd: onAdd,
        ),
      ],
    );
  }
}
