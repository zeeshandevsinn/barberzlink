import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ComposerField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final VoidCallback onAdd;

  const ComposerField({
    super.key,
    required this.controller,
    required this.hint,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: hint,
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                hintStyle: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 13.sp,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 8.w),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A1A),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: IconButton(
            onPressed: onAdd,
            icon: Icon(Icons.add, color: Colors.white, size: 20.sp),
          ),
        ),
      ],
    );
  }
}
