// Flutter BarberzLink Splash & Onboarding Screens

import 'package:barberzlink/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _scaleAnim = CurvedAnimation(parent: _controller, curve: Curves.easeOut);

    _controller.forward();

    Future.delayed(const Duration(seconds: 3), () {
      AppRoutes.goToReplace(context, AppRoutes.onboarding);
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ScaleTransition(
          scale: _scaleAnim,
          child: Image.asset(
            'assets/images/barberz_logo.png',
            width: 200.w,
            height: 200.h,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

// class OnboardingScreen extends StatelessWidget {
//   const OnboardingScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     ScreenUtil.init(context);

//     return Scaffold(
//       body: Stack(
//         children: [
//           Positioned.fill(
//             child: Image.asset(
//               'assets/images/app_front_page.png',
//               fit: BoxFit.cover,
//             ),
//           ),
//           Positioned.fill(
//             child: Container(
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [
//                     Colors.black.withOpacity(0.8),
//                     Colors.black.withOpacity(0.3),
//                   ],
//                   begin: Alignment.bottomCenter,
//                   end: Alignment.topCenter,
//                 ),
//               ),
//             ),
//           ),
//           SafeArea(
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: 24.w),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   SizedBox(height: 80.h),
//                   Center(
//                     child: Image.asset(
//                       'assets/images/barberz_logo.png',
//                       width: 160.w,
//                     ),
//                   ),
//                   const Spacer(),
//                   Text(
//                     'Connect. Create. Cut.',
//                     textAlign: TextAlign.center,
//                     style: GoogleFonts.poppins(
//                       color: Colors.white,
//                       fontSize: 26.sp,
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                   SizedBox(height: 10.h),
//                   Text(
//                     'Join the professional BarberzLink community\nwhere barbers and shops grow together.',
//                     textAlign: TextAlign.center,
//                     style: GoogleFonts.poppins(
//                       color: Colors.white70,
//                       fontSize: 14.sp,
//                     ),
//                   ),
//                   SizedBox(height: 60.h),
//                   _buildButton(
//                     title: 'Get Started',
//                     color: Colors.white,
//                     textColor: Colors.black,
//                     onTap: () {
//                       Navigator.pushNamed(context, '/signup');
//                     },
//                   ),
//                   SizedBox(height: 15.h),
//                   _buildButton(
//                     title: 'Login',
//                     color: Colors.transparent,
//                     textColor: Colors.white,
//                     border: true,
//                     onTap: () {
//                       Navigator.pushNamed(context, '/login');
//                     },
//                   ),
//                   SizedBox(height: 40.h),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildButton({
//     required String title,
//     required Color color,
//     required Color textColor,
//     bool border = false,
//     required VoidCallback onTap,
//   }) {
//     return SizedBox(
//       width: double.infinity,
//       height: 50.h,
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: color,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(14.r),
//             side: border
//                 ? const BorderSide(color: Colors.white, width: 1.3)
//                 : BorderSide.none,
//           ),
//         ),
//         onPressed: onTap,
//         child: Text(
//           title,
//           style: GoogleFonts.poppins(
//             color: textColor,
//             fontSize: 16.sp,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ),
//     );
//   }
// }
