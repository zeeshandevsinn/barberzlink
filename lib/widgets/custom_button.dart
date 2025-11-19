import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../core/theme/app_colors.dart';

class CustomButton extends StatefulWidget {
  final VoidCallback onTap;
  final String buttonText;
  final Color btnColor;
  final int fontSize;

  const CustomButton(
      {super.key,
      required this.onTap,
      required this.buttonText,
      this.btnColor = AppColors.black,
      this.fontSize = 16});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.btnColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
        onPressed: widget.onTap,
        child: Text(
          widget.buttonText,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: widget.fontSize.sp,
          ),
        ),
      ),
    );
  }
}
