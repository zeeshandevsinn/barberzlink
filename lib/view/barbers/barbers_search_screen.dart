import 'dart:ui';

import 'package:barberzlink/constants/app_strings.dart';
import 'package:barberzlink/core/theme/app_colors.dart';
import 'package:barberzlink/injections.dart';
import 'package:barberzlink/widgets/custom_app_bar.dart';
import 'package:barberzlink/widgets/custom_list_card.dart';
import 'package:barberzlink/widgets/keyword_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class BarbersSearchScreen extends StatefulWidget {
  const BarbersSearchScreen({super.key});

  @override
  State<BarbersSearchScreen> createState() => _BarbersSearchScreenState();
}

class _BarbersSearchScreenState extends State<BarbersSearchScreen> {
  final TextEditingController keywordController = TextEditingController();
  String selectedState = 'All States';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(80),
            child: CustomAppBar(
              title: 'Our Barbers',
              isBack: true,
            )),
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
                    image: const AssetImage(AppStrings.barbershopImage),
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
                                "Welcome to Our Barbers",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: Colors.white,
                                    size: 20.sp,
                                  ),
                                  SizedBox(width: 6.w),
                                  Text(
                                    "Find the best barbers near you",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16.h),
                              KeywordSearchBar(
                                keywordController: keywordController,
                                selectedState: selectedState,
                                states: Injections.instance.states,
                                onStateChanged: (value) {
                                  setState(() => selectedState = value!);
                                },
                                onSearch: () {
                                  print("Keyword: ${keywordController.text}");

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
              ListView.builder(
                shrinkWrap: true, // ✅ tells Flutter to size based on children
                physics: const NeverScrollableScrollPhysics(),
                itemCount: Injections.instance.barbersData.length,
                itemBuilder: (context, index) {
                  final barber = Injections.instance.barbersData[index];
                  final imagePath = barber['image']!;
                  final name = barber['name']!;
                  final location = barber['location']!;
                  void onPressed() {
                    print('Tapped on $name');
                  }

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomListCard(
                        imagePath: imagePath,
                        name: name,
                        location: location,
                        onPressed: onPressed),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
