import 'package:barberzlink/core/theme/app_colors.dart';
import 'package:barberzlink/core/theme/app_theme.dart';
import 'package:barberzlink/widgets/custom_button.dart';
import 'package:barberzlink/widgets/plan_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BarberPaymentPlanScreen extends StatefulWidget {
  const BarberPaymentPlanScreen({super.key});

  @override
  State<BarberPaymentPlanScreen> createState() =>
      _BarberPaymentPlanScreenState();
}

class _BarberPaymentPlanScreenState extends State<BarberPaymentPlanScreen> {
  String? _selectedPlan;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("Barber Payment Plan"),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// TITLE
            Center(
              child: Column(
                children: [
                  Text(
                    "BarberzLink.com",
                    style: AppTextStyle.bold(fontSize: 24.sp),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    "Barbers – Choose Your Access",
                    style: AppTextStyle.medium(
                        fontSize: 16.sp, color: AppColors.grey),
                  ),
                ],
              ),
            ),
            SizedBox(height: 32.h),

            /// LIMITED ACCESS – FREE
            _buildPlanCard(
              isPopular: false,
              planId: "barber_limited",
              title: "Limited Access",
              subtitle: "Free",
              price: "Free",
              priceSubtext: "Free forever",
              description: "Create your profile & browse public listings.",
              features: [
                "Create Barber Profile",
                "Browse Barbershops",
                "View Public Listings",
              ],
            ),

            SizedBox(height: 16.h),

            /// FULL ACCESS – $9.99
            _buildPlanCard(
              isPopular: true,
              planId: "barber_full",
              title: "Full Access",
              subtitle: "\$9.99/month",
              price: "\$9.99",
              priceSubtext: "Monthly subscription",
              description: "Unlock messaging, unlimited search & reviews.",
              features: [
                "Unlimited Search",
                "Messaging Access",
                "Leave & Receive Reviews",
                "Priority Visibility",
              ],
            ),

            SizedBox(height: 40.h),

            /// BUTTON
            CustomButton(
              buttonText: _selectedPlan == null
                  ? "Select a Plan"
                  : "Continue with ${_planLabel()}",
              onTap: () {
                if (_selectedPlan == null) {
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

  /// PLAN CARD BUILDER
  Widget _buildPlanCard({
    required String planId,
    required String title,
    required String subtitle,
    required String description,
    required List<String> features,
    required String price,
    required String priceSubtext,
    required bool isPopular,
  }) {
    return PlanCard(
      title: title,
      subtitle: subtitle,
      description: description,
      features: features,
      price: price,
      priceSubtext: priceSubtext,
      isSelected: _selectedPlan == planId,
      onTap: () => setState(() => _selectedPlan = planId),
      isPopular: isPopular,
    );
  }

  String _planLabel() {
    return _selectedPlan == "barber_limited" ? "Limited Access" : "Full Access";
  }

  void _confirmDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title:
            Text("Confirm Payment", style: AppTextStyle.bold(fontSize: 20.sp)),
        content: Text("Proceed with ${_planLabel()}?"),
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
                SnackBar(content: Text("Processing payment…")),
              );
            },
            child: const Text("Confirm"),
          ),
        ],
      ),
    );
  }
}
