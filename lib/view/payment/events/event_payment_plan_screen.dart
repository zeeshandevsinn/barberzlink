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

class EventPaymentPlanScreen extends StatefulWidget {
  const EventPaymentPlanScreen({super.key});

  @override
  State<EventPaymentPlanScreen> createState() => _EventPaymentPlanScreenState();
}

class _EventPaymentPlanScreenState extends State<EventPaymentPlanScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: kIsWeb
            ? AppBar(
                title: const Text("Events Payment Plan"),
                backgroundColor: Colors.white,
                elevation: 1,
                iconTheme: const IconThemeData(color: Colors.black),
              )
            : PreferredSize(
                preferredSize: Size.fromHeight(80),
                child: CustomAppBar(
                  title: "Events Payment Plan",
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
                isSelected: true,
                onTap: () {},
                isPopular: true,
              ),

              SizedBox(height: 40.h),

              CustomButton(
                buttonText: "Continue",
                onTap: () async {
                  final result = await confirmPayment(
                      context, "One-time event payment of \$150?");
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
