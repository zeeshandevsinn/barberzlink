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

class BarberShopPaymentPlanScreen extends StatefulWidget {
  const BarberShopPaymentPlanScreen({super.key});

  @override
  State<BarberShopPaymentPlanScreen> createState() =>
      _BarberShopPaymentPlanScreenState();
}

class _BarberShopPaymentPlanScreenState
    extends State<BarberShopPaymentPlanScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: kIsWeb
            ? AppBar(
                title: const Text("Barbershop Payment Plan"),
                backgroundColor: Colors.white,
                elevation: 1,
                iconTheme: const IconThemeData(color: Colors.black),
              )
            : PreferredSize(
                preferredSize: Size.fromHeight(80),
                child: CustomAppBar(
                  title: "Barbershop Payment Plan",
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
                isSelected: true,
                onTap: () {},
                isPopular: true,
              ),

              SizedBox(height: 40.h),

              CustomButton(
                buttonText: "Continue",
                onTap: () async {
                  final result = await confirmPayment(
                      context, "Full Access (\$19.99/month)?");
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
