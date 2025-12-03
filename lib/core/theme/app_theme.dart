import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light, // ✅ FIXED — MUST BE LIGHT THEME
    scaffoldBackgroundColor: AppColors.background,
    primaryColor: AppColors.black,
    fontFamily: 'Poppins',

    /// GLOBAL TEXT USING POPPINS
    textTheme: GoogleFonts.poppinsTextTheme(),

    /// AppBar Theme
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 1,
      centerTitle: false,
      titleTextStyle: AppTextStyle.bold(
        fontSize: 20.sp,
        color: Colors.black,
      ),
      iconTheme: const IconThemeData(color: Colors.black),
    ),

    /// Dialog + AlertDialog + Dropdown FIX
    dialogTheme: DialogTheme(
      backgroundColor: Colors.white, // ✅ FIXES YOUR DARK DROPDOWN
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      titleTextStyle: GoogleFonts.poppins(
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      contentTextStyle: GoogleFonts.poppins(
        fontSize: 14.sp,
        color: Colors.black,
      ),
    ),

    /// Dropdown + Popup Menu Theme
    dropdownMenuTheme: DropdownMenuThemeData(
      textStyle: GoogleFonts.poppins(
        color: Colors.black,
        fontSize: 14.sp,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
      ),
    ),

    /// Checkbox, Radio, Switch theme
    checkboxTheme: CheckboxThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.r),
      ),
    ),

    /// Elevated Button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.black,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 14.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
    ),
  );
}

class AppTextStyle {
  static TextStyle bold({double? fontSize, Color color = Colors.black}) =>
      GoogleFonts.poppins(
        color: color,
        fontSize: fontSize ?? 18.sp,
        fontWeight: FontWeight.w700,
      );

  static TextStyle semiBold({double? fontSize, Color color = Colors.black}) =>
      GoogleFonts.poppins(
        color: color,
        fontSize: fontSize ?? 16.sp,
        fontWeight: FontWeight.w600,
      );

  static TextStyle medium({double? fontSize, Color color = Colors.black}) =>
      GoogleFonts.poppins(
        color: color,
        fontSize: fontSize ?? 15.sp,
        fontWeight: FontWeight.w500,
      );

  static TextStyle regular({double? fontSize, Color color = Colors.black}) =>
      GoogleFonts.poppins(
        color: color,
        fontSize: fontSize ?? 14.sp,
        fontWeight: FontWeight.w400,
      );
}
