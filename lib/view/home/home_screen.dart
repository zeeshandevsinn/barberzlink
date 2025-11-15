import 'package:barberzlink/constants/app_strings.dart';
import 'package:flutter/material.dart';

import '../../core/routes/app_routes.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final TextEditingController keywordController = TextEditingController();
//   final TextEditingController cityController = TextEditingController();
//   final TextEditingController zipController = TextEditingController();
//   String selectedState = 'All States';

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: AppColors.background,
//         appBar: PreferredSize(
//             preferredSize: Size.fromHeight(80),
//             child: CustomAppBar(title: 'Home')),
//         body: SingleChildScrollView(
//           padding: EdgeInsets.all(16.w),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               /// 🔴 Search Container Section
//               Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(12.r),
//                   image: DecorationImage(
//                     image: const AssetImage('assets/images/app_front_page.png'),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(12.r),
//                   child: Stack(
//                     children: [
//                       Positioned.fill(
//                         child: BackdropFilter(
//                           filter: ImageFilter.blur(
//                               sigmaX: 6, sigmaY: 6), // adjust blur intensity
//                           child: Container(
//                             color: Colors.black12
//                                 .withOpacity(0.5), // red overlay tint
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(
//                             vertical: 20.0, horizontal: 10),
//                         child: Container(
//                           width: double.infinity,
//                           padding: EdgeInsets.all(16.w),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 "Welcome to Barberz Link",
//                                 textAlign: TextAlign.center,
//                                 style: GoogleFonts.poppins(
//                                   color: Colors.white,
//                                   fontSize: 20.sp,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               SizedBox(height: 8.h),
//                               Text(
//                                 "Search for barbers, jobs, or schools below:",
//                                 style: GoogleFonts.poppins(
//                                   color: Colors.white70,
//                                   fontSize: 13.sp,
//                                 ),
//                               ),
//                               SizedBox(height: 16.h),
//                               CustomSearchBar(
//                                 keywordController: keywordController,
//                                 cityController: cityController,
//                                 zipController: zipController,
//                                 selectedState: selectedState,
//                                 states: Injections.instance.states,
//                                 onStateChanged: (value) {
//                                   setState(() => selectedState = value!);
//                                 },
//                                 onSearch: () {
//                                   print("Keyword: ${keywordController.text}");
//                                   print("City: ${cityController.text}");
//                                   print("Zip: ${zipController.text}");
//                                   print("State: $selectedState");
//                                 },
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),

//               SizedBox(height: 24.h),

//               /// 🧩 Registration Options List
//               RegisterSelection()
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

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
          SizedBox(
            height: 110,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: widget.categories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final category = widget.categories[index];
                return GestureDetector(
                  onTap: () {
                    AppRoutes.goTo(context, category['route']!);
                  },
                  child: Column(
                    children: [
                      Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage(category['image']!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      SizedBox(
                        width: 80,
                        child: Text(
                          category['title']!,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black87,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 12),

          // Shimmer loading section (for featured services)
        ],
      ),
    );
  }
}
