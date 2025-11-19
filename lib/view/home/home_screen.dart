import 'package:barberzlink/constants/app_strings.dart';
import 'package:barberzlink/core/routes/app_routes.dart';
import 'package:barberzlink/widgets/shimmer_effect.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  final List<Map<String, String>> categories;
  const HomeScreen({super.key, required this.categories});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          // Top logo
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              children: [
                Image.asset(
                  AppStrings.appLogo,
                  height: 100,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 8),
                Text(
                  'Barberz Link',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),

          // Search bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GestureDetector(
              onTap: () {},
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF4F4F4),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.search, color: Colors.grey),
                    SizedBox(width: 8),
                    Text(
                      'Search',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Horizontal scroll for categories
          CarouselSlider.builder(
            itemCount: widget.categories.length,
            itemBuilder: (context, index, realIndex) {
              final category = widget.categories[index];

              return GestureDetector(
                onTap: () {
                  AppRoutes.goTo(context, category['route']!);
                },
                child: Column(
                  children: [
                    Container(
                      height: 60.h,
                      width: 60.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(category['image']!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    SizedBox(
                      width: 70.w,
                      child: Text(
                        category['title']!,
                        style:
                            TextStyle(fontSize: 11.sp, color: Colors.black87),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              );
            },
            options: CarouselOptions(
              height: 120.h,
              viewportFraction: 0.28,
              enlargeCenterPage: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 2),
              autoPlayAnimationDuration: Duration(milliseconds: 900),
            ),
          ),

          const SizedBox(height: 12),

          ShimmerEffect()
          // Shimmer loading section (for featured services)
        ],
      ),
    );
  }
}
