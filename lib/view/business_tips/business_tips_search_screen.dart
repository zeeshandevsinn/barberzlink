// import 'dart:ui';
// import 'package:barberzlink/constants/app_strings.dart';
// import 'package:barberzlink/core/routes/app_routes.dart';
// import 'package:barberzlink/core/theme/app_colors.dart';
// import 'package:barberzlink/injections.dart';
// import 'package:barberzlink/widgets/custom_app_bar.dart';
// import 'package:barberzlink/widgets/custom_button.dart';
// import 'package:barberzlink/widgets/keyword_search_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';

// class BusinessTipsSearchScreen extends StatefulWidget {
//   const BusinessTipsSearchScreen({super.key});

//   @override
//   State<BusinessTipsSearchScreen> createState() =>
//       _BusinessTipsSearchScreenState();
// }

// class _BusinessTipsSearchScreenState extends State<BusinessTipsSearchScreen> {
//   final TextEditingController keywordController = TextEditingController();
//   String selectedStates = 'All States';

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: AppColors.background,
//         appBar: PreferredSize(
//           preferredSize: const Size.fromHeight(80),
//           child: CustomAppBar(
//             title: 'Search Business Tips',
//             isBack: true,
//           ),
//         ),
//         body: SingleChildScrollView(
//           padding: EdgeInsets.all(16.w),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               /// 🔵 BLURRED SEARCH BANNER
//               Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(12.r),
//                   image: DecorationImage(
//                     image: const AssetImage(AppStrings.businessTipsImage),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(12.r),
//                   child: Stack(
//                     children: [
//                       Positioned.fill(
//                         child: BackdropFilter(
//                           filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
//                           child:
//                               Container(color: Colors.black26.withOpacity(0.4)),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(
//                             vertical: 20, horizontal: 10),
//                         child: Container(
//                           width: double.infinity,
//                           padding: EdgeInsets.all(16.w),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 "Find Trusted Business Tips",
//                                 style: GoogleFonts.poppins(
//                                   color: Colors.white,
//                                   fontSize: 20.sp,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               SizedBox(height: 6.h),
//                               Row(
//                                 children: [
//                                   Icon(Icons.lightbulb,
//                                       color: Colors.white, size: 20.sp),
//                                   SizedBox(width: 6.w),
//                                   Text(
//                                     "Search expert guidance for your growth",
//                                     style: GoogleFonts.poppins(
//                                       color: Colors.white,
//                                       fontSize: 14.sp,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(height: 16.h),

//                               /// 🔍 Keyword Search Bar
//                               KeywordSearchBar(
//                                 keywordController: keywordController,
//                                 selectedState: selectedStates,
//                                 states: Injections.instance.states,
//                                 onStateChanged: (value) {
//                                   setState(() => selectedStates = value!);
//                                 },
//                                 onSearch: () {
//                                   print("Keyword: ${keywordController.text}");
//                                   print("State: $selectedStates");
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

//               /// 🟥 REGISTER BUTTON
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: CustomButton(
//                   buttonText: "Become a Business Tips Partner",
//                   btnColor: Colors.red,
//                   onTap: () {
//                     AppRoutes.goTo(context, AppRoutes.businessTipsRegister);
//                   },
//                 ),
//               ),

//               SizedBox(height: 24.h),

//               /// ⭐ FEATURED TIPS
//               Text(
//                 "Featured Tips",
//                 style: GoogleFonts.poppins(
//                   fontSize: 18.sp,
//                   color: Colors.black87,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               SizedBox(height: 16.h),

//               CarouselSlider(
//                 items: Injections.instance.featuredTips
//                     .map<Widget>((tip) => FeaturedTipCard(tip: tip))
//                     .toList(),
//                 options: CarouselOptions(
//                   height: 180.h,
//                   autoPlay: true,
//                   enlargeCenterPage: true,
//                   viewportFraction: 0.8,
//                   enableInfiniteScroll: true,
//                 ),
//               ),

//               SizedBox(height: 24.h),

//               /// 📋 LIST OF BUSINESS TIPS
//               Text(
//                 "Business Tips",
//                 style: GoogleFonts.poppins(
//                   fontSize: 18.sp,
//                   color: Colors.black87,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               SizedBox(height: 12.h),

//               ListView.builder(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemCount: Injections.instance.businessTips.length,
//                 itemBuilder: (context, index) {
//                   final tip = Injections.instance.businessTips[index];
//                   return Padding(
//                     padding: const EdgeInsets.only(bottom: 12.0),
//                     child: BusinessTipCard(
//                       imagePath: tip['image']!,
//                       title: tip['title']!,
//                       category: tip['category']!,
//                       onTap: () {
//                         AppRoutes.goTo(context, AppRoutes.businessTipsDetails);
//                       },
//                     ),
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// /// ---------------- CUSTOM BUSINESS TIP CARD -----------------
// class BusinessTipCard extends StatelessWidget {
//   final String imagePath;
//   final String title;
//   final String category;
//   final VoidCallback onTap;

//   const BusinessTipCard({
//     super.key,
//     required this.imagePath,
//     required this.title,
//     required this.category,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(16.r),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.08),
//               blurRadius: 6,
//               offset: const Offset(0, 3),
//             ),
//           ],
//         ),
//         child: Row(
//           children: [
//             /// Image
//             ClipRRect(
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(16.r),
//                 bottomLeft: Radius.circular(16.r),
//               ),
//               child: Image.asset(
//                 imagePath,
//                 width: 100.w,
//                 height: 100.w,
//                 fit: BoxFit.cover,
//               ),
//             ),

//             /// Title & Category
//             Expanded(
//               child: Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       title,
//                       style: GoogleFonts.poppins(
//                         fontSize: 15.sp,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     SizedBox(height: 6.h),
//                     Text(
//                       category,
//                       style: GoogleFonts.poppins(
//                         fontSize: 13.sp,
//                         color: Colors.grey.shade600,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// /// ---------------- FEATURED TIP CARD -----------------
// class FeaturedTipCard extends StatelessWidget {
//   final Map<String, String> tip;
//   const FeaturedTipCard({super.key, required this.tip});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       margin: EdgeInsets.symmetric(horizontal: 4.w),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(16.r),
//         image: DecorationImage(
//           image: AssetImage(tip['image']!),
//           fit: BoxFit.cover,
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.08),
//             blurRadius: 6,
//             offset: const Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Container(
//         padding: EdgeInsets.all(12.w),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(16.r),
//           gradient: LinearGradient(
//             colors: [Colors.black.withOpacity(0.4), Colors.transparent],
//             begin: Alignment.bottomCenter,
//             end: Alignment.topCenter,
//           ),
//         ),
//         alignment: Alignment.bottomLeft,
//         child: Text(
//           tip['title']!,
//           style: GoogleFonts.poppins(
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//             fontSize: 14.sp,
//           ),
//         ),
//       ),
//     );
//   }
// }
