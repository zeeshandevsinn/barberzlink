import 'dart:ui';

import 'package:barberzlink/core/theme/app_colors.dart';
import 'package:barberzlink/injections.dart';
import 'package:barberzlink/widgets/custom_app_bar.dart';
import 'package:barberzlink/widgets/registrer_selection_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/search_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController keywordController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController zipController = TextEditingController();
  String selectedState = 'All States';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(80.h),
            child: CustomAppBar(title: 'Home')),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// 🔴 Search Container Section
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  image: DecorationImage(
                    image: const AssetImage('assets/images/app_front_page.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                              sigmaX: 6, sigmaY: 6), // adjust blur intensity
                          child: Container(
                            color: Colors.black12
                                .withOpacity(0.5), // red overlay tint
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 10),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(16.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Welcome to Barbershopconnect",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                "Search for barbers, jobs, or schools below:",
                                style: GoogleFonts.poppins(
                                  color: Colors.white70,
                                  fontSize: 13.sp,
                                ),
                              ),
                              SizedBox(height: 16.h),
                              CustomSearchBar(
                                keywordController: keywordController,
                                cityController: cityController,
                                zipController: zipController,
                                selectedState: selectedState,
                                states: Injections.instance.states,
                                onStateChanged: (value) {
                                  setState(() => selectedState = value!);
                                },
                                onSearch: () {
                                  print("Keyword: ${keywordController.text}");
                                  print("City: ${cityController.text}");
                                  print("Zip: ${zipController.text}");
                                  print("State: $selectedState");
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 24.h),

              /// 🧩 Registration Options List
              RegisterSelection()
            ],
          ),
        ),
      ),
    );
  }
}
