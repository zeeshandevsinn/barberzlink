import 'package:barberzlink/constants/app_strings.dart';
import 'package:barberzlink/core/theme/app_theme.dart';
import 'package:barberzlink/widgets/custom_app_bar.dart';
import 'package:barberzlink/widgets/registrer_selection_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegistrationSelectionScreen extends StatelessWidget {
  const RegistrationSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: CustomAppBar(
            title: "Registration",
          )),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// ---------- HEADER ----------
            Text(AppStrings.registrationPrompt,
                textAlign: TextAlign.center,
                style: AppTextStyle.bold(fontSize: 24.sp)),
            SizedBox(height: 8.h),
            Container(
              width: 60.w,
              height: 2.h,
              color: Colors.black,
            ),
            SizedBox(height: 16.h),

            /// ---------- DESCRIPTION ----------
            Text(
              'BarberzLink.com is a premier digital platform serving barbers, cosmetologists, and grooming professionals worldwide. '
              'As a central hub for the hair industry, it empowers artists to showcase their work, discover career opportunities, promote barbershops and barber schools, and connect with a global audience passionate about men’s grooming and beauty culture.\n\n'
              'In addition to its robust online presence, BarberzLink functions as a curated storefront for discovering cutting-edge grooming products, offers educational content through tutorials and product features, and fosters community growth through events and mentorship programs.\n\n'
              'With over 1.1 million followers on Instagram and more than 19.5 million user-generated tags, BarberzLink is a driving force in setting trends, elevating talent, and shaping the evolving narrative of the barbering and cosmetology industries.\n\n'
              'Trusted by major brands, BarberzLink has successfully executed campaigns for Microsoft, Avión Tequila, Gillette, New Line Cinema, Andis Company, BaBylissPRO, and Suavecito, among others—cementing its status as a cultural staple in the global grooming community.',
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.black87,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30.h),

            /// ---------- SELECTION CARDS ----------
            RegisterSelection()
          ],
        ),
      ),
    );
  }
}
