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

class SchoolPaymentPlanScreen extends StatefulWidget {
  const SchoolPaymentPlanScreen({super.key});

  @override
  State<SchoolPaymentPlanScreen> createState() =>
      _SchoolPaymentPlanScreenState();
}

class _SchoolPaymentPlanScreenState extends State<SchoolPaymentPlanScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: kIsWeb
            ? AppBar(
                title: const Text("Schools Payment Plan"),
                backgroundColor: Colors.white,
                elevation: 1,
                iconTheme: const IconThemeData(color: Colors.black),
              )
            : PreferredSize(
                preferredSize: Size.fromHeight(80),
                child: CustomAppBar(
                  title: "Schools Payment Plan",
                  isBack: true,
                )),
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
                      "Schools – Full Access Subscription",
                      style: AppTextStyle.medium(
                        fontSize: 16.sp,
                        color: AppColors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32.h),

              /// SINGLE SCHOOL PLAN
              PlanCard(
                title: "Full Access",
                subtitle: "\$50.00/month",
                description:
                    "Grow admissions and connect schools with barbershops.",
                features: [
                  "Create verified school profile",
                  "Add your courses & programs",
                  "Post student events",
                  "Message barbershops for apprenticeships",
                ],
                price: "\$50.00",
                priceSubtext: "Monthly membership",
                isSelected: true,
                onTap: () {},
                isPopular: true,
              ),

              SizedBox(height: 40.h),

              CustomButton(
                buttonText: "Continue",
                onTap: () async {
                  final result = await confirmPayment(
                      context, "Monthly School Subscription (\$50/month)?");
                  if (result) {
                    AppRoutes.goToReplace(context, AppRoutes.dashboard,
                        arguments: 0);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
