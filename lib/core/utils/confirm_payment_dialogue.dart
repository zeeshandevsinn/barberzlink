import 'package:barberzlink/core/theme/app_colors.dart';
import 'package:barberzlink/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<bool> confirmPayment(BuildContext context, String planLabel) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: Colors.white,
      title: Text(
        "Confirm Payment",
        style: AppTextStyle.bold(fontSize: 20.sp),
      ),
      content: Text("Proceed with ${planLabel}?"),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context, false); // return false
          },
          child: Text(
            "Cancel",
            style: AppTextStyle.medium(color: AppColors.grey),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context, true); // return true
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Processing payment…")),
            );
          },
          child: Text(
            "Confirm",
            style: AppTextStyle.regular(color: AppColors.white),
          ),
        ),
      ],
    ),
  );

  return result ?? false; // default false if dismissed
}
