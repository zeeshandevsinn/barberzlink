import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.background,
    primaryColor: AppColors.black,
    fontFamily: 'Poppins',

    /// Apply Google Font globally
    textTheme: GoogleFonts.poppinsTextTheme(),

    /// Customize AppBar & Button themes
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 1,
      centerTitle: false,
      titleTextStyle: AppTextStyle.bold(fontSize: 20.sp),
      iconTheme: const IconThemeData(color: Colors.black),
    ),
  );
}

class AppTextStyle {
  static TextStyle bold({
    double? fontSize,
    Color color = Colors.black,
  }) =>
      GoogleFonts.poppins(
        color: color,
        fontSize: fontSize ?? 18.sp,
        fontWeight: FontWeight.w700,
      );

  static TextStyle semiBold({
    double? fontSize,
    Color color = Colors.black,
  }) =>
      GoogleFonts.poppins(
        color: color,
        fontSize: fontSize ?? 16.sp,
        fontWeight: FontWeight.w600,
      );

  static TextStyle medium({
    double? fontSize,
    Color color = Colors.black,
  }) =>
      GoogleFonts.poppins(
        color: color,
        fontSize: fontSize ?? 15.sp,
        fontWeight: FontWeight.w500,
      );

  static TextStyle regular({
    double? fontSize,
    Color color = Colors.black,
  }) =>
      GoogleFonts.poppins(
        color: color,
        fontSize: fontSize ?? 14.sp,
        fontWeight: FontWeight.w400,
      );
}
