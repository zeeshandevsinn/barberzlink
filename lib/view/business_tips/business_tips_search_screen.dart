import 'dart:ui';
import 'package:barberzlink/constants/app_strings.dart';
import 'package:barberzlink/core/routes/app_routes.dart';
import 'package:barberzlink/core/theme/app_colors.dart';
import 'package:barberzlink/core/theme/app_theme.dart';
import 'package:barberzlink/injections.dart';
import 'package:barberzlink/widgets/business_tips_card.dart';
import 'package:barberzlink/widgets/custom_app_bar.dart';
import 'package:barberzlink/widgets/custom_button.dart';
import 'package:barberzlink/widgets/keyword_search_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class BusinessTipsSearchScreen extends StatefulWidget {
  const BusinessTipsSearchScreen({super.key});

  @override
  State<BusinessTipsSearchScreen> createState() =>
      _BusinessTipsSearchScreenState();
}

class _BusinessTipsSearchScreenState extends State<BusinessTipsSearchScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController keywordController = TextEditingController();
  String selectedStates = 'All States';

  late AnimationController _controller;
  late Animation<double> fadeAnimation;
  late Animation<Offset> slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 650))
      ..forward();

    fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    keywordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: kIsWeb
            ? AppBar(
                title: Text("Search Business Tips"),
                centerTitle: true,
                elevation: 1,
              )
            : PreferredSize(
                preferredSize: const Size.fromHeight(80),
                child: CustomAppBar(
                  title: 'Search Business Tips',
                  isBack: true,
                ),
              ),
        body: FadeTransition(
          opacity: fadeAnimation,
          child: SlideTransition(
            position: slideAnimation,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// 🔵 GLASS SEARCH BANNER (Upgraded)
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14.r),
                      image: DecorationImage(
                        image: const AssetImage(AppStrings.businessTipsImage),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14.r),
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                              child: Container(
                                color: Colors.black45.withOpacity(0.3),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(20.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Find Trusted Business Tips",
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 22.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),

                                SizedBox(height: 6.h),

                                Row(
                                  children: [
                                    Icon(Icons.lightbulb,
                                        color: Colors.white70, size: 18.sp),
                                    SizedBox(width: 6.w),
                                    Expanded(
                                      child: Text(
                                        AppStrings.businessTipsDescription,
                                        style: GoogleFonts.poppins(
                                          color: Colors.white70,
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(height: 20.h),

                                /// 🔍 Keyword Search Bar
                                KeywordSearchBar(
                                  keywordController: keywordController,
                                  selectedState: selectedStates,
                                  states: Injections.instance.states,
                                  onStateChanged: (value) {
                                    setState(() => selectedStates = value!);
                                  },
                                  onSearch: () {
                                    print("Keyword: ${keywordController.text}");
                                    print("State: $selectedStates");
                                  },
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 50.h),

                  Text(
                    "Become a Business Tips Partner",
                    style: AppTextStyle.semiBold(),
                  ),

                  /// 🟥 REGISTER BUTTON
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: CustomButton(
                      buttonText: "Register Now",
                      btnColor: Colors.red,
                      onTap: () {
                        AppRoutes.goTo(
                            context, AppRoutes.business_registration);
                      },
                    ),
                  ),

                  SizedBox(height: 50.h),

                  /// ⭐ FEATURED TIPS

                  /// 📋 BUSINESS TIPS LIST
                  Text(
                    "Business Tips",
                    style: GoogleFonts.poppins(
                      fontSize: 18.sp,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  SizedBox(height: 12.h),

                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: Injections.instance.mockBusinessTipsList.length,
                    itemBuilder: (context, index) {
                      final tip =
                          Injections.instance.mockBusinessTipsList[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: BusinessTipCard(
                          imagePath: tip.logoUrl ?? '',
                          title: tip.businessName,
                          category: tip.address,
                          onTap: () {
                            AppRoutes.goTo(context, AppRoutes.business_detail);
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
