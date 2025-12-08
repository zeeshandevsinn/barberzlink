import 'dart:ui';

import 'package:barberzlink/constants/app_strings.dart';
import 'package:barberzlink/core/routes/app_routes.dart';
import 'package:barberzlink/core/theme/app_colors.dart';
import 'package:barberzlink/injections.dart';
import 'package:barberzlink/widgets/custom_app_bar.dart';
import 'package:barberzlink/widgets/custom_barbershop_card.dart';
import 'package:barberzlink/widgets/search_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class BarbershopSearchScreen extends StatefulWidget {
  const BarbershopSearchScreen({super.key});

  @override
  State<BarbershopSearchScreen> createState() => _BarbershopSearchScreenState();
}

class _BarbershopSearchScreenState extends State<BarbershopSearchScreen> {
  final TextEditingController keywordController = TextEditingController();
  final TextEditingController cityAndZipController = TextEditingController();

  String selectedState = 'All States';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: kIsWeb
            ? AppBar(
                title: Text("Barbers Shop Search"),
                centerTitle: true,
              )
            : PreferredSize(
                preferredSize: Size.fromHeight(80),
                child:
                    CustomAppBar(title: 'Barbers Shop Search', isBack: true)),
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
                                "Welcome to Barbers Shop",
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
                                    "Find the best barber shop near you",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      16.w, 20.h, 16.w, 16.h),
                                  child: CustomSearchBar(
                                      keywordController: keywordController,
                                      cityController: cityAndZipController,
                                      selectedState: selectedState,
                                      states: Injections.instance.states,
                                      onStateChanged: (e) {
                                        setState(() {
                                          selectedState = e ?? '';
                                        });
                                      },
                                      onSearch: () {}))
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
                itemCount: Injections.instance.barberShopsData.length,
                itemBuilder: (context, index) {
                  final barber = Injections.instance.barberShopsData[index];
                  final imagePath =
                      barber['image'] ?? AppStrings.barbershopImage;
                  final name = barber['name'] ?? 'Unknown Barber';
                  final location =
                      barber['location'] ?? 'Location not available';
                  final owner = barber['owner'] ?? 'Owner not specified';
                  final rating = barber['rating'] ?? 0.0;
                  final description = barber['description'] ?? '';

                  void onPressed() {
                    AppRoutes.goTo(context, AppRoutes.barberShop_detail);
                  }

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomBarberShopCard(
                        imagePath: imagePath,
                        name: name,
                        owner: owner,
                        location: location,
                        rating: double.parse(rating.toStringAsFixed(1)),
                        description: description,
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
