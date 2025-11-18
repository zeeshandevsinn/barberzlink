import 'package:barberzlink/core/theme/app_colors.dart';
import 'package:barberzlink/core/theme/app_theme.dart';
import 'package:barberzlink/widgets/custom_button.dart';
import 'package:barberzlink/widgets/plan_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventPaymentPlanScreen extends StatefulWidget {
  const EventPaymentPlanScreen({super.key});

  @override
  State<EventPaymentPlanScreen> createState() => _EventPaymentPlanScreenState();
}

class _EventPaymentPlanScreenState extends State<EventPaymentPlanScreen> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("Events Payment Plan"),
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
                    "Events – One-Time Listing Payment",
                    style: AppTextStyle.medium(
                      fontSize: 16.sp,
                      color: AppColors.grey,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 32.h),

            /// SINGLE EVENT PLAN
            PlanCard(
              title: "Event Submission",
              subtitle: "One-Time Payment",
              description:
                  "Submit your event or product launch with premium visibility.",
              features: [
                "Upload event details & media",
                "Highlighted listing in event calendar",
                "Sharable landing page",
              ],
              price: "\$150",
              priceSubtext: "One-time only fee",
              isSelected: isSelected,
              onTap: () => setState(() => isSelected = true),
              isPopular: true,
            ),

            SizedBox(height: 40.h),

            CustomButton(
              buttonText:
                  isSelected ? "Continue with Event Payment" : "Select Plan",
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
        content: Text("Proceed with one-time event payment of \$150?"),
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
                const SnackBar(
                  content: Text("Processing event payment…"),
                ),
              );
            },
            child: const Text("Confirm"),
          ),
        ],
      ),
    );
  }
}
