import 'package:barberzlink/constants/app_strings.dart';
import 'package:barberzlink/core/routes/app_routes.dart';
import 'package:barberzlink/core/theme/app_theme.dart';
import 'package:barberzlink/injections.dart';
import 'package:barberzlink/widgets/custom_home_tile.dart';
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
  bool _isLoading = true; // Simulate loading state
  bool _isCategoriesLoading = true;

  @override
  void initState() {
    super.initState();
    // Simulate data loading
    _simulateDataLoading();
  }

  void _simulateDataLoading() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      _isLoading = false;
    });

    await Future.delayed(Duration(seconds: 1));
    setState(() {
      _isCategoriesLoading = false;
    });

    await Future.delayed(Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            // 🔄 SHIMMER FOR TOP LOGO SECTION
            _isLoading
                ? _buildLogoShimmer()
                : Padding(
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

            const SizedBox(height: 16),

            // 🔄 SHIMMER FOR SEARCH BAR
            _isLoading
                ? _buildSearchBarShimmer()
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: GestureDetector(
                      onTap: () {
                        AppRoutes.goTo(context, AppRoutes.dashboard,
                            arguments: 1);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 12),
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

            // 🔄 SHIMMER FOR CATEGORIES CAROUSEL
            _isCategoriesLoading
                ? _buildCategoriesShimmer()
                : CarouselSlider.builder(
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
                                style: TextStyle(
                                    fontSize: 11.sp, color: Colors.black87),
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
                      // enlargeCenterPage: false,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 2),
                      autoPlayAnimationDuration: Duration(milliseconds: 900),
                    ),
                  ),

            Divider(color: Colors.grey[300], thickness: 1),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Text(
                    "Barbers",
                    style: AppTextStyle.semiBold(),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),

            //Barbers Carousel Slider
            CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                // enlargeCenterPage: true,

                height: 180.spMax,
                viewportFraction: 0.82,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
              ),
              items: Injections.instance.barbersData.map((doc) {
                return Builder(
                  builder: (BuildContext context) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6.0),
                      child: CustomHomeTile(
                        imageUrl: doc['image'] ?? '',
                        name: doc['name'] ?? '',
                        specialization: "Barber Specialist",
                        isVerified: true,
                        onEmailPressed: () {
                          print('Email pressed for ${doc['name']}');
                        },
                        onContactPressed: () {
                          print('Contact pressed for ${doc['name']}');
                        },
                        onPressed: () {
                          AppRoutes.goTo(context, AppRoutes.barber_detail);
                        },
                      ),
                    );
                  },
                );
              }).toList(),
            ),

            SizedBox(height: 16),
            Divider(color: Colors.grey[300], thickness: 1),

            //BarberShops Section
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Text(
                    "BarberShops",
                    style: AppTextStyle.semiBold(),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),

            //Barbers Carousel Slider
            CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                // enlargeCenterPage: true,

                height: 180.spMax,
                viewportFraction: 0.82,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
              ),
              items: Injections.instance.barberShopsData.map((doc) {
                return Builder(
                  builder: (BuildContext context) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6.0),
                      child: CustomHomeTile(
                        imageUrl: doc['image'] ?? '',
                        name: doc['name'] ?? '',
                        specialization: "BarberShop Specialist",
                        isVerified: true,
                        onEmailPressed: () {
                          print('Email pressed for ${doc['name']}');
                        },
                        onContactPressed: () {
                          print('Contact pressed for ${doc['name']}');
                        },
                        onPressed: () {
                          AppRoutes.goTo(context, AppRoutes.barberShop_detail);
                        },
                      ),
                    );
                  },
                );
              }).toList(),
            ),

            SizedBox(height: 16),
            Divider(color: Colors.grey[300], thickness: 1),

            const SizedBox(height: 20),

            // Events Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Text(
                    "Events",
                    style: AppTextStyle.semiBold(),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),

            //Barbers Carousel Slider
            CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                // enlargeCenterPage: true,

                height: 180.spMax,
                viewportFraction: 0.82,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
              ),
              items: Injections.instance.eventsData.map((doc) {
                return Builder(
                  builder: (BuildContext context) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6.0),
                      child: CustomHomeTile(
                        imageUrl: doc['image'] ?? '',
                        name: doc['title'] ?? '',
                        specialization: '${doc['address'] ?? ''}',
                        isVerified: true,
                        onEmailPressed: () {
                          print('Email pressed for ${doc['title']}');
                        },
                        onContactPressed: () {
                          print('Contact pressed for ${doc['title']}');
                        },
                        onPressed: () {
                          AppRoutes.goTo(context, AppRoutes.event_detail);
                        },
                      ),
                    );
                  },
                );
              }).toList(),
            ),

            SizedBox(height: 16),
            Divider(color: Colors.grey[300], thickness: 1),

            //Schools Section
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Text(
                    "Schools",
                    style: AppTextStyle.semiBold(),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),

