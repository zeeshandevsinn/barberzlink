import 'dart:ui';

import 'package:barberzlink/constants/app_strings.dart';
import 'package:barberzlink/core/routes/app_routes.dart';
import 'package:barberzlink/core/theme/app_colors.dart';
import 'package:barberzlink/injections.dart';
import 'package:barberzlink/widgets/custom_app_bar.dart';
import 'package:barberzlink/widgets/custom_button.dart';
import 'package:barberzlink/widgets/custom_list_card.dart';
import 'package:barberzlink/widgets/featured_product_card.dart';
import 'package:barberzlink/widgets/keyword_search_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class NewProductSearchScreen extends StatefulWidget {
  const NewProductSearchScreen({super.key});

  @override
  State<NewProductSearchScreen> createState() => _NewProductSearchScreenState();
}

class _NewProductSearchScreenState extends State<NewProductSearchScreen> {
  final TextEditingController keywordController = TextEditingController();
  String selectedStates = 'All States';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: CustomAppBar(
            title: 'Search Products',
            isBack: true,
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// 🔴 Search Container
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  image: DecorationImage(
                    image: const AssetImage(AppStrings.newProductImage),
                    fit: BoxFit.cover,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                          child:
                              Container(color: Colors.black12.withOpacity(0.5)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 10),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(16.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Find the Best Products",
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
                                  Icon(Icons.search,
                                      color: Colors.white, size: 20.sp),
                                  SizedBox(width: 5.w),
                                  Text(
                                    "Search quality products easily",
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16.h),

                              /// 🔎 Keyword Search Bar
                              KeywordSearchBar(
                                keywordController: keywordController,
                                selectedState: selectedStates,
                                states: Injections.instance.states,
                                onStateChanged: (value) {
                                  setState(() => selectedStates = value!);
                                },
                                onSearch: () {
                                  print("Keyword: ${keywordController.text}");
                                  print("Category: $selectedStates");
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: CustomButton(
                  buttonText: 'Register Now',
                  btnColor: Colors.red,
                  onTap: () {
                    AppRoutes.goTo(context, AppRoutes.newProductRegister);
                  },
                ),
              ),
              SizedBox(height: 24.h),

              /// 🟦 NEW SECTION — Options for Registration
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Featured Products",
                  style: GoogleFonts.poppins(
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                    fontSize: 18.sp,
                  ),
                ),
              ),
              SizedBox(height: 12.h),

              CarouselSlider(
                options: CarouselOptions(
                  height: 320.h,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 4),
                  viewportFraction: 0.82,
                ),
                items: Injections.instance.featuredProducts.map((product) {
                  return FeaturedProductCard(
                    image: product["image"],
                    title: product["title"],
                    subtitle: product["subtitle"],
                    onTap: () {
                      AppRoutes.goTo(context, product["route"]);
                    },
                  );
                }).toList(),
              ),

              SizedBox(height: 24.h),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Products",
                  style: GoogleFonts.poppins(
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                    fontSize: 18.sp,
                  ),
                ),
              ),
              SizedBox(height: 12.h),

              /// 🧩 Product List Section
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: Injections.instance.products.length,
                itemBuilder: (context, index) {
                  final product = Injections.instance.products[index];

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomListCard(
                      imagePath: product['image']!,
                      name: product['name']!,
                      location: product['type']!,
                      onPressed: () {
                        AppRoutes.goTo(context, AppRoutes.productDetails);
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
