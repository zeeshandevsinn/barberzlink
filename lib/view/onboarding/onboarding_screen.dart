// lib/presentation/screens/splash_onboarding.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/routes/app_routes.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/app_front_page.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.8),
                    Colors.black.withOpacity(0.3),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'BarberzLink',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 26.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 80.h),
                  const Spacer(),
                  Text(
                    'Connect, Hire, Grow.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 26.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    'Join the professional BarberzLink community\nwhere barbers and shops grow together.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      color: Colors.white70,
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(height: 60.h),
                  _buildButton(
                    title: 'Get Started',
                    color: Colors.white,
                    textColor: Colors.black,
                    onTap: () {
                      AppRoutes.goTo(context, AppRoutes.registration);
                    },
                  ),
                  SizedBox(height: 15.h),
                  _buildButton(
                    title: 'Login',
                    color: Colors.transparent,
                    textColor: Colors.white,
                    border: true,
                    onTap: () {
                      AppRoutes.goTo(context, AppRoutes.login);
                    },
                  ),
                  SizedBox(height: 40.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton({
    required String title,
    required Color color,
    required Color textColor,
    bool border = false,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 50.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.r),
            side: border
                ? const BorderSide(color: Colors.white, width: 1.3)
                : BorderSide.none,
          ),
        ),
        onPressed: onTap,
        child: Text(
          title,
          style: TextStyle(
            color: textColor,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
