import 'package:barberzlink/core/theme/app_colors.dart';
import 'package:barberzlink/core/theme/app_theme.dart';
import 'package:barberzlink/widgets/custom_button.dart';
import 'package:barberzlink/widgets/plan_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BarberShopPaymentPlanScreen extends StatefulWidget {
  const BarberShopPaymentPlanScreen({super.key});

  @override
  State<BarberShopPaymentPlanScreen> createState() =>
      _BarberShopPaymentPlanScreenState();
}

class _BarberShopPaymentPlanScreenState
    extends State<BarberShopPaymentPlanScreen> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("Barbershop Payment Plan"),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          children: [
            Center(
              child: Column(
                children: [
                  Text("BarberzLink.com",
                      style: AppTextStyle.bold(fontSize: 24.sp)),
                  SizedBox(height: 6.h),
                  Text(
                    "Barbershops – Full Access Membership",
                    style: AppTextStyle.medium(
                        fontSize: 16.sp, color: AppColors.grey),
                  ),
                ],
              ),
            ),
            SizedBox(height: 32.h),

            /// SINGLE PLAN
            PlanCard(
              title: "Full Access",
              subtitle: "\$19.99/month",
              description: "Post barber roles & message barbers.",
              features: [
                "Post Job Listings",
                "Message Barbers",
                "Applicant Tracking",
                "Priority Listing Boost",
              ],
              price: "\$19.99",
              priceSubtext: "Monthly subscription",
              isSelected: isSelected,
              onTap: () => setState(() => isSelected = true),
              isPopular: true,
            ),

            SizedBox(height: 40.h),

            CustomButton(
              buttonText:
                  isSelected ? "Continue with Full Access" : "Select Plan",
              onTap: () {
                if (!isSelected) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please select a plan")),
                  );
                  return;
                }
                _confirmDialog();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _confirmDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title:
            Text("Confirm Payment", style: AppTextStyle.bold(fontSize: 20.sp)),
        content: Text("Proceed with Full Access (\$19.99/month)?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel",
                style: AppTextStyle.medium(color: AppColors.grey)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Processing payment…")),
              );
            },
            child: const Text("Confirm"),
          ),
        ],
      ),
    );
  }
}