//Barbers Carousel Slider
            CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                height: 180.spMax,
                // enlargeCenterPage: true,
                viewportFraction: 0.82,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
              ),
              items: Injections.instance.schoolsData.map((doc) {
                return Builder(
                  builder: (BuildContext context) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6.0),
                      child: CustomHomeTile(
                        imageUrl: doc['image'] ?? '',
                        name: doc['name'] ?? '',
                        specialization: doc['location'] ?? '',
                        isVerified: true,
                        onEmailPressed: () {
                          print('Email pressed for ${doc['name']}');
                        },
                        onContactPressed: () {
                          print('Contact pressed for ${doc['name']}');
                        },
                        onPressed: () {
                          AppRoutes.goTo(context, AppRoutes.school_detail);
                        },
                      ),
                    );
                  },
                );
              }).toList(),
            ),

            SizedBox(height: 16),
            Divider(color: Colors.grey[300], thickness: 1),

            const SizedBox(height: 20),

            //Featured Products Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Text(
                    "Featured Products",
                    style: AppTextStyle.semiBold(),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),

//Barbers Carousel Slider
            CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                // enlargeCenterPage: true,

                height: 180.spMax,
                viewportFraction: 0.82,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
              ),
              items: Injections.instance.featuredProducts.map((doc) {
                return Builder(
                  builder: (BuildContext context) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6.0),
                      child: CustomHomeTile(
                        imageUrl: doc['image'] ?? '',
                        name: doc['title'] ?? '',
                        specialization: doc['subtitle'] ?? '',
                        isVerified: true,
                        onEmailPressed: () {
                          print('Email pressed for ${doc['title']}');
                        },
                        onContactPressed: () {
                          print('Contact pressed for ${doc['title']}');
                        },
                        onPressed: () {
                          AppRoutes.goTo(context, AppRoutes.productDetails);
                        },
                      ),
                    );
                  },
                );
              }).toList(),
            ),

            SizedBox(height: 16),
            Divider(color: Colors.grey[300], thickness: 1),
            //  Tiles of the featured items can go here
            //Like showing first heading and then horizontal list of featured items
          ],
        ),
      ),
    );
  }

  // 🎨 SHIMMER EFFECTS FOR DIFFERENT SECTIONS

  Widget _buildLogoShimmer() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        children: [
          ShimmerEffect.circular(
            width: 100,
            height: 100,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerEffect.rectangular(
                  height: 20,
                  width: 150,
                ),
                SizedBox(height: 8),
                ShimmerEffect.rectangular(
                  height: 16,
                  width: 100,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBarShimmer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ShimmerEffect.rectangular(
        height: 50,
        // shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(12), width: 280.w,
      ),
    );
  }

  Widget _buildCategoriesShimmer() {
    return SizedBox(
      height: 120.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 6, // Show 6 shimmer items
        itemBuilder: (context, index) {
          return Container(
            width: 80.w,
            margin: EdgeInsets.symmetric(horizontal: 8.w),
            child: Column(
              children: [
                ShimmerEffect.circular(
                  width: 60.h,
                  height: 60.h,
                ),
                SizedBox(height: 8.h),
                ShimmerEffect.rectangular(
                  height: 12.h,
                  width: 60.w,
                ),
                SizedBox(height: 4.h),
                ShimmerEffect.rectangular(
                  height: 10.h,
                  width: 40.w,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
