import 'package:barberzlink/core/routes/app_routes.dart';
import 'package:barberzlink/core/theme/app_colors.dart';
import 'package:barberzlink/core/theme/app_theme.dart';
import 'package:barberzlink/core/utils/confirm_payment_dialogue.dart';
import 'package:barberzlink/widgets/custom_app_bar.dart';
import 'package:barberzlink/widgets/custom_button.dart';
import 'package:barberzlink/widgets/plan_card.dart';
import 'package:flutter/foundation.dart';
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: kIsWeb
            ? AppBar(
                title: const Text("Barber Payment Plan"),
                backgroundColor: Colors.white,
                elevation: 1,
                iconTheme: const IconThemeData(color: Colors.black),
              )
            : PreferredSize(
                preferredSize: Size.fromHeight(80),
                child: CustomAppBar(
                  title: "Barber Payment Plan",
                  isBack: true,
                )),
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
                onTap: () async {
                  if (_selectedPlan == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please select a plan")),
                    );
                    return;
                  }
                  final result = await confirmPayment(context, _planLabel());
                  if (result) {
                    AppRoutes.goToReplace(context, AppRoutes.dashboard);
                  }
                },
              ),
            ],
          ),
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
}
