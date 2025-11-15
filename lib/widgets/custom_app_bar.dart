import 'dart:io';
import 'package:barberzlink/constants/app_strings.dart';
import 'package:barberzlink/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final bool isBack;

  const CustomAppBar({
    super.key,
    required this.title,
    this.isBack = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// Back Button (only if isBack = true)
          if (isBack)
            IconButton(
              icon: Icon(
                Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () => Navigator.pop(context),
            )
          else
            Image.asset(
              AppStrings.appLogo,
              fit: BoxFit.cover,
            ),

          /// App Logo

          SizedBox(width: 10.w),

          /// Title Text
          Text(
            title,
            style: AppTextStyle.semiBold(),
          ),
        ],
      ),
    );
  }
}
