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

class BusinessTipsPaymentScreen extends StatefulWidget {
  const BusinessTipsPaymentScreen({super.key});

  @override
  State<BusinessTipsPaymentScreen> createState() =>
      _BusinessTipsPaymentScreenState();
}

class _BusinessTipsPaymentScreenState extends State<BusinessTipsPaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: kIsWeb
            ? AppBar(
                title: const Text("Business Resource Payment Plan"),
                backgroundColor: Colors.white,
                elevation: 1,
                iconTheme: const IconThemeData(color: Colors.black),
              )
            : PreferredSize(
                preferredSize: Size.fromHeight(80),
                child: CustomAppBar(
                  title: "Business Resource Payment Plan",
                  isBack: true,
                ),
              ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            children: [
              /// HEADER TITLE
              Center(
                child: Column(
                  children: [
                    Text(
                      "BarberzLink.com",
                      style: AppTextStyle.bold(fontSize: 24.sp),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      "Business Resources – Financial / Insurance / Investment",
                      style: AppTextStyle.medium(
                        fontSize: 16.sp,
                        color: AppColors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 32.h),

              /// BUSINESS PLAN CARD
              PlanCard(
                title: "Full Access",
                subtitle: "\$29.99/month",
                description:
                    "Get insider Business Resources to grow, protect, and scale your barbershop.",
                features: [
                  "Financial guidance for barbers",
                  "Access to insurance partners",
                  "Investment growth strategies",
                  "Connect with business advisors",
                  "Exclusive monthly webinars",
                ],
                price: "\$29.99",
                priceSubtext: "Monthly membership",
                isSelected: true,
                isPopular: true,
                onTap: () {},
              ),

              SizedBox(height: 40.h),

              /// CONTINUE BUTTON
              CustomButton(
                buttonText: "Continue",
                onTap: () async {
                  final result = await confirmPayment(
                    context,
                    "Confirm Business Resources Subscription (\$29.99/month)?",
                  );

                  if (result) {
                    AppRoutes.goToReplace(
                      context,
                      AppRoutes.dashboard,
                      arguments: 0,
                    );
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
